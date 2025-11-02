#!/usr/bin/env node

/**
 * Apply location migration manually
 * Adds locations column to issues table
 */

import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Missing Supabase credentials in .env.local');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function applyMigration() {
  console.log('📦 Applying location migration...\n');

  // Check if column already exists
  const { data: columns, error: checkError } = await supabase
    .from('issues')
    .select('*')
    .limit(1);

  if (checkError) {
    console.error('❌ Error checking table:', checkError);
    return;
  }

  if (columns && columns.length > 0 && 'locations' in columns[0]) {
    console.log('✅ Column "locations" already exists in issues table');
    return;
  }

  console.log('⚠️  To add the locations column, please run this SQL in your Supabase SQL Editor:');
  console.log('\n' + '-'.repeat(60));
  console.log(`
-- Add location field to issues table
ALTER TABLE issues
ADD COLUMN IF NOT EXISTS locations TEXT[];

CREATE INDEX IF NOT EXISTS idx_issues_locations
ON issues USING GIN(locations);

COMMENT ON COLUMN issues.locations IS 'Array of state codes (VA, NC, TX, etc.) or national for issues applicable to those areas';
  `);
  console.log('-'.repeat(60) + '\n');

  console.log('📝 Then re-run this script or proceed to seed the location-specific issues.');
}

applyMigration().catch(error => {
  console.error('❌ Fatal error:', error);
  process.exit(1);
});
