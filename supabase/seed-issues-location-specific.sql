-- Location-Specific Issues with AI-Generated Insights
-- Replaces generic issues with region-specific political topics

-- ============================================================
-- VIRGINIA ISSUES
-- ============================================================

INSERT INTO issues (id, title, slug, description, category, locations) VALUES
  (
    '550e8400-e29b-41d4-a716-446655440101',
    'Northern Virginia Transportation Infrastructure',
    'nova-transportation',
    'Should Virginia prioritize funding for roads, Metro expansion, and commuter rail in Northern Virginia?',
    'state',
    ARRAY['VA']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440102',
    'Virginia K-12 Education Standards',
    'va-education-standards',
    'Should Virginia maintain rigorous academic standards including the Standards of Learning (SOL) tests?',
    'state',
    ARRAY['VA']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440103',
    'Tech Corridor Economic Development',
    'va-tech-corridor',
    'Should Virginia provide tax incentives to attract technology companies and data centers?',
    'state',
    ARRAY['VA']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440104',
    'Loudoun County Growth Management',
    'loudoun-growth',
    'Should Loudoun County implement stricter growth controls to preserve rural character?',
    'local',
    ARRAY['VA']
  );

-- ============================================================
-- NORTH CAROLINA ISSUES
-- ============================================================

INSERT INTO issues (id, title, slug, description, category, locations) VALUES
  (
    '550e8400-e29b-41d4-a716-446655440201',
    'Rural Broadband Expansion',
    'nc-rural-broadband',
    'Should North Carolina invest more in expanding high-speed internet to rural areas?',
    'state',
    ARRAY['NC']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440202',
    'NC School Funding Formula',
    'nc-school-funding',
    'Should North Carolina increase per-pupil funding for public schools?',
    'state',
    ARRAY['NC']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440203',
    'Charlotte-Area Transit Expansion',
    'nc-transit',
    'Should the state support Charlotte-area light rail and bus rapid transit expansion?',
    'state',
    ARRAY['NC']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440204',
    'Agricultural Land Preservation',
    'nc-ag-preservation',
    'Should North Carolina provide tax incentives to preserve farmland from development?',
    'state',
    ARRAY['NC']
  );

-- ============================================================
-- UTAH ISSUES
-- ============================================================

INSERT INTO issues (id, title, slug, description, category, locations) VALUES
  (
    '550e8400-e29b-41d4-a716-446655440301',
    'Utah Water Rights and Conservation',
    'ut-water-rights',
    'Should Utah implement stricter water conservation measures and reform water rights allocation?',
    'state',
    ARRAY['UT']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440302',
    'Public Lands Management',
    'ut-public-lands',
    'Should Utah seek greater state control over federal public lands?',
    'state',
    ARRAY['UT']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440303',
    'Wasatch Front Air Quality',
    'ut-air-quality',
    'Should Utah implement stricter emissions standards to improve air quality along the Wasatch Front?',
    'state',
    ARRAY['UT']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440304',
    'Utah Housing Affordability',
    'ut-housing-affordability',
    'Should cities like Lehi ease zoning restrictions to increase housing supply?',
    'local',
    ARRAY['UT']
  );

-- ============================================================
-- TEXAS ISSUES
-- ============================================================

INSERT INTO issues (id, title, slug, description, category, locations) VALUES
  (
    '550e8400-e29b-41d4-a716-446655440401',
    'Texas Property Tax Reform',
    'tx-property-tax',
    'Should Texas cap property tax increases and provide homestead exemptions?',
    'state',
    ARRAY['TX']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440402',
    'Border Security Funding',
    'tx-border-security',
    'Should Texas increase state funding for border security operations?',
    'state',
    ARRAY['TX']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440403',
    'Power Grid Winterization',
    'tx-power-grid',
    'Should Texas mandate winterization and reliability standards for the power grid?',
    'state',
    ARRAY['TX']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440404',
    'Katy ISD Funding and Growth',
    'tx-katy-schools',
    'Should Katy ISD pursue bond measures to build new schools for growing population?',
    'local',
    ARRAY['TX']
  );

-- ============================================================
-- NEW JERSEY ISSUES
-- ============================================================

