#!/usr/bin/env node

/**
 * Seed location-specific issues and explanations
 * Migrates the issues table to add locations field, then seeds new location-specific issues
 */

import { createClient } from '@supabase/supabase-js';
import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import dotenv from 'dotenv';

// Load environment variables
dotenv.config({ path: '.env.local' });

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Missing Supabase credentials in .env.local');
  console.error('Make sure NEXT_PUBLIC_SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY are set');
  process.exit(1);
}

// Use service role key to bypass RLS policies
const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function runMigration() {
  console.log('📦 Running migration to add locations field...');

  const migrationPath = join(__dirname, '..', 'supabase', 'migrations', '002_add_location_to_issues.sql');
  const migrationSQL = readFileSync(migrationPath, 'utf-8');

  // Execute migration using raw SQL
  const { error } = await supabase.rpc('exec_sql', { sql: migrationSQL });

  if (error) {
    console.error('⚠️  Migration may have already run or failed:', error.message);
  } else {
    console.log('✅ Migration completed successfully');
  }
}

async function parseIssueInsert(statement) {
  // Match issue INSERT statements with locations array
  const issuePattern = /\(\s*'([^']+)',\s*'([^']+)',\s*'([^']+)',\s*'([^']+)',\s*'([^']+)',\s*ARRAY\[([^\]]+)\]\s*\)/g;

  const results = [];
  const matches = statement.matchAll(issuePattern);

  for (const match of matches) {
    const [, id, title, slug, description, category, locationsStr] = match;
    const locations = locationsStr.split(',').map(l => l.trim().replace(/'/g, ''));

    const { error } = await supabase.from('issues').insert({
      id,
      title,
      slug,
      description,
      category,
      locations
    });

    if (error && !error.message.includes('duplicate')) {
      results.push({ success: false, title, error: error.message });
    } else if (!error) {
      results.push({ success: true, title });
    } else {
      results.push({ success: true, title, skipped: true });
    }
  }

  return results;
}

async function parseExplanationInsert(statement) {
  // Match explanation INSERT statements
  const explanationPattern = /\(\s*'([^']+)',\s*'([^']+)',\s*'([^']+)'\s*\)/gs;

  const results = [];
  const matches = statement.matchAll(explanationPattern);

  for (const match of matches) {
    const [, issue_id, explanation, viewpoint] = match;

    const { error } = await supabase.from('issue_explanations').insert({
      issue_id,
      explanation,
      viewpoint
    });

    if (error && !error.message.includes('duplicate')) {
      results.push({ success: false, error: error.message });
    } else if (!error) {
      results.push({ success: true });
    } else {
      results.push({ success: true, skipped: true });
    }
  }

  return results;
}

async function seedLocationIssues() {
  console.log('\n🌱 Seeding location-specific issues...');

  const issuesPath = join(__dirname, '..', 'supabase', 'seed-issues-location-specific.sql');
  const issuesSQL = readFileSync(issuesPath, 'utf-8');

  const statements = issuesSQL
    .split(/INSERT INTO/)
    .filter(stmt => stmt.trim().length > 0)
    .map(stmt => 'INSERT INTO' + stmt);

  let issuesAdded = 0;
  let issuesSkipped = 0;

  for (const statement of statements) {
    if (statement.includes('issues')) {
      const results = await parseIssueInsert(statement);
      for (const result of results) {
        if (result.success && !result.skipped) {
          console.log(`  ✓ Added issue: ${result.title}`);
          issuesAdded++;
        } else if (result.skipped) {
          console.log(`  ℹ️  Issue already exists: ${result.title}`);
          issuesSkipped++;
        } else {
          console.error(`  ⚠️  Error adding issue "${result.title}":`, result.error);
        }
      }
    }
  }

  console.log(`\n✅ Issues seeded: ${issuesAdded} added, ${issuesSkipped} skipped`);
  return { issuesAdded, issuesSkipped };
}

async function seedExplanations() {
  console.log('\n📚 Seeding issue explanations...');

  const explanationsPath = join(__dirname, '..', 'supabase', 'seed-issue-explanations.sql');
  const explanationsSQL = readFileSync(explanationsPath, 'utf-8');

  const statements = explanationsSQL
    .split(/INSERT INTO/)
    .filter(stmt => stmt.trim().length > 0)
    .map(stmt => 'INSERT INTO' + stmt);

  let explanationsAdded = 0;
  let explanationsSkipped = 0;

  for (const statement of statements) {
    if (statement.includes('issue_explanations')) {
      const results = await parseExplanationInsert(statement);
      explanationsAdded += results.filter(r => r.success && !r.skipped).length;
      explanationsSkipped += results.filter(r => r.skipped).length;
    }
  }

  console.log(`✅ Explanations seeded: ${explanationsAdded} added, ${explanationsSkipped} skipped`);
  return { explanationsAdded, explanationsSkipped };
}

async function main() {
  console.log('🚀 Starting location-specific issues setup...\n');

  // Step 1: Run migration
  await runMigration();

  // Step 2: Seed location-specific issues
  const issueResults = await seedLocationIssues();

  // Step 3: Seed explanations
  const explanationResults = await seedExplanations();

  console.log('\n' + '='.repeat(60));
  console.log('🎉 LOCATION-SPECIFIC ISSUES SETUP COMPLETE!');
  console.log('='.repeat(60));
  console.log(`\n📊 Summary:`);
  console.log(`   ✅ Issues added: ${issueResults.issuesAdded}`);
  console.log(`   ℹ️  Issues skipped: ${issueResults.issuesSkipped}`);
  console.log(`   ✅ Explanations added: ${explanationResults.explanationsAdded}`);
  console.log(`   ℹ️  Explanations skipped: ${explanationResults.explanationsSkipped}`);
  console.log(`\n📍 Location-specific issues now available for:`);
  console.log(`   • Virginia (VA)`);
  console.log(`   • North Carolina (NC)`);
  console.log(`   • Utah (UT)`);
  console.log(`   • Texas (TX)`);
  console.log(`   • New Jersey (NJ)`);
  console.log(`   • Kansas (KS)`);
  console.log(`   • Michigan (MI)`);
}

main().catch(error => {
  console.error('❌ Fatal error:', error);
  process.exit(1);
});
