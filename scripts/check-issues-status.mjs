#!/usr/bin/env node

/**
 * Check current issues and explanations status
 */

import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Missing Supabase credentials');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function checkStatus() {
  console.log('🔍 Checking current database status...\n');

  // Check issues
  const { data: issues, error: issuesError } = await supabase
    .from('issues')
    .select('id, title, locations');

  if (issuesError) {
    console.error('❌ Error fetching issues:', issuesError.message);
  } else {
    console.log(`📊 Total issues in database: ${issues?.length || 0}`);

    // Check for location-specific issues
    const locationIssues = issues?.filter(i => i.locations && i.locations.length > 0) || [];
    console.log(`📍 Issues with locations: ${locationIssues.length}`);

    if (locationIssues.length > 0) {
      console.log('\n✅ Location-specific issues found:');
      const locationCounts = {};
      locationIssues.forEach(issue => {
        issue.locations?.forEach(loc => {
          locationCounts[loc] = (locationCounts[loc] || 0) + 1;
        });
      });
      Object.entries(locationCounts).forEach(([loc, count]) => {
        console.log(`   ${loc}: ${count} issues`);
      });
    } else {
      console.log('⚠️  No location-specific issues found yet');
    }
  }

  // Check explanations
  const { data: explanations, error: explError } = await supabase
    .from('issue_explanations')
    .select('id, issue_id, viewpoint');

  if (explError) {
    console.error('❌ Error fetching explanations:', explError.message);
  } else {
    console.log(`\n📚 Total explanations: ${explanations?.length || 0}`);

    if (explanations && explanations.length > 0) {
      const viewpointCounts = {};
      explanations.forEach(e => {
        viewpointCounts[e.viewpoint] = (viewpointCounts[e.viewpoint] || 0) + 1;
      });
      console.log('   By viewpoint:');
      Object.entries(viewpointCounts).forEach(([vp, count]) => {
        console.log(`   - ${vp}: ${count}`);
      });
    } else {
      console.log('⚠️  No explanations found yet');
    }
  }

  console.log('\n' + '='.repeat(60));
  console.log('📋 Next Steps:');
  console.log('='.repeat(60));

  if (locationIssues.length === 0) {
    console.log('\n1. Run the location-specific issues SQL:');
    console.log('   - Open Supabase SQL Editor');
    console.log('   - Copy contents of: supabase/seed-issues-location-specific.sql');
    console.log('   - Execute the SQL');
  } else {
    console.log('\n✅ Location-specific issues already loaded!');
  }

  if (!explanations || explanations.length === 0) {
    console.log('\n2. Run the issue explanations SQL:');
    console.log('   - Open Supabase SQL Editor');
    console.log('   - Copy contents of: supabase/seed-issue-explanations.sql');
    console.log('   - Execute the SQL');
  } else {
    console.log('✅ Issue explanations already loaded!');
  }

  if (locationIssues.length > 0 && explanations && explanations.length > 0) {
    console.log('\n🎉 All location-specific data is loaded!');
    console.log('   Your system is ready to show state-specific issues with AI explanations.');
  }
}

checkStatus().catch(error => {
  console.error('❌ Fatal error:', error);
  process.exit(1);
});
