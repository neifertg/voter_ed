# Enable Google Civic Information API

## Problem

You're seeing this error when entering addresses:
```
Address validation service unavailable. Please enable the Google Civic Information API in your Google Cloud Console, or use just your zip code.
```

This means the **Google Civic Information API** is not enabled for your API key.

## Solution

### Step 1: Go to Google Cloud Console

Visit: https://console.cloud.google.com/apis/library/civicinfo.googleapis.com

### Step 2: Select Your Project

Make sure you've selected the correct project (the one where your API key `AIzaSyCwJs1K57K4WlX0akHpwF_n9yO-X9hrNj4` is from).

### Step 3: Enable the API

Click the **"Enable"** button on the Google Civic Information API page.

### Step 4: Wait for Activation

It may take a few minutes for the API to become fully active.

### Step 5: Test

Try entering your address again in VoterEd.

## What This API Does

The Google Civic Information API provides:
- Address validation and normalization
- Electoral division information
- Elected officials and candidates (during election season)
- Polling place information (during elections)

## Troubleshooting

### Error: "API key not valid"
- Make sure you're using the correct API key
- Check that the API key has no restrictions preventing its use

### Error: "Quota exceeded"
- The free tier includes 25,000 requests per day
- If you exceed this, you'll need to enable billing

### Still Not Working?
Try using just your 5-digit zip code instead of your full address. VoterEd will work with zip codes even without the Google Civic API enabled.

## Alternative: Use Zip Code Only

If you don't want to enable the API right now, you can:
1. Click "Zip Code Only" toggle on the address input page
2. Enter just your 5-digit zip code (e.g., 20148)
3. VoterEd will work perfectly with just the zip code

## Cost

The Google Civic Information API is **free** for up to 25,000 requests per day. This is more than enough for VoterEd's needs.
