-- Expanded Andover, Kansas data - Multiple offices
-- Provides comprehensive ballot coverage for all local/state races

-- ============================================================
-- SOURCES (Add Kansas-specific sources)
-- ============================================================

INSERT INTO sources (id, name, url, source_type, credibility_score, bias_rating) VALUES
  (
    '660e8400-e29b-41d4-a716-446655440012',
    'City of Andover Government',
    'https://www.andoverks.com',
    'government',
    5,
    'center'
  ),
  (
    '660e8400-e29b-41d4-a716-446655440013',
    'Kansas League of Municipalities',
    'https://www.lkm.org',
    'nonprofit',
    5,
    'center'
  );

-- ============================================================
-- CANDIDATES - Multiple Offices for Andover, KS (Zip: 67002)
-- ============================================================

-- CITY COUNCIL
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440066',
    'Ben Lawrence',
    'Andover City Council - Ward 1',
    'Non-partisan',
    'Local business owner focused on economic development, infrastructure, and maintaining small-town character.',
    ARRAY['67002']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440067',
    'Nicole Stevens',
    'Andover City Council - Ward 1',
    'Non-partisan',
    'Community volunteer advocating for parks and recreation, public safety, and family-friendly policies.',
    ARRAY['67002']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440068',
    'Mike Patterson',
    'Andover City Council - At Large',
    'Non-partisan',
    'Retired military officer focused on fiscal responsibility, public safety, and veterans services.',
    ARRAY['67002']
  );

-- SCHOOL BOARD (Andover USD 385)
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440069',
    'Jennifer Thomas',
    'Andover USD 385 School Board - Position 1',
    'Non-partisan',
    'Parent and educator advocating for academic excellence, teacher support, and modern facilities.',
    ARRAY['67002']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440070',
    'David Wilson',
    'Andover USD 385 School Board - Position 1',
    'Non-partisan',
    'Engineer focused on fiscal responsibility, STEM education, and community partnerships.',
    ARRAY['67002']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440071',
    'Sarah Martinez',
    'Andover USD 385 School Board - Position 2',
    'Non-partisan',
    'Small business owner advocating for career readiness, extracurricular programs, and parental involvement.',
    ARRAY['67002']
  );

-- STATE HOUSE
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440072',
    'John Bradford',
    'Kansas House - District 97',
    'Republican',
    'Farmer and business owner advocating for lower taxes, limited government, and agriculture support.',
    ARRAY['67002']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440073',
    'Amanda Clark',
    'Kansas House - District 97',
    'Democrat',
    'Teacher focused on education funding, healthcare access, and infrastructure investment.',
    ARRAY['67002']
  );

-- STATE SENATE
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440074',
    'Ty Masterson',
    'Kansas Senate - District 16',
    'Republican',
    'Incumbent senator focused on tax cuts, education choice, and supporting local businesses.',
    ARRAY['67002']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440075',
    'Lisa Johnson',
    'Kansas Senate - District 16',
    'Democrat',
    'Healthcare professional advocating for Medicaid expansion, public schools, and rural healthcare access.',
    ARRAY['67002']
  );

-- COUNTY COMMISSIONER (Butler County)
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440076',
    'Dan Woydziak',
    'Butler County Commissioner - District 3',
    'Republican',
    'Business owner focused on economic development, road improvements, and responsible county spending.',
    ARRAY['67002']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440077',
    'Karen Mitchell',
    'Butler County Commissioner - District 3',
    'Democrat',
    'Social services professional advocating for healthcare access, public services, and community development.',
    ARRAY['67002']
  );

-- MAYOR
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440078',
    'Julie Smith',
    'Andover Mayor',
    'Non-partisan',
    'Current city council member focused on managed growth, economic development, and community engagement.',
    ARRAY['67002']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440079',
    'Robert Anderson',
    'Andover Mayor',
    'Non-partisan',
    'Business executive advocating for infrastructure investment, public safety, and preserving quality of life.',
    ARRAY['67002']
  );

-- ============================================================
-- CANDIDATE POSITIONS - All Andover candidates
-- ============================================================

