-- Expanded Bear Lake, Michigan data - Multiple offices
-- Provides comprehensive ballot coverage for all local/state races

-- ============================================================
-- SOURCES (Add Michigan-specific sources)
-- ============================================================

INSERT INTO sources (id, name, url, source_type, credibility_score, bias_rating) VALUES
  (
    '660e8400-e29b-41d4-a716-446655440014',
    'Bear Lake Township Government',
    'https://www.bearlaketwp.org',
    'government',
    5,
    'center'
  ),
  (
    '660e8400-e29b-41d4-a716-446655440015',
    'Michigan Municipal League',
    'https://www.mml.org',
    'nonprofit',
    5,
    'center'
  );

-- ============================================================
-- CANDIDATES - Multiple Offices for Bear Lake, MI (Zip: 49614)
-- ============================================================

-- TOWNSHIP BOARD
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440080',
    'Tom Harrison',
    'Bear Lake Township Supervisor',
    'Non-partisan',
    'Long-time resident focused on preserving rural character, managing lake access, and fiscal responsibility.',
    ARRAY['49614']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440081',
    'Linda Peterson',
    'Bear Lake Township Supervisor',
    'Non-partisan',
    'Former county official advocating for economic development, infrastructure improvements, and community services.',
    ARRAY['49614']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440082',
    'James Miller',
    'Bear Lake Township Trustee',
    'Non-partisan',
    'Business owner focused on property rights, lake quality, and supporting local businesses.',
    ARRAY['49614']
  );

-- SCHOOL BOARD (Onekama Consolidated Schools)
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440083',
    'Margaret Collins',
    'Onekama Consolidated Schools Board',
    'Non-partisan',
    'Retired teacher advocating for small class sizes, teacher retention, and academic excellence.',
    ARRAY['49614']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440084',
    'Robert Jenkins',
    'Onekama Consolidated Schools Board',
    'Non-partisan',
    'Parent and engineer focused on STEM education, fiscal responsibility, and facility maintenance.',
    ARRAY['49614']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440085',
    'Susan Hayes',
    'Onekama Consolidated Schools Board',
    'Non-partisan',
    'Community volunteer advocating for arts programs, special education support, and parent involvement.',
    ARRAY['49614']
  );

-- STATE HOUSE
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440086',
    'Jack O''Malley',
    'Michigan House - District 101',
    'Republican',
    'Incumbent representative focused on rural issues, property tax relief, and supporting agriculture.',
    ARRAY['49614']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440087',
    'Emily Richardson',
    'Michigan House - District 101',
    'Democrat',
    'Environmental scientist advocating for clean water, education funding, and healthcare access.',
    ARRAY['49614']
  );

-- STATE SENATE
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440088',
    'Curt VanderWall',
    'Michigan Senate - District 35',
    'Republican',
    'Incumbent senator with focus on agriculture, tourism, and reducing government regulation.',
    ARRAY['49614']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440089',
    'Rachel Morgan',
    'Michigan Senate - District 35',
    'Democrat',
    'Healthcare administrator advocating for Medicaid expansion, public education, and environmental protection.',
    ARRAY['49614']
  );

-- COUNTY COMMISSIONER (Manistee County)
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440090',
    'Jeffrey Dontz',
    'Manistee County Commissioner - District 2',
    'Republican',
    'Business owner focused on economic development, infrastructure, and supporting tourism.',
    ARRAY['49614']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440091',
    'Patricia Wilson',
    'Manistee County Commissioner - District 2',
    'Democrat',
    'Social worker advocating for public health services, affordable housing, and community programs.',
    ARRAY['49614']
  );

-- VILLAGE COUNCIL (Bear Lake Village)
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440092',
    'Donald Burke',
    'Bear Lake Village President',
    'Non-partisan',
    'Retired engineer focused on water quality, infrastructure maintenance, and preserving village character.',
    ARRAY['49614']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440093',
    'Carol Anderson',
    'Bear Lake Village President',
    'Non-partisan',
    'Local business owner advocating for economic vitality, tourism promotion, and community engagement.',
    ARRAY['49614']
  );

-- ============================================================
-- CANDIDATE POSITIONS - All Bear Lake candidates
-- ============================================================

