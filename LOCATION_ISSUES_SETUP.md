# Location-Specific Issues Setup Guide

This guide explains the new location-specific issues system and how to deploy it.

## What Was Created

### 1. Database Migration
**File**: `supabase/migrations/002_add_location_to_issues.sql`

Adds a `locations` field to the `issues` table allowing issues to be tagged with state codes (VA, NC, TX, etc.).

### 2. Location-Specific Issues
**File**: `supabase/seed-issues-location-specific.sql`

Creates 37 location-specific issues across all 7 states:

**Virginia (VA)** - 4 issues:
- Northern Virginia Transportation Infrastructure
- Virginia K-12 Education Standards
- Tech Corridor Economic Development
- Loudoun County Growth Management

**North Carolina (NC)** - 4 issues:
- Rural Broadband Expansion
- NC School Funding Formula
- Charlotte-Area Transit Expansion
- Agricultural Land Preservation

**Utah (UT)** - 4 issues:
- Utah Water Rights and Conservation
- Public Lands Management
- Wasatch Front Air Quality
- Utah Housing Affordability

**Texas (TX)** - 4 issues:
- Texas Property Tax Reform
- Border Security Funding
- Power Grid Winterization
- Katy ISD Funding and Growth

**New Jersey (NJ)** - 4 issues:
- Coastal Protection and Beach Replenishment
- NJ Property Tax Relief
- Atlantic City Casino Revenue
- Cape May Tourism Economy

**Kansas (KS)** - 4 issues:
- Kansas School Funding Formula
- Medicaid Expansion
- Wind Energy Development
- Wichita Area Growth

**Michigan (MI)** - 4 issues:
- Great Lakes Water Quality
- Michigan Infrastructure Investment
- Rural Economic Development
- Tourism and Recreation Funding

**Shared Issues (All States)** - 5 issues:
- Local Education Funding
- Public Safety Funding
- Small Business Support
- Infrastructure Maintenance
- Environmental Protection

### 3. AI-Generated Issue Explanations
**File**: `supabase/seed-issue-explanations.sql`

For each issue, provides THREE viewpoints:
- **Overview**: Empirical, unbiased explanation of the issue with facts and context
- **Arguments For**: Popular arguments supporting the issue
- **Arguments Against**: Popular arguments opposing the issue

Total: 111 explanations (37 issues × 3 viewpoints each)

### 4. Updated Frontend Code

**Files Modified**:
- `src/app/api/issues/route.ts` - Now filters issues by user's zip code/state
- `src/app/onboarding/quiz/page.tsx` - Passes zip code when fetching issues
- `src/app/onboarding/importance/page.tsx` - Passes zip code when fetching issues
- `src/lib/zipToState.ts` - NEW: Helper function to map zip codes to states

## How to Deploy

### Step 1: Apply Database Migration

Open your Supabase SQL Editor and run:

```sql
-- Add location field to issues table
ALTER TABLE issues
ADD COLUMN IF NOT EXISTS locations TEXT[];

CREATE INDEX IF NOT EXISTS idx_issues_locations
ON issues USING GIN(locations);

COMMENT ON COLUMN issues.locations IS 'Array of state codes (VA, NC, TX, etc.) or national for issues applicable to those areas';
```

### Step 2: Seed Location-Specific Issues

Copy the contents of `supabase/seed-issues-location-specific.sql` and run it in the Supabase SQL Editor.

This will add 37 new location-specific issues.

### Step 3: Seed Issue Explanations

Copy the contents of `supabase/seed-issue-explanations.sql` and run it in the Supabase SQL Editor.

This will add 111 AI-generated explanations.

### Step 4: Deploy Frontend Changes

```bash
git add .
git commit -m "Add location-specific issues with AI-generated explanations"
git push
vercel --prod
```

## How It Works

### User Flow

1. **User enters zip code** (e.g., "20147" for Loudoun County, VA)
2. **System determines state** using `getStateFromZip()` → "VA"
3. **Quiz fetches issues** via `/api/issues?zipCode=20147`
4. **API filters issues** to only include those with "VA" in their `locations` array
5. **User sees relevant issues** specific to Virginia + shared issues
6. **Issue explanations** are included with overview and arguments for/against

### Example API Response

```json
{
  "success": true,
  "issues": [
    {
      "id": "550e8400-e29b-41d4-a716-446655440101",
      "title": "Northern Virginia Transportation Infrastructure",
      "description": "Should Virginia prioritize funding for roads, Metro expansion...",
      "category": "state",
      "locations": ["VA"],
      "explanations": [
        {
          "viewpoint": "overview",
          "explanation": "Northern Virginia faces some of the nation's worst traffic..."
        },
        {
          "viewpoint": "arguments_for",
          "explanation": "Proponents argue that robust transportation infrastructure..."
        },
        {
          "viewpoint": "arguments_against",
          "explanation": "Opponents argue that transportation projects are expensive..."
        }
      ]
    },
    // ... more issues
  ]
}
```

## Benefits

### 1. **Relevance**: Users only see issues that matter to their location
- Virginia voters don't see Texas border security issues
- Texas voters don't see Great Lakes water quality issues

### 2. **Informed Decisions**: AI-generated explanations provide:
- Factual context and background
- Balanced arguments from both sides
- Empirical data and statistics

### 3. **Scalability**: Easy to add new locations
- Create new state-specific issues
- Generate explanations using Claude
- Map new zip codes to states

### 4. **Flexibility**: Shared issues work everywhere
- Education, public safety, infrastructure apply to all locations
- Each state gets its unique issues PLUS the shared ones

## Future Enhancements

### Display Explanations in UI
You may want to add an "Learn More" button or expandable section in the quiz to show users the issue explanations. This would help them make informed decisions.

**Example Implementation**:
```tsx
<button onClick={() => setShowExplanation(!showExplanation)}>
  Learn More About This Issue
</button>

{showExplanation && (
  <div className="mt-4 p-4 bg-gray-50 rounded">
    <h4>Overview</h4>
    <p>{issue.explanations.find(e => e.viewpoint === 'overview')?.explanation}</p>

    <h4>Arguments For</h4>
    <p>{issue.explanations.find(e => e.viewpoint === 'arguments_for')?.explanation}</p>

    <h4>Arguments Against</h4>
    <p>{issue.explanations.find(e => e.viewpoint === 'arguments_against')?.explanation}</p>
  </div>
)}
```

### Update Candidate Positions
The existing candidate positions in the seed files reference the old generic issues. You'll want to:
1. Map existing candidates to the new location-specific issues
2. Update their position data to reference the new issue IDs

### Add More Locations
To add a new location:
1. Add zip codes to `src/lib/zipToState.ts`
2. Create state-specific issues in a new SQL file
3. Generate explanations using Claude
4. Update the seed script to include the new location

## Testing

Test the system by:
1. Clearing localStorage: `localStorage.clear()`
2. Starting onboarding with different zip codes
3. Verifying that issues change based on location
4. Checking that explanations are loaded correctly

Example test cases:
- Zip 20147 (VA) → Should see VA issues
- Zip 77449 (TX) → Should see TX issues
- Zip 84043 (UT) → Should see UT issues
- All locations → Should see shared issues

## Questions?

The system is now set up to provide location-specific, AI-explained issues. The user experience will be significantly improved with relevant local issues and balanced, educational content.
