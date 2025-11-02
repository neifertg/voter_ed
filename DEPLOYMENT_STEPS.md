# Deployment Steps - Hybrid System with Google Civic API

Your hybrid system is ready to deploy! Here's what you need to do:

## ✅ Local Setup Complete

Your `.env.local` file now has:
```
GOOGLE_CIVIC_API_KEY=AIzaSyCwJs1K57K4WlX0akHpwF_n9yO-X9hrNj4
NEXT_PUBLIC_GOOGLE_MAPS_API_KEY=AIzaSyDJkYpyWLLncnGB-kc1ec-uESwmkN3E408
```

Note: You have two separate API keys:
- `GOOGLE_CIVIC_API_KEY` - Server-side only, for fetching candidate/election data
- `NEXT_PUBLIC_GOOGLE_MAPS_API_KEY` - Client-side, for Google Places Autocomplete (the `NEXT_PUBLIC_` prefix makes it available in the browser)

## 🚀 Deploy to Vercel

### Option 1: Vercel Dashboard (Easiest)

1. Go to https://vercel.com/dashboard
2. Select your VoterEd project
3. Go to **Settings** → **Environment Variables**
4. Click **Add New** and add BOTH variables:

   **First variable (Google Civic API):**
   - **Name**: `GOOGLE_CIVIC_API_KEY`
   - **Value**: `AIzaSyCwJs1K57K4WlX0akHpwF_n9yO-X9hrNj4`
   - **Environment**: Select "Production", "Preview", and "Development"

   **Second variable (Google Maps API):**
   - **Name**: `NEXT_PUBLIC_GOOGLE_MAPS_API_KEY`
   - **Value**: `AIzaSyDJkYpyWLLncnGB-kc1ec-uESwmkN3E408`
   - **Environment**: Select "Production", "Preview", and "Development"

5. Click **Save** for both
6. Go to **Deployments** → Click the 3 dots on latest → **Redeploy**

### Option 2: Command Line

```bash
# From your project directory
cd "C:\Users\Seth Neifert\Documents\GitHub\VoterEd"

# Set the environment variables (copy/paste the whole commands)
echo "AIzaSyCwJs1K57K4WlX0akHpwF_n9yO-X9hrNj4" | vercel env add GOOGLE_CIVIC_API_KEY production
echo "AIzaSyDJkYpyWLLncnGB-kc1ec-uESwmkN3E408" | vercel env add NEXT_PUBLIC_GOOGLE_MAPS_API_KEY production

# Also add for preview and development
echo "AIzaSyCwJs1K57K4WlX0akHpwF_n9yO-X9hrNj4" | vercel env add GOOGLE_CIVIC_API_KEY preview
echo "AIzaSyDJkYpyWLLncnGB-kc1ec-uESwmkN3E408" | vercel env add NEXT_PUBLIC_GOOGLE_MAPS_API_KEY preview
echo "AIzaSyCwJs1K57K4WlX0akHpwF_n9yO-X9hrNj4" | vercel env add GOOGLE_CIVIC_API_KEY development
echo "AIzaSyDJkYpyWLLncnGB-kc1ec-uESwmkN3E408" | vercel env add NEXT_PUBLIC_GOOGLE_MAPS_API_KEY development

# Deploy to production
vercel --prod
```

## 🧪 Test the System

Once deployed, test with these addresses:

### During Election Season (Best Test)
```
- 123 N Center St, Lehi, UT 84043
- 100 Main St, Leesburg, VA 20175
- 5423 Franz Rd, Katy, TX 77493
```

### Off-Season (Fallback Test)
```
- Just enter zip codes: 84043, 20147, 77449
- System will use your seeded candidates
```

## ✅ What Should Happen

### 1. Address Input
- User enters full address or zip code
- System validates via Google Civic API
- Address gets normalized

### 2. Quiz
- Shows location-specific issues (your 37 AI-explained issues)
- User rates positions on issues
- Importance slider for each issue

### 3. Results
Three scenarios:

**🟢 Best Case (Hybrid)**:
- Google Civic API provides current candidates
- Your database has position data
- Full match scores shown
- **Example**: "Sarah Johnson - 87% match"

**🟡 Good Case (Google Civic Only)**:
- Google Civic API provides candidates
- No position data yet (new candidates)
- Shows candidates with neutral positions
- **Example**: "John Doe - Running for City Council (No position data yet)"

**🔵 Fallback (Database Only)**:
- API unavailable or no election data
- Uses your seeded candidates
- **Example**: Works for your 7 locations even offline

## 📊 Monitor Usage

### Check Google Civic API Usage
1. Go to https://console.cloud.google.com/
2. Navigate to "APIs & Services" → "Google Civic Information API"
3. Click "Metrics"
4. Monitor requests (you have 25,000/day free)

### Check Hybrid Match Rates
Look at your logs to see:
- How many candidates from Google Civic API
- How many matched with your position data
- Which candidates need research

## 🎯 Next Steps

### Immediate
1. **Deploy** with the API key (steps above)
2. **Test** with real addresses
3. **Monitor** for any errors

### This Week
4. **Apply location-specific issues migration**:
   - Open Supabase SQL Editor
   - Run contents of `supabase/migrations/002_add_location_to_issues.sql`
   - Run contents of `supabase/seed-issues-location-specific.sql`
   - Run contents of `supabase/seed-issue-explanations.sql`

5. **Check candidate matches**:
   - See which Google Civic candidates have position data
   - Identify popular candidates without positions
   - Research and add positions for top candidates

### Ongoing
6. **Expand position data**:
   - When users search for candidates without positions
   - Research those candidates
   - Add to database
   - System automatically enriches next fetch

## 🔒 Security Note

Your API key is in:
- ✅ `.env.local` (local development, gitignored)
- ⏳ Vercel environment variables (production, to be added)
- ❌ NOT in git repository (stays secure)

The `.env.local.example` file in the repo shows what's needed without exposing the actual key.

## 🆘 Troubleshooting

### "No candidates found"
- **Cause**: No active election in that area
- **Solution**: Normal! Google Civic API only shows current elections
- **Workaround**: System falls back to your seeded candidates

### "Address validation failed"
- **Cause**: API key not set or invalid address
- **Solution**: Check Vercel env vars, try a zip code instead
- **Workaround**: System accepts zip codes directly

### "Candidates but no match scores"
- **Cause**: Candidates from API without position data
- **Expected**: This is normal for new candidates
- **Action**: Research popular candidates and add positions

## 📈 Success Metrics

You'll know it's working when:
- ✅ Users can enter full addresses (not just zip codes)
- ✅ Results show current candidates from Google Civic API
- ✅ Candidates with position data show match percentages
- ✅ System works nationwide (not just 7 locations)
- ✅ Falls back gracefully when API unavailable

## 🎉 You're Ready!

Your VoterEd platform now:
- Accepts addresses anywhere in the US
- Fetches real, current candidates from Google
- Enriches with your curated position data
- Provides AI-generated educational content
- Scales from 7 locations to nationwide

Just add the API key to Vercel and deploy! 🚀
