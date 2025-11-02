import { supabase } from '@/lib/supabase';
import { NextRequest, NextResponse } from 'next/server';
import { fetchCandidatesForAddress } from '@/lib/googleCivic';

interface UserResponse {
  issueId: string;
  position: number;
  importance: number;
}

interface CandidatePosition {
  issue_id: string;
  position: number;
}

interface Candidate {
  id?: string;
  name: string;
  office: string;
  party: string;
  bio?: string;
  zip_codes?: string[];
  candidateUrl?: string;
  source: 'google_civic' | 'database' | 'hybrid';
}

interface CandidateWithMatch extends Candidate {
  matchScore: number;
  matchPercentage: number;
  agreementDetails: {
    issueId: string;
    userPosition: number;
    candidatePosition: number;
    importance: number;
    difference: number;
  }[];
  hasPositionData: boolean;
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { zipCode, responses, address } = body as {
      zipCode: string;
      address?: string;
      responses: UserResponse[];
    };

    if (!responses || responses.length === 0) {
      return NextResponse.json(
        { success: false, error: 'Missing required parameters' },
        { status: 400 }
      );
    }

    const searchAddress = address || zipCode;
    let allCandidates: Candidate[] = [];

    // Try to fetch from Google Civic API first
    const civicData = await fetchCandidatesForAddress(searchAddress);

    if (civicData?.contests) {
      // Process Google Civic API candidates
      for (const contest of civicData.contests) {
        // Only include local/state races (exclude federal)
        const isLocalOrState = !contest.level?.includes('country');

        if (isLocalOrState && contest.candidates) {
          for (const civicCandidate of contest.candidates) {
            // Try to find matching candidate in database
            const { data: dbCandidates } = await supabase
              .from('candidates')
              .select('*')
              .ilike('name', `%${civicCandidate.name}%`)
              .ilike('office', `%${contest.office}%`)
              .limit(1);

            const dbMatch = dbCandidates?.[0];

            allCandidates.push({
              id: dbMatch?.id,
              name: civicCandidate.name,
              office: contest.office,
              party: civicCandidate.party || dbMatch?.party || 'Unknown',
              bio: dbMatch?.bio,
              candidateUrl: civicCandidate.candidateUrl || dbMatch?.website_url,
              zip_codes: dbMatch?.zip_codes,
              source: dbMatch ? 'hybrid' : 'google_civic',
            });
          }
        }
      }
    }

    // Fallback: fetch from database if no Civic API data
    if (allCandidates.length === 0 && zipCode) {
      const { data: dbCandidates, error: candidatesError } = await supabase
        .from('candidates')
        .select('*')
        .contains('zip_codes', [zipCode]);

      if (candidatesError) {
        return NextResponse.json(
          { success: false, error: candidatesError.message },
          { status: 500 }
        );
      }

      allCandidates = (dbCandidates || []).map(c => ({
        ...c,
        source: 'database' as const,
      }));
    }

    if (allCandidates.length === 0) {
      return NextResponse.json({
        success: true,
        matches: [],
        message: 'No candidates found for your area',
      });
    }

    // Fetch positions for candidates that have database IDs
    const candidateIds = allCandidates.filter(c => c.id).map(c => c.id);
    let candidatePositions: CandidatePosition[] = [];

    if (candidateIds.length > 0) {
      const { data, error: positionsError } = await supabase
        .from('candidate_positions')
        .select('candidate_id, issue_id, position')
        .in('candidate_id', candidateIds as string[]);

      if (positionsError) {
        return NextResponse.json(
          { success: false, error: positionsError.message },
          { status: 500 }
        );
      }

      candidatePositions = data || [];
    }

    // Calculate match scores for each candidate
    const candidatesWithMatches: CandidateWithMatch[] = allCandidates.map((candidate: Candidate) => {
      const candidateIssuePositions = candidate.id
        ? candidatePositions.filter(cp => cp.candidate_id === candidate.id)
        : [];

      // Create a map of candidate positions by issue
      const positionMap = new Map<string, number>();
      candidateIssuePositions.forEach((cp: CandidatePosition) => {
        positionMap.set(cp.issue_id, cp.position);
      });

      let totalWeightedDistance = 0;
      let totalWeight = 0;
      const agreementDetails: CandidateWithMatch['agreementDetails'] = [];

      // Calculate weighted distance for each issue
      responses.forEach((response) => {
        const candidatePosition = positionMap.get(response.issueId);

        // If candidate has no position on this issue, use neutral (3) as default
        const candidatePos = candidatePosition ?? 3;
        const userPos = response.position;
        const importance = response.importance;

        // Calculate absolute difference (0-4 scale)
        const difference = Math.abs(candidatePos - userPos);

        // Weight the difference by importance
        const weightedDistance = difference * importance;

        totalWeightedDistance += weightedDistance;
        totalWeight += importance;

        agreementDetails.push({
          issueId: response.issueId,
          userPosition: userPos,
          candidatePosition: candidatePos,
          importance: importance,
          difference: difference,
        });
      });

      // Calculate match score (0-100)
      // Maximum possible weighted distance is 4 (max difference) * 5 (max importance) * number of issues
      const maxPossibleDistance = 4 * 5 * responses.length;
      const matchScore = totalWeight > 0
        ? Math.max(0, 100 - (totalWeightedDistance / maxPossibleDistance) * 100)
        : 0;

      return {
        ...candidate,
        matchScore,
        matchPercentage: Math.round(matchScore),
        agreementDetails,
        hasPositionData: candidateIssuePositions.length > 0,
      };
    });

    // Sort by match score (highest first)
    candidatesWithMatches.sort((a, b) => b.matchScore - a.matchScore);

    return NextResponse.json({
      success: true,
      matches: candidatesWithMatches,
    });
  } catch (error) {
    console.error('Error matching candidates:', error);
    return NextResponse.json(
      { success: false, error: String(error) },
      { status: 500 }
    );
  }
}
