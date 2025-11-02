// Google Civic Information API integration
// Documentation: https://developers.google.com/civic-information

interface CivicCandidate {
  name: string;
  party?: string;
  candidateUrl?: string;
  channels?: Array<{
    type: string;
    id: string;
  }>;
  phone?: string;
  email?: string;
}

interface CivicContest {
  type: string;
  office: string;
  level: string[];
  district?: {
    name: string;
    scope: string;
  };
  candidates: CivicCandidate[];
}

interface CivicAPIResponse {
  election: {
    id: string;
    name: string;
    electionDay: string;
  };
  contests: CivicContest[];
}

export async function fetchCandidatesForAddress(address: string): Promise<CivicAPIResponse | null> {
  const apiKey = process.env.GOOGLE_CIVIC_API_KEY;

  if (!apiKey) {
    console.error('Google Civic API key not configured');
    return null;
  }

  try {
    const encodedAddress = encodeURIComponent(address);
    const url = `https://www.googleapis.com/civicinfo/v2/voterinfo?address=${encodedAddress}&key=${apiKey}`;

    const response = await fetch(url);

    if (!response.ok) {
      console.error('Google Civic API error:', response.statusText);
      return null;
    }

    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error fetching civic data:', error);
    return null;
  }
}

export async function getUpcomingElections(): Promise<any[]> {
  const apiKey = process.env.GOOGLE_CIVIC_API_KEY;

  if (!apiKey) {
    console.error('Google Civic API key not configured');
    return [];
  }

  try {
    const url = `https://www.googleapis.com/civicinfo/v2/elections?key=${apiKey}`;
    const response = await fetch(url);

    if (!response.ok) {
      console.error('Google Civic API error:', response.statusText);
      return [];
    }

    const data = await response.json();
    return data.elections || [];
  } catch (error) {
    console.error('Error fetching elections:', error);
    return [];
  }
}

// Transform Google Civic data to match your database schema
export function transformCivicCandidateToDBFormat(
  civicCandidate: CivicCandidate,
  contest: CivicContest,
  zipCodes: string[]
) {
  return {
    name: civicCandidate.name,
    office: contest.office,
    party: civicCandidate.party || 'Unknown',
    bio: '', // Will need to be filled in separately
    website_url: civicCandidate.candidateUrl,
    zip_codes: zipCodes,
    // Add metadata to track this came from Civic API
    source: 'google_civic_api',
  };
}

// Check if candidate already exists in your database
export async function candidateExists(name: string, office: string): Promise<boolean> {
  // Implementation would check your Supabase database
  // This is a placeholder
  return false;
}

// Example usage in an API endpoint
export async function syncCandidatesFromCivicAPI(address: string, zipCodes: string[]) {
  const civicData = await fetchCandidatesForAddress(address);

  if (!civicData?.contests) {
    return { success: false, message: 'No election data available' };
  }

  const newCandidates = [];

  for (const contest of civicData.contests) {
    // Only process local/state races (not federal)
    if (!contest.level.includes('country')) {
      for (const candidate of contest.candidates) {
        const exists = await candidateExists(candidate.name, contest.office);

        if (!exists) {
          const transformed = transformCivicCandidateToDBFormat(
            candidate,
            contest,
            zipCodes
          );
          newCandidates.push(transformed);
        }
      }
    }
  }

  return {
    success: true,
    candidatesFound: civicData.contests.reduce((acc, c) => acc + c.candidates.length, 0),
    newCandidates: newCandidates.length,
    candidates: newCandidates,
  };
}
