import { supabase } from '@/lib/supabase';
import { NextResponse } from 'next/server';
import { fetchCandidatesForAddress } from '@/lib/googleCivic';

interface CandidateMatch {
  // From Google Civic API
  name: string;
  office: string;
  party?: string;
  candidateUrl?: string;
  channels?: Array<{
    type: string;
    id: string;
  }>;

  // From our database (if available)
  id?: string;
  bio?: string;
  positions?: Array<{
    issue_id: string;
    position: number;
    position_text: string;
    issue: {
      title: string;
      slug: string;
      description: string;
    };
  }>;

  // Match metadata
  hasPositionData: boolean;
  source: 'google_civic' | 'database' | 'hybrid';
}

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const address = searchParams.get('address');

    if (!address) {
      return NextResponse.json(
        { success: false, error: 'Address is required' },
        { status: 400 }
      );
    }

    // Fetch candidates from Google Civic API
    const civicData = await fetchCandidatesForAddress(address);

    if (!civicData?.contests) {
      // Fall back to database-only candidates based on zip code
      const zipMatch = address.match(/\d{5}/);
      if (zipMatch) {
        return await fetchDatabaseCandidates(zipMatch[0]);
      }

      return NextResponse.json({
        success: true,
        candidates: [],
        source: 'no_data',
        message: 'No election data available for this address',
      });
    }

    // Process and enrich candidates
    const enrichedCandidates: CandidateMatch[] = [];

    for (const contest of civicData.contests) {
      // Filter to local and state races only (exclude federal)
      const isLocalOrState = !contest.level?.includes('country');

      if (isLocalOrState && contest.candidates) {
        for (const civicCandidate of contest.candidates) {
          // Try to find matching candidate in our database
          const { data: dbCandidates } = await supabase
            .from('candidates')
            .select(`
              *,
              positions:candidate_positions(
                issue_id,
                position,
                position_text,
                issue:issues(title, slug, description)
              )
            `)
            .ilike('name', `%${civicCandidate.name}%`)
            .ilike('office', `%${contest.office}%`)
            .limit(1);

          const dbMatch = dbCandidates?.[0];

          const enrichedCandidate: CandidateMatch = {
            name: civicCandidate.name,
            office: contest.office,
            party: civicCandidate.party || dbMatch?.party,
            candidateUrl: civicCandidate.candidateUrl || dbMatch?.website_url,
            channels: civicCandidate.channels,
            id: dbMatch?.id,
            bio: dbMatch?.bio,
            positions: dbMatch?.positions || [],
            hasPositionData: (dbMatch?.positions?.length || 0) > 0,
            source: dbMatch ? 'hybrid' : 'google_civic',
          };

          enrichedCandidates.push(enrichedCandidate);
        }
      }
    }

    // Group candidates by office
    const candidatesByOffice = enrichedCandidates.reduce((acc, candidate) => {
      if (!acc[candidate.office]) {
        acc[candidate.office] = [];
      }
      acc[candidate.office].push(candidate);
      return acc;
    }, {} as Record<string, CandidateMatch[]>);

    return NextResponse.json({
      success: true,
      candidates: enrichedCandidates,
      candidatesByOffice,
      totalCandidates: enrichedCandidates.length,
      candidatesWithPositions: enrichedCandidates.filter(c => c.hasPositionData).length,
      election: civicData.election,
      source: 'hybrid',
    });
  } catch (error) {
    console.error('Error fetching candidates:', error);
    return NextResponse.json(
      { success: false, error: 'Error fetching candidate data' },
      { status: 500 }
    );
  }
}

// Fallback: fetch only from database
async function fetchDatabaseCandidates(zipCode: string) {
  const { data: candidates, error } = await supabase
    .from('candidates')
    .select(`
      *,
      positions:candidate_positions(
        issue_id,
        position,
        position_text,
        issue:issues(title, slug, description)
      )
    `)
    .contains('zip_codes', [zipCode]);

  if (error) {
    return NextResponse.json(
      { success: false, error: error.message },
      { status: 500 }
    );
  }

  const enrichedCandidates: CandidateMatch[] = (candidates || []).map(candidate => ({
    name: candidate.name,
    office: candidate.office,
    party: candidate.party,
    candidateUrl: candidate.website_url,
    channels: [],
    id: candidate.id,
    bio: candidate.bio,
    positions: candidate.positions || [],
    hasPositionData: (candidate.positions?.length || 0) > 0,
    source: 'database' as const,
  }));

  // Group by office
  const candidatesByOffice = enrichedCandidates.reduce((acc, candidate) => {
    if (!acc[candidate.office]) {
      acc[candidate.office] = [];
    }
    acc[candidate.office].push(candidate);
    return acc;
  }, {} as Record<string, CandidateMatch[]>);

  return NextResponse.json({
    success: true,
    candidates: enrichedCandidates,
    candidatesByOffice,
    totalCandidates: enrichedCandidates.length,
    candidatesWithPositions: enrichedCandidates.filter(c => c.hasPositionData).length,
    source: 'database',
  });
}