-- Ben Lawrence (City Council) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440066', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports small business development', '660e8400-e29b-41d4-a716-446655440012'),
  ('770e8400-e29b-41d4-a716-446655440066', '550e8400-e29b-41d4-a716-446655440009', 4, 'Supports infrastructure improvements', '660e8400-e29b-41d4-a716-446655440012'),
  ('770e8400-e29b-41d4-a716-446655440066', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes tax increases', '660e8400-e29b-41d4-a716-446655440012');

-- Nicole Stevens (City Council) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440067', '550e8400-e29b-41d4-a716-446655440006', 5, 'Strongly supports public safety funding', '660e8400-e29b-41d4-a716-446655440012'),
  ('770e8400-e29b-41d4-a716-446655440067', '550e8400-e29b-41d4-a716-446655440005', 4, 'Supports parks and green space preservation', '660e8400-e29b-41d4-a716-446655440012'),
  ('770e8400-e29b-41d4-a716-446655440067', '550e8400-e29b-41d4-a716-446655440001', 4, 'Supports quality schools and education', '660e8400-e29b-41d4-a716-446655440012');

-- Mike Patterson (City Council) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440068', '550e8400-e29b-41d4-a716-446655440002', 1, 'Strongly opposes tax increases', '660e8400-e29b-41d4-a716-446655440012'),
  ('770e8400-e29b-41d4-a716-446655440068', '550e8400-e29b-41d4-a716-446655440006', 5, 'Strongly supports public safety and veterans', '660e8400-e29b-41d4-a716-446655440012'),
  ('770e8400-e29b-41d4-a716-446655440068', '550e8400-e29b-41d4-a716-446655440009', 4, 'Supports infrastructure investment', '660e8400-e29b-41d4-a716-446655440012');

-- Jennifer Thomas (School Board) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440069', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports education funding and teacher pay', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440069', '550e8400-e29b-41d4-a716-446655440002', 4, 'Supports investment in school facilities', '660e8400-e29b-41d4-a716-446655440013');

-- David Wilson (School Board) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440070', '550e8400-e29b-41d4-a716-446655440001', 4, 'Supports education funding with accountability', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440070', '550e8400-e29b-41d4-a716-446655440007', 4, 'Supports STEM partnerships with businesses', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440070', '550e8400-e29b-41d4-a716-446655440002', 3, 'Supports efficient use of resources', '660e8400-e29b-41d4-a716-446655440013');

-- Sarah Martinez (School Board) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440071', '550e8400-e29b-41d4-a716-446655440001', 4, 'Supports education funding for programs', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440071', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports career readiness programs', '660e8400-e29b-41d4-a716-446655440013');

-- John Bradford (State House) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440072', '550e8400-e29b-41d4-a716-446655440002', 1, 'Strongly opposes tax increases', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440072', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports agriculture and small business', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440072', '550e8400-e29b-41d4-a716-446655440008', 2, 'Opposes Medicaid expansion', '660e8400-e29b-41d4-a716-446655440013');

-- Amanda Clark (State House) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440073', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports education funding', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440073', '550e8400-e29b-41d4-a716-446655440008', 4, 'Supports healthcare access expansion', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440073', '550e8400-e29b-41d4-a716-446655440009', 4, 'Supports infrastructure investment', '660e8400-e29b-41d4-a716-446655440013');

-- Ty Masterson (State Senate) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440074', '550e8400-e29b-41d4-a716-446655440002', 1, 'Strongly opposes tax increases', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440074', '550e8400-e29b-41d4-a716-446655440001', 3, 'Supports school choice initiatives', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440074', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports business-friendly policies', '660e8400-e29b-41d4-a716-446655440013');

-- Lisa Johnson (State Senate) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440075', '550e8400-e29b-41d4-a716-446655440008', 5, 'Strongly supports Medicaid expansion', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440075', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports public school funding', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440075', '550e8400-e29b-41d4-a716-446655440006', 4, 'Supports public safety and rural healthcare', '660e8400-e29b-41d4-a716-446655440013');

-- Dan Woydziak (County Commissioner) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440076', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports economic development', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440076', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports road improvements', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440076', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes county tax increases', '660e8400-e29b-41d4-a716-446655440013');

-- Karen Mitchell (County Commissioner) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440077', '550e8400-e29b-41d4-a716-446655440008', 5, 'Strongly supports healthcare access', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440077', '550e8400-e29b-41d4-a716-446655440001', 4, 'Supports education and community services', '660e8400-e29b-41d4-a716-446655440013'),
  ('770e8400-e29b-41d4-a716-446655440077', '550e8400-e29b-41d4-a716-446655440003', 4, 'Supports community development initiatives', '660e8400-e29b-41d4-a716-446655440013');

-- Julie Smith (Mayor) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440078', '550e8400-e29b-41d4-a716-446655440003', 4, 'Supports managed growth policies', '660e8400-e29b-41d4-a716-446655440012'),
  ('770e8400-e29b-41d4-a716-446655440078', '550e8400-e29b-41d4-a716-446655440007', 4, 'Supports economic development', '660e8400-e29b-41d4-a716-446655440012'),
  ('770e8400-e29b-41d4-a716-446655440078', '550e8400-e29b-41d4-a716-446655440006', 4, 'Supports public safety services', '660e8400-e29b-41d4-a716-446655440012');

-- Robert Anderson (Mayor) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440079', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports infrastructure investment', '660e8400-e29b-41d4-a716-446655440012'),
  ('770e8400-e29b-41d4-a716-446655440079', '550e8400-e29b-41d4-a716-446655440006', 5, 'Strongly supports public safety', '660e8400-e29b-41d4-a716-446655440012'),
  ('770e8400-e29b-41d4-a716-446655440079', '550e8400-e29b-41d4-a716-446655440003', 3, 'Supports balanced growth', '660e8400-e29b-41d4-a716-446655440012');
