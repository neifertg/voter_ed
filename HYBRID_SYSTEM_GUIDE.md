# VoterEd Hybrid System - Google Civic API Integration

This guide explains the new hybrid candidate matching system that combines Google Civic Information API with your curated position data.

## Overview

The hybrid system provides the best of both worlds:
- **Google Civic API**: Dynamic, always-current candidate lists for any US address
- **Your Database**: Detailed position data and AI-generated issue explanations

## How It Works

### 1. User Flow

```
User enters address
    ↓
Address validated via Google Civic API
    ↓
Candidates fetched from Google Civic API
    ↓
System matches candidates with your position data
    ↓
User sees enriched candidate list with match scores
```

### 2. Data Sources

**From Google Civic API:**
- Candidate names
- Offices running for
- Party affiliations
- Campaign websites
- Social media channels
- Election dates

**From Your Database:**
- Candidate bios
- Positions on issues (1-5 scale)
- Source citations for positions

**Your Unique Value:**
- Location-specific issues (37 issues across 7 states)
- AI-generated issue explanations
- Arguments for/against each issue
- Match algorithm weighing positions by importance

### 3. Three Data Sources

Candidates are tagged with their data source:

1. **`google_civic`** - Only from API, no position data yet
2. **`database`** - Only in your database (fallback when API unavailable)
3. **`hybrid`** - API candidate matched with your position data ✨ **Best case!**

## Setup Instructions

### Step 1: Get Google Civic API Key

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing
3. Enable "Google Civic Information API"
4. Go to Credentials → Create Credentials → API Key
5. Restrict the key (recommended):
   - API restrictions: Only "Google Civic Information API"
   - Application restrictions: None (or HTTP referrers for your domain)

**Free Tier**: 25,000 requests/day (very generous for most apps)

### Step 2: Add to Environment Variables

Add to your `.env.local`:

```bash
GOOGLE_CIVIC_API_KEY=your_api_key_here
```

### Step 3: Deploy to Vercel

Add the environment variable in Vercel:

```bash
vercel env add GOOGLE_CIVIC_API_KEY
```

Or via Vercel Dashboard:
1. Project Settings → Environment Variables
2. Add `GOOGLE_CIVIC_API_KEY`
3. Redeploy

## API Endpoints

### 1. `/api/validate-address`

Validates and normalizes user addresses.

**Request:**
```
GET /api/validate-address?address=123+Main+St+Lehi+UT+84043
```

**Response:**
```json
{
  "success": true,
  "normalizedAddress": "123 Main St, Lehi, UT 84043",
  "zipCode": "84043",
  "divisions": ["ocd-division/country:us", "ocd-division/country:us/state:ut"],
  "hasElectionData": true
}
```

**Fallback**: If API unavailable, accepts zip codes directly.

### 2. `/api/candidates`

Fetches candidates with position data.

**Request:**
```
GET /api/candidates?address=123+Main+St+Lehi+UT+84043
```

**Response:**
```json
{
  "success": true,
  "candidates": [
    {
      "name": "John Smith",
      "office": "Lehi City Council",
      "party": "Non-partisan",
      "candidateUrl": "https://johnsmith.com",
      "id": "uuid-from-database",
      "bio": "Local business owner...",
      "positions": [
        {
          "issue_id": "uuid",
          "position": 4,
          "position_text": "Supports controlled growth"
        }
      ],
      "hasPositionData": true,
      "source": "hybrid"
    }
  ],
  "candidatesByOffice": { /* grouped by office */ },
  "election": {
    "id": "7000",
    "name": "VIP Test Election",
    "electionDay": "2025-11-08"
  }
}
```

### 3. `/api/match-candidates`

Calculates match scores based on user responses.

**Request:**
```json
POST /api/match-candidates
{
  "address": "123 Main St, Lehi, UT 84043",
  "zipCode": "84043",
  "responses": [
    {
      "issueId": "uuid",
      "position": 5,
      "importance": 8
    }
  ]
}
```

**Response:**
```json
{
  "success": true,
  "matches": [
    {
      "name": "John Smith",
      "office": "Lehi City Council",
      "party": "Non-partisan",
      "matchPercentage": 87,
      "hasPositionData": true,
      "agreementDetails": [
        {
          "issueId": "uuid",
          "userPosition": 5,
          "candidatePosition": 4,
          "importance": 8,
          "difference": 1
        }
      ]
    }
  ]
}
```

## Match Algorithm

The system calculates weighted matches:

```javascript
// For each issue:
difference = abs(candidate_position - user_position) // 0-4
weighted_distance = difference * user_importance      // 0-40

// Overall match:
total_weighted_distance = sum(all weighted_distances)
max_possible = 4 * 10 * num_issues
match_score = 100 - (total_weighted_distance / max_possible) * 100
```

**Example:**
- User: Strongly Support (5), Importance: 10
- Candidate: Support (4)
- Difference: 1
- Weighted distance: 1 × 10 = 10
- If max possible is 400: Match = 100 - (10/400)*100 = 97.5%

## Benefits