-- Tom Harrison (Township Supervisor) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440080', '550e8400-e29b-41d4-a716-446655440005', 5, 'Strongly supports lake and environmental protection', '660e8400-e29b-41d4-a716-446655440014'),
  ('770e8400-e29b-41d4-a716-446655440080', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes property tax increases', '660e8400-e29b-41d4-a716-446655440014'),
  ('770e8400-e29b-41d4-a716-446655440080', '550e8400-e29b-41d4-a716-446655440003', 2, 'Opposes rapid development', '660e8400-e29b-41d4-a716-446655440014');

-- Linda Peterson (Township Supervisor) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440081', '550e8400-e29b-41d4-a716-446655440007', 4, 'Supports economic development initiatives', '660e8400-e29b-41d4-a716-446655440014'),
  ('770e8400-e29b-41d4-a716-446655440081', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports infrastructure improvements', '660e8400-e29b-41d4-a716-446655440014'),
  ('770e8400-e29b-41d4-a716-446655440081', '550e8400-e29b-41d4-a716-446655440006', 4, 'Supports public safety services', '660e8400-e29b-41d4-a716-446655440014');

-- James Miller (Township Trustee) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440082', '550e8400-e29b-41d4-a716-446655440005', 5, 'Strongly supports lake water quality', '660e8400-e29b-41d4-a716-446655440014'),
  ('770e8400-e29b-41d4-a716-446655440082', '550e8400-e29b-41d4-a716-446655440007', 4, 'Supports local business development', '660e8400-e29b-41d4-a716-446655440014'),
  ('770e8400-e29b-41d4-a716-446655440082', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes tax increases', '660e8400-e29b-41d4-a716-446655440014');

-- Margaret Collins (School Board) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440083', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports education funding for small schools', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440083', '550e8400-e29b-41d4-a716-446655440002', 4, 'Supports investment in education', '660e8400-e29b-41d4-a716-446655440015');

-- Robert Jenkins (School Board) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440084', '550e8400-e29b-41d4-a716-446655440001', 4, 'Supports education funding with accountability', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440084', '550e8400-e29b-41d4-a716-446655440007', 4, 'Supports STEM education programs', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440084', '550e8400-e29b-41d4-a716-446655440009', 4, 'Supports school facility maintenance', '660e8400-e29b-41d4-a716-446655440015');

-- Susan Hayes (School Board) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440085', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports arts and special education', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440085', '550e8400-e29b-41d4-a716-446655440006', 4, 'Supports school safety programs', '660e8400-e29b-41d4-a716-446655440015');

-- Jack O'Malley (State House) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440086', '550e8400-e29b-41d4-a716-446655440002', 1, 'Strongly opposes property tax increases', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440086', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports agriculture and rural businesses', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440086', '550e8400-e29b-41d4-a716-446655440005', 3, 'Supports balanced environmental approach', '660e8400-e29b-41d4-a716-446655440015');

-- Emily Richardson (State House) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440087', '550e8400-e29b-41d4-a716-446655440005', 5, 'Strongly supports water quality protection', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440087', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports education funding', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440087', '550e8400-e29b-41d4-a716-446655440008', 4, 'Supports healthcare access in rural areas', '660e8400-e29b-41d4-a716-446655440015');

-- Curt VanderWall (State Senate) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440088', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports agriculture and tourism', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440088', '550e8400-e29b-41d4-a716-446655440002', 1, 'Strongly opposes tax increases', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440088', '550e8400-e29b-41d4-a716-446655440008', 2, 'Opposes Medicaid expansion', '660e8400-e29b-41d4-a716-446655440015');

-- Rachel Morgan (State Senate) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440089', '550e8400-e29b-41d4-a716-446655440008', 5, 'Strongly supports Medicaid and healthcare access', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440089', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports public education', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440089', '550e8400-e29b-41d4-a716-446655440005', 5, 'Strongly supports environmental protection', '660e8400-e29b-41d4-a716-446655440015');

-- Jeffrey Dontz (County Commissioner) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440090', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports economic and tourism development', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440090', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports infrastructure investment', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440090', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes county tax increases', '660e8400-e29b-41d4-a716-446655440015');

-- Patricia Wilson (County Commissioner) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440091', '550e8400-e29b-41d4-a716-446655440008', 5, 'Strongly supports public health services', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440091', '550e8400-e29b-41d4-a716-446655440003', 4, 'Supports affordable housing initiatives', '660e8400-e29b-41d4-a716-446655440015'),
  ('770e8400-e29b-41d4-a716-446655440091', '550e8400-e29b-41d4-a716-446655440006', 4, 'Supports community safety programs', '660e8400-e29b-41d4-a716-446655440015');

-- Donald Burke (Village President) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440092', '550e8400-e29b-41d4-a716-446655440005', 5, 'Strongly supports water quality protection', '660e8400-e29b-41d4-a716-446655440014'),
  ('770e8400-e29b-41d4-a716-446655440092', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports infrastructure maintenance', '660e8400-e29b-41d4-a716-446655440014'),
  ('770e8400-e29b-41d4-a716-446655440092', '550e8400-e29b-41d4-a716-446655440003', 2, 'Opposes large-scale development', '660e8400-e29b-41d4-a716-446655440014');

-- Carol Anderson (Village President) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440093', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports tourism and local business', '660e8400-e29b-41d4-a716-446655440014'),
  ('770e8400-e29b-41d4-a716-446655440093', '550e8400-e29b-41d4-a716-446655440009', 4, 'Supports infrastructure improvements', '660e8400-e29b-41d4-a716-446655440014'),
  ('770e8400-e29b-41d4-a716-446655440093', '550e8400-e29b-41d4-a716-446655440005', 4, 'Supports environmental protection with tourism', '660e8400-e29b-41d4-a716-446655440014');