INSERT INTO issues (id, title, slug, description, category, locations) VALUES
  (
    '550e8400-e29b-41d4-a716-446655440501',
    'Coastal Protection and Beach Replenishment',
    'nj-coastal-protection',
    'Should New Jersey increase funding for beach replenishment and storm protection?',
    'state',
    ARRAY['NJ']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440502',
    'NJ Property Tax Relief',
    'nj-property-tax',
    'Should New Jersey implement property tax caps or provide rebates to homeowners?',
    'state',
    ARRAY['NJ']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440503',
    'Atlantic City Casino Revenue',
    'nj-casino-revenue',
    'Should casino tax revenue be redirected to support more local services?',
    'state',
    ARRAY['NJ']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440504',
    'Cape May Tourism Economy',
    'nj-tourism',
    'Should Cape May County invest more in tourism infrastructure and marketing?',
    'local',
    ARRAY['NJ']
  );

-- ============================================================
-- KANSAS ISSUES
-- ============================================================

INSERT INTO issues (id, title, slug, description, category, locations) VALUES
  (
    '550e8400-e29b-41d4-a716-446655440601',
    'Kansas School Funding Formula',
    'ks-school-funding',
    'Should Kansas increase education funding to meet constitutional adequacy requirements?',
    'state',
    ARRAY['KS']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440602',
    'Medicaid Expansion',
    'ks-medicaid',
    'Should Kansas expand Medicaid eligibility under the Affordable Care Act?',
    'state',
    ARRAY['KS']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440603',
    'Wind Energy Development',
    'ks-wind-energy',
    'Should Kansas continue incentivizing wind energy development?',
    'state',
    ARRAY['KS']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440604',
    'Wichita Area Growth',
    'ks-wichita-growth',
    'Should cities like Andover pursue annexation and development to attract businesses?',
    'local',
    ARRAY['KS']
  );

-- ============================================================
-- MICHIGAN ISSUES
-- ============================================================

INSERT INTO issues (id, title, slug, description, category, locations) VALUES
  (
    '550e8400-e29b-41d4-a716-446655440701',
    'Great Lakes Water Quality',
    'mi-water-quality',
    'Should Michigan increase regulations to protect Great Lakes from contamination?',
    'state',
    ARRAY['MI']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440702',
    'Michigan Infrastructure Investment',
    'mi-infrastructure',
    'Should Michigan raise the gas tax to fund road repairs ("Fix the Damn Roads")?',
    'state',
    ARRAY['MI']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440703',
    'Rural Economic Development',
    'mi-rural-economy',
    'Should Michigan provide tax incentives to attract businesses to rural areas?',
    'state',
    ARRAY['MI']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440704',
    'Tourism and Recreation Funding',
    'mi-tourism',
    'Should Michigan invest more in state parks and tourism infrastructure?',
    'state',
    ARRAY['MI']
  );

-- ============================================================
-- SHARED/COMMON ISSUES (Available to all locations)
-- ============================================================

INSERT INTO issues (id, title, slug, description, category, locations) VALUES
  (
    '550e8400-e29b-41d4-a716-446655440801',
    'Local Education Funding',
    'local-education',
    'Should your local school district increase spending per student?',
    'local',
    ARRAY['VA', 'NC', 'UT', 'TX', 'NJ', 'KS', 'MI']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440802',
    'Public Safety Funding',
    'local-public-safety',
    'Should your local government increase funding for police and fire services?',
    'local',
    ARRAY['VA', 'NC', 'UT', 'TX', 'NJ', 'KS', 'MI']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440803',
    'Small Business Support',
    'local-small-business',
    'Should your local government provide tax incentives and support for small businesses?',
    'local',
    ARRAY['VA', 'NC', 'UT', 'TX', 'NJ', 'KS', 'MI']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440804',
    'Infrastructure Maintenance',
    'local-infrastructure',
    'Should your local government prioritize infrastructure repairs and improvements?',
    'local',
    ARRAY['VA', 'NC', 'UT', 'TX', 'NJ', 'KS', 'MI']
  ),
  (
    '550e8400-e29b-41d4-a716-446655440805',
    'Environmental Protection',
    'local-environment',
    'Should your local government strengthen environmental regulations?',
    'local',
    ARRAY['VA', 'NC', 'UT', 'TX', 'NJ', 'KS', 'MI']
  );
