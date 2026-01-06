# VoterEd

> **A non-partisan voter education platform using advanced weighted matching algorithms to help citizens make informed decisions based on their values, not party affiliation.**

A production-ready civic tech application that combines real-time election data with values-based candidate matching. Built to promote issue-focused voting in underserved areas through location-specific education and transparent, sourced candidate position data.

[![Next.js](https://img.shields.io/badge/Next.js-16-black)](https://nextjs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.9-blue)](https://www.typescriptlang.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Supabase-green)](https://supabase.com/)
[![Vercel](https://img.shields.io/badge/Deployed-Vercel-black)](https://vercel.com)

**Live Demo**: [Coming Soon]

---

## 🎯 Mission & Objective

VoterEd addresses a critical gap in voter education: helping citizens understand **where candidates stand on issues that matter to them**, rather than relying solely on party affiliation.

### Core Objectives

1. **Issue-Focused Voting**: Shift focus from partisan labels to substantive policy positions
2. **Geographic Relevance**: Provide location-specific issues (county, city, state level)
3. **Transparent Sourcing**: Every candidate position backed by credible sources with bias ratings
4. **Privacy-First**: No user accounts required—all data stored locally
5. **Underserved Areas**: Currently covering 7 states (UT, VA, TX, NJ, KS, MI, NC, NE)

---

## 🧮 Advanced Analytics & Matching Algorithm

### Weighted Distance Calculation

VoterEd implements a sophisticated **weighted candidate matching system** that goes beyond simple agreement counting:

```typescript
For each issue:
  difference = abs(candidate_position - user_position)  // 0-4 scale
  weighted_distance = difference * user_importance_rating  // 0-40 scale

Overall Match Score:
  max_possible_distance = 4 * 10 * num_issues
  match_score = 100 - (total_weighted_distance / max_possible) * 100
```

**Key Features**:
- **5-Point Position Scale**: Strongly Oppose (1) → Strongly Support (5)
- **0-10 Importance Weighting**: Users prioritize what matters most to them
- **Real-Time Calculation**: Match scores computed dynamically as users complete the quiz
- **Quality Labels**: Strong (80%+) / Good (60-79%) / Moderate (40-59%) / Weak (<40%)

**Implementation**: [`src/app/api/match-candidates/route.ts:144-201`](src/app/api/match-candidates/route.ts)

### Position-by-Position Breakdown

Beyond aggregate scores, the platform provides granular analysis:
- **Agreement Indicators**: ✓ (exact match), ≈ (close), ✗ (disagreement)
- **Issue-by-Issue Comparison**: Expandable cards showing user vs. candidate on each issue
- **Weighted Impact**: Visual representation of how importance affects final match

---

## 🏗️ Architecture & Tech Stack

### Frontend Framework

| Technology | Version | Purpose |
|-----------|---------|---------|
| **Next.js** | 16.0.1 | React meta-framework with App Router |
| **React** | 19.2.0 | Component-based UI library |
| **TypeScript** | 5.9.3 | Type-safe development |
| **Tailwind CSS** | 3.4.18 | Utility-first CSS with custom patriotic color palette |

### Backend & APIs

| Technology | Purpose |
|-----------|---------|
| **Next.js API Routes** | Serverless API endpoints |
| **Google Civic Information API** | Real-time candidate and election data (25k requests/day free tier) |
| **Supabase (PostgreSQL)** | Cloud database with Row Level Security |
| **Linear SDK** | Issue tracking integration |

### Hybrid Data Architecture

VoterEd uses a **unique hybrid system** combining real-time API data with curated position databases:

```
Google Civic API (candidates) + Database (positions) = Complete Match Data
```

**Three Data Sources**:
1. **`google_civic`**: API-only candidates (no positions yet)
2. **`database`**: Fallback candidates from seeded data
3. **`hybrid`**: Best case—API candidates + database positions

**Why This Matters**:
- **Scalability**: Works for any US address via Google Civic API
- **Accuracy**: Curated position data from Ballotpedia, League of Women Voters, etc.
- **Resilience**: Graceful degradation when API unavailable

**Implementation**: [`src/lib/googleCivic.ts`](src/lib/googleCivic.ts)

---

## 📊 Data Models & Database Schema

### Entity Relationships

```
users (1) → (many) user_issue_preferences
issues (1) → (many) candidate_positions
issues (1) → (many) issue_explanations
candidates (1) → (many) candidate_positions
sources (1) → (many) candidate_positions
```

### Key Tables

**`issues`**
- Location-specific questions (county, city, state level)
- PostgreSQL array type for `locations` field (e.g., `["UT", "Salt Lake County"]`)
- Category tags (Local vs. State)

**`candidates`**
- Name, office, party, location
- Mapped to Google Civic API candidates via fuzzy ILIKE queries

**`candidate_positions`**
- Many-to-many join table
- 1-5 position scale with source attribution
- Credibility score (1-5) and bias rating for each source

**`issue_explanations`**
- AI-generated explanations with pro/con arguments
- Educational content for voter understanding

---

## 🎓 Educational User Flow

### 4-Step Onboarding Process

**Step 1: Location Validation** ([`/onboarding/zip-code`](src/app/onboarding/zip-code))
- Address validation via Google Civic API
- Fallback to 5-digit zip code input
- Geographic location determination for issue filtering

**Step 2: Issue Quiz** ([`/onboarding/quiz`](src/app/onboarding/quiz))
- 10+ location-specific questions
- 5-point position scale with clear labels
- Category badges (Local vs. State issues)
- Progress indicator with back/forward navigation
- Previous responses restored on "Back" button

**Step 3: Issue Prioritization** ([`/onboarding/importance`](src/app/onboarding/importance))
- 0-10 importance slider for each issue
- Visual progress tracker (3-step flow)
- Tip section explaining importance weighting
- Example: "If you care deeply about education funding, rate it 10; if it's less important, rate it lower"

**Step 4: Results Visualization** ([`/results`](src/app/results))
- **Two view modes**:
  - **By Office**: Simplified view grouping candidates by elected position
  - **All Candidates**: Detailed list with full breakdowns
- Match percentage with quality label
- Expandable issue-by-issue analysis
- Call-to-action for retaking quiz

### Privacy-First Design

- **No user accounts required**: Anonymous, local-first architecture
- **LocalStorage persistence**:
  - `votered_zip_code`
  - `votered_quiz_responses`
  - `votered_complete_responses`
- **No tracking**: User data never leaves their browser

---

## 🛠️ Advanced Features

### 1. **Source Attribution & Credibility Scoring**

Every candidate position includes:
- **Source URL**: Link to original position statement
- **Credibility Score** (1-5): Quality of source (e.g., Ballotpedia = 5, social media = 2)
- **Bias Rating**: Left/Center/Right classification
- **Source Type**: Official statement, voting record, interview, etc.

This builds user trust and encourages fact-checking.

### 2. **Location-Based Issue Filtering**

Issues are dynamically filtered based on user location:
- **County-level precision**: "Salt Lake County transit funding"
- **State-level issues**: "Utah education spending"
- **National-local overlap**: Federal positions on issues affecting local areas

**Database Query**:
```sql
SELECT * FROM issues WHERE locations @> ARRAY['UT', 'Salt Lake County']::text[]
```

### 3. **Deterministic Position Generation (Demo Data)**

For testing and demo purposes, positions are generated using:
```javascript
const hash = simpleHash(candidateName + issueId)
const position = (hash % 5) + 1  // 1-5 scale
```

This ensures:
- **Reproducibility**: Same candidate always has same position on same issue
- **Variety**: Different candidates have different positions
- **Realism**: Plausible distribution across the 1-5 scale

**Script**: [`scripts/generate-candidate-positions.mjs`](scripts/generate-candidate-positions.mjs)

### 4. **Coverage Analysis Tools**

Built-in analytics scripts to ensure data quality:
- **`analyze-position-gaps.mjs`**: Identifies candidates missing position data
- **`verify-positions.mjs`**: Validates position data integrity
- **Coverage metrics**: Tracks % of candidates with complete position data

---

## 📈 Scalability & Performance

### Current Coverage

- **7 States**: UT, VA, TX, NJ, KS, MI, NC, NE
- **37 Location-Specific Issues**: County and state-level questions
- **5+ Candidates per Location**: Comprehensive local/state race coverage

### Scalability Path

1. **Nationwide Expansion**: Google Civic API supports any US address
2. **Incremental Position Data**: Expand position database one location at a time
3. **Crowdsourced Verification**: Potential for community-contributed position data
4. **Ballot Measures**: API integration already supports referendums/propositions

### Performance Optimizations

- **Next.js Turbopack**: Enabled in development (`next dev --turbopack`)
- **API Route Batching**: Position queries batched for efficiency
- **Database-Level Filtering**: PostgreSQL array containment operations
- **Client-Side Caching**: LocalStorage for user responses

---

## 🚀 Deployment & DevOps

### Tech Stack

| Layer | Technology |
|-------|-----------|
| **Hosting** | Vercel (serverless) |
| **Database** | Supabase (managed PostgreSQL) |
| **CDN** | Vercel Edge Network |
| **Environment Variables** | Vercel env vars for production, `.env.local` for dev |

### Error Handling & Resilience

- **Graceful API Degradation**: Works without Google Civic API key
- **Zip Code Fallback**: Accepts 5-digit codes when address validation fails
- **Database Fallback**: Falls back to seeded candidates when API unavailable
- **Route Guards**: Validates previous step completion (e.g., must complete quiz before importance page)

### Deployment Guides

- **[DEPLOYMENT_STEPS.md](DEPLOYMENT_STEPS.md)**: Production deployment instructions
- **[SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md)**: Local development setup
- **[HYBRID_SYSTEM_GUIDE.md](HYBRID_SYSTEM_GUIDE.md)**: Complete hybrid data architecture docs

---

## 🎨 Design System

### Custom Patriotic Color Palette

```css
colors: {
  'patriot-red': { /* 900 scale */ },
  'patriot-blue': { /* 900 scale */ },
  'neutral-gray': { /* 900 scale */ }
}
```

### UI/UX Principles

- **Mobile-First**: Tailwind responsive utilities
- **Accessibility**: Semantic HTML, proper ARIA labels, keyboard navigation
- **Visual Feedback**: Loading spinners, progress indicators, button states
- **Clear CTAs**: Prominent "Next" buttons, retry options on results page

---

## 🧪 Data Seeding & Testing

### Seed Scripts

Located in [`/scripts`](scripts/):

| Script | Purpose |
|--------|---------|
| `seed-all-expanded.mjs` | Comprehensive candidate + position data |
| `seed-location-issues.mjs` | Location-specific issue setup |
| `generate-candidate-positions.mjs` | Deterministic position generation |
| `analyze-position-gaps.mjs` | Coverage analysis tool |
| `verify-positions.mjs` | Data integrity validation |

### SQL Migrations

Located in [`/supabase/migrations`](supabase/migrations/):
- Database schema creation
- RLS (Row Level Security) policies
- Index optimization

---

## 📖 Key Documentation

- **[HYBRID_SYSTEM_GUIDE.md](HYBRID_SYSTEM_GUIDE.md)**: Complete explanation of Google Civic API + database integration
- **[DEPLOYMENT_STEPS.md](DEPLOYMENT_STEPS.md)**: Step-by-step production deployment
- **[SETUP_INSTRUCTIONS.md](SETUP_INSTRUCTIONS.md)**: Local development environment setup

---

## 🛤️ Future Roadmap

### Near-Term (Next 3-6 Months)

- [ ] **Expand to 5 additional states**: Focus on swing states and underserved areas
- [ ] **Ballot measure support**: Add referendum/proposition matching
- [ ] **Share results feature**: Generate shareable match breakdowns
- [ ] **Multi-language support**: Spanish, Chinese, Vietnamese

### Long-Term Vision

- [ ] **Nationwide coverage**: All 50 states
- [ ] **Crowdsourced positions**: Community-verified candidate data
- [ ] **Voter registration integration**: Link to state registration portals
- [ ] **Issue education modules**: In-depth explanations with videos/infographics
- [ ] **Collaborative filtering**: "Users like you also cared about..."

---

## 🤝 Contributing

This is an open-source civic tech project. Contributions welcome!

### How to Contribute

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Make changes following TypeScript and React best practices
4. Test locally with `npm run dev`
5. Submit a Pull Request with clear description

### Contribution Areas

- **Position data research**: Help expand candidate position database
- **Issue creation**: Suggest location-specific questions for new areas
- **UI/UX improvements**: Enhance accessibility and user experience
- **Analytics**: Improve matching algorithm or add new insights
- **Documentation**: Improve setup guides and API docs

---

## 📄 License

This project is licensed under the **MIT License**. See [LICENSE](LICENSE) for details.

---

## 🙏 Acknowledgments

- **Google Civic Information API** for real-time election data
- **Supabase** for managed PostgreSQL and authentication
- **Ballotpedia** and **League of Women Voters** for candidate position research
- **Vercel** for seamless deployment and hosting

---

## 📧 Contact

**Built by**: Seth Neifert
**GitHub**: [github.com/neifertg](https://github.com/neifertg)
**LinkedIn**: [Your LinkedIn URL]
**Email**: [Your email]

*This project demonstrates full-stack development, algorithm design, data integration, and civic impact. Perfect for showcasing technical depth and mission-driven product thinking in interviews.*

---

## 🔍 Technical Highlights for Interviews

When discussing this project with potential employers, emphasize:

1. **Full-Stack Architecture**: React/Next.js → API layer → PostgreSQL backend
2. **Algorithm Design**: Weighted matching with user importance weighting (real-world math application)
3. **Hybrid Data Integration**: Combining real-time API with curated database for best of both worlds
4. **Civic Tech Mission**: Education-focused, non-partisan, privacy-first approach
5. **Production-Ready**: Deployment guides, fallback strategies, comprehensive error handling
6. **Analytics Pipeline**: Seed data generation, position analysis tools, coverage verification
7. **Scalability**: Designed to expand from 7 locations to nationwide coverage
8. **Data Quality**: Source attribution, credibility scoring, bias transparency

The codebase demonstrates **technical depth** (matching algorithm, hybrid data sources, API integration), **product thinking** (user experience flow, educational content), and **civic impact** (voter education mission).