### For Users
1. **Accurate**: See actual candidates on their ballot (not manual guesses)
2. **Current**: Always up-to-date with latest races
3. **Comprehensive**: All local/state races, not just a few
4. **Educated**: Get your unique issue explanations and arguments

### For You
1. **Scalable**: Works for any US address, not just your 7 locations
2. **Automatic**: No manual candidate updates needed
3. **Competitive Advantage**: Position data + AI explanations = unique value
4. **Fallback**: Still works if API unavailable (uses your database)

### Match Rate Expectations

Typical scenarios:

**High Match (Hybrid)**:
- User in location with your position data
- API provides candidates, your DB provides positions
- **Best experience!** Full match scores, detailed issue breakdowns

**Medium Match (Google Civic Only)**:
- API provides candidates, but no position data yet
- Shows candidates with neutral positions (3)
- **Still valuable** - users see who's running
- **Action**: Research and add positions for popular candidates

**Low Match (Database Fallback)**:
- API unavailable or no election data
- Falls back to your seeded candidates
- **Reliable** - always works for your 7 locations

## Expanding Coverage

### Adding Position Data for New Candidates

When candidates appear from Google Civic API without position data:

1. **Identify popular candidates** (lots of searches/views)
2. **Research their positions**:
   - Campaign websites
   - Ballotpedia
   - League of Women Voters
   - Candidate forums/debates
   - News articles

3. **Add to database**:
```sql
-- Add candidate
INSERT INTO candidates (id, name, office, party, bio, zip_codes)
VALUES ('new-uuid', 'Jane Doe', 'City Council', 'Democrat', 'Local teacher...', ARRAY['84043']);

-- Add positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id)
VALUES
  ('new-uuid', 'utah-water-rights-uuid', 4, 'Supports water conservation measures', 'source-uuid'),
  ('new-uuid', 'local-education-uuid', 5, 'Strongly supports education funding', 'source-uuid');
```

4. **System automatically enriches** next API fetch

### Monitoring

Track hybrid system performance:

```sql
-- Check match rates
SELECT
  source,
  COUNT(*) as count,
  AVG(CASE WHEN positions > 0 THEN 1 ELSE 0 END) as position_coverage
FROM (
  SELECT
    c.source,
    COUNT(cp.id) as positions
  FROM candidates c
  LEFT JOIN candidate_positions cp ON c.id = cp.candidate_id
  GROUP BY c.id, c.source
) subquery
GROUP BY source;
```

## Troubleshooting

### API Key Issues

**Error**: "Address validation service unavailable"
- Check API key is in environment variables
- Verify API is enabled in Google Cloud Console
- Check quotas (25,000/day limit)

**Fallback**: System accepts zip codes when API unavailable

### No Candidates Found

**Possible causes**:
1. **No current election**: Google Civic API only shows active elections
2. **Test addresses**: Use real addresses in your coverage areas
3. **Federal-only**: System filters out federal races

**Solution**: Check with a known address during election season

### Position Data Not Showing

**Check**:
1. Candidate name matching (uses `ILIKE '%name%'`)
2. Office title matching
3. Database has positions for that candidate

**Logs**: Check server logs for matching attempts

## Example Test Addresses

Use these to test the hybrid system:

- **Lehi, UT**: `123 N Center St, Lehi, UT 84043`
- **Loudoun County, VA**: `100 Main St, Leesburg, VA 20175`
- **Katy, TX**: `5423 Franz Rd, Katy, TX 77493`

Note: Results depend on whether there are active elections.

## Cost Analysis

### Google Civic API

**Pricing**: Free up to 25,000 requests/day

**Usage estimation**:
- Address validation: 1 request per user
- Candidate fetch: Included in same request
- Average: 1 request per quiz completion

**Monthly capacity**:
- 25,000/day × 30 days = 750,000 users/month
- **Far more than needed for MVP**

**If you exceed**: $1 per 1,000 requests after free tier

### Compared to Alternatives

**Manual maintenance** (current):
- Research time: 2-4 hours per location
- Scale: Limited to a few locations
- Currency: Constant updates needed

**Hybrid system**:
- Setup: One-time (API key)
- Research: Only for candidates you want position data
- Scale: All US addresses
- Currency: Automatic

## Future Enhancements

### 1. Automated Position Research

Use AI to:
- Scrape candidate websites
- Analyze campaign statements
- Suggest positions for review
- Draft position_text summaries

### 2. Crowdsourcing

Let users:
- Submit candidate positions
- Vote on accuracy
- Provide sources
- Flag outdated info

### 3. Real-Time Updates

- Webhook when new candidates file
- Daily sync for election updates
- Notification when races change

### 4. Ballot Measures

Extend to propositions:
- Google Civic API includes measures
- Add your AI explanations
- Show pro/con arguments
- Provide fiscal impact analysis

## Questions?

The hybrid system is now set up! Once you add your Google Civic API key, users can enter any US address and see their actual ballot with your expert position analysis and AI-generated issue explanations.

This scales your platform from 7 locations to nationwide coverage while maintaining your competitive advantage: **curated position data + educational content**.
