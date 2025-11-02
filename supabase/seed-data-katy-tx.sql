-- Expanded Katy, Texas data - Multiple offices
-- Provides comprehensive ballot coverage for all local/state races

-- ============================================================
-- SOURCES (Add Texas-specific sources)
-- ============================================================

INSERT INTO sources (id, name, url, source_type, credibility_score, bias_rating) VALUES
  (
    '660e8400-e29b-41d4-a716-446655440008',
    'City of Katy Government',
    'https://www.cityofkaty.com',
    'government',
    5,
    'center'
  ),
  (
    '660e8400-e29b-41d4-a716-446655440009',
    'Texas Municipal League',
    'https://www.tml.org',
    'nonprofit',
    5,
    'center'
  );

-- ============================================================
-- CANDIDATES - Multiple Offices for Katy, TX (Zip: 77449, 77450, 77493)
-- ============================================================

-- CITY COUNCIL
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440040',
    'Bill Hastings',
    'Katy City Council - At Large Position 1',
    'Non-partisan',
    'Local business owner focused on economic development, infrastructure investment, and maintaining Katy''s family-friendly character.',
    ARRAY['77449', '77450', '77493']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440041',
    'Janet Chen',
    'Katy City Council - At Large Position 1',
    'Non-partisan',
    'Community volunteer advocating for parks and recreation, public safety, and transparent government.',
    ARRAY['77449', '77450', '77493']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440042',
    'Chris Morgan',
    'Katy City Council - Ward A',
    'Non-partisan',
    'Engineer focused on flood control, traffic management, and sustainable growth in rapidly developing areas.',
    ARRAY['77449']
  );

-- SCHOOL BOARD (Katy ISD)
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440043',
    'Dawn Patterson',
    'Katy ISD Board of Trustees - Position 4',
    'Non-partisan',
    'Former teacher advocating for teacher retention, academic excellence, and parent engagement in schools.',
    ARRAY['77449', '77450', '77493']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440044',
    'Victor Ramirez',
    'Katy ISD Board of Trustees - Position 4',
    'Non-partisan',
    'Business executive focused on fiscal responsibility, career readiness programs, and educational innovation.',
    ARRAY['77449', '77450', '77493']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440045',
    'Rebecca Holmes',
    'Katy ISD Board of Trustees - Position 5',
    'Non-partisan',
    'Parent and community leader advocating for special education resources, mental health support, and school safety.',
    ARRAY['77449', '77450', '77493']
  );

-- STATE HOUSE
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440046',
    'Michael Bradford',
    'Texas House - District 132',
    'Republican',
    'Small business owner advocating for lower property taxes, border security, and limited government regulation.',
    ARRAY['77449', '77450']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440047',
    'Sandra Lopez',
    'Texas House - District 132',
    'Democrat',
    'Healthcare professional focused on Medicaid expansion, public education funding, and affordable healthcare.',
    ARRAY['77449', '77450']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440048',
    'Robert Ellis',
    'Texas House - District 28',
    'Republican',
    'Attorney focused on property rights, infrastructure investment, and supporting law enforcement.',
    ARRAY['77493']
  );

-- STATE SENATE
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440049',
    'Paul Henderson',
    'Texas Senate - District 7',
    'Republican',
    'Incumbent senator with focus on property tax reform, education choice, and economic growth.',
    ARRAY['77449', '77450', '77493']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440050',
    'Maria Gonzalez',
    'Texas Senate - District 7',
    'Democrat',
    'Civil rights attorney advocating for healthcare access, education funding, and criminal justice reform.',
    ARRAY['77449', '77450', '77493']
  );

-- COUNTY COMMISSIONER (Fort Bend County)
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440051',
    'James Tucker',
    'Fort Bend County Commissioner - Precinct 3',
    'Republican',
    'Engineer focused on flood mitigation, road improvements, and responsible county budget management.',
    ARRAY['77449', '77450', '77493']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440052',
    'Linda Washington',
    'Fort Bend County Commissioner - Precinct 3',
    'Democrat',
    'Community organizer advocating for affordable housing, public health services, and environmental protection.',
    ARRAY['77449', '77450', '77493']
  );

-- ============================================================
-- CANDIDATE POSITIONS - All Katy candidates
-- ============================================================

-- Bill Hastings (City Council) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports business incentives and economic development', '660e8400-e29b-41d4-a716-446655440008'),
  ('770e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports infrastructure investment for growing city', '660e8400-e29b-41d4-a716-446655440008'),
  ('770e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes property tax increases', '660e8400-e29b-41d4-a716-446655440008'),
  ('770e8400-e29b-41d4-a716-446655440040', '550e8400-e29b-41d4-a716-446655440003', 4, 'Supports managed residential development', '660e8400-e29b-41d4-a716-446655440008');

-- Janet Chen (City Council) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440041', '550e8400-e29b-41d4-a716-446655440006', 5, 'Strongly supports public safety funding', '660e8400-e29b-41d4-a716-446655440008'),
  ('770e8400-e29b-41d4-a716-446655440041', '550e8400-e29b-41d4-a716-446655440005', 4, 'Supports environmental protections and green spaces', '660e8400-e29b-41d4-a716-446655440008'),
  ('770e8400-e29b-41d4-a716-446655440041', '550e8400-e29b-41d4-a716-446655440001', 4, 'Supports education funding for quality schools', '660e8400-e29b-41d4-a716-446655440009');

-- Chris Morgan (City Council) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440042', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports infrastructure for flood control and traffic', '660e8400-e29b-41d4-a716-446655440008'),
  ('770e8400-e29b-41d4-a716-446655440042', '550e8400-e29b-41d4-a716-446655440003', 3, 'Supports balanced development with infrastructure planning', '660e8400-e29b-41d4-a716-446655440008'),
  ('770e8400-e29b-41d4-a716-446655440042', '550e8400-e29b-41d4-a716-446655440005', 4, 'Supports environmental protections especially for watersheds', '660e8400-e29b-41d4-a716-446655440008');

-- Dawn Patterson (School Board) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440043', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports education funding for teacher pay', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440043', '550e8400-e29b-41d4-a716-446655440002', 4, 'Supports tax increases for education priorities', '660e8400-e29b-41d4-a716-446655440009');

-- Victor Ramirez (School Board) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440044', '550e8400-e29b-41d4-a716-446655440001', 4, 'Supports education funding with accountability', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440044', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports business partnerships in education', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440044', '550e8400-e29b-41d4-a716-446655440002', 3, 'Supports efficient use of current funding', '660e8400-e29b-41d4-a716-446655440009');

-- Rebecca Holmes (School Board) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440045', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports education funding for special programs', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440045', '550e8400-e29b-41d4-a716-446655440006', 5, 'Strongly supports school safety initiatives', '660e8400-e29b-41d4-a716-446655440009');

-- Michael Bradford (State House 132) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440046', '550e8400-e29b-41d4-a716-446655440002', 1, 'Strongly opposes property tax increases', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440046', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports tax cuts for businesses', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440046', '550e8400-e29b-41d4-a716-446655440008', 2, 'Opposes Medicaid expansion', '660e8400-e29b-41d4-a716-446655440009');

-- Sandra Lopez (State House 132) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440047', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports education funding', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440047', '550e8400-e29b-41d4-a716-446655440008', 5, 'Strongly supports Medicaid expansion', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440047', '550e8400-e29b-41d4-a716-446655440006', 4, 'Supports public health and safety funding', '660e8400-e29b-41d4-a716-446655440009');

-- Robert Ellis (State House 28) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440048', '550e8400-e29b-41d4-a716-446655440006', 5, 'Strongly supports law enforcement funding', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440048', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports infrastructure investment', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440048', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes property tax increases', '660e8400-e29b-41d4-a716-446655440009');

-- Paul Henderson (State Senate 7) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440049', '550e8400-e29b-41d4-a716-446655440002', 1, 'Strongly opposes property tax increases', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440049', '550e8400-e29b-41d4-a716-446655440001', 3, 'Supports school choice and charter schools', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440049', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports business-friendly policies', '660e8400-e29b-41d4-a716-446655440009');

-- Maria Gonzalez (State Senate 7) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440050', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports public education funding', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440050', '550e8400-e29b-41d4-a716-446655440008', 5, 'Strongly supports healthcare access', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440050', '550e8400-e29b-41d4-a716-446655440003', 4, 'Supports affordable housing initiatives', '660e8400-e29b-41d4-a716-446655440009');

-- James Tucker (County Commissioner) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440051', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports flood control and infrastructure', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440051', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes county tax increases', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440051', '550e8400-e29b-41d4-a716-446655440003', 4, 'Supports development with flood mitigation', '660e8400-e29b-41d4-a716-446655440009');

-- Linda Washington (County Commissioner) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440052', '550e8400-e29b-41d4-a716-446655440003', 5, 'Strongly supports affordable housing', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440052', '550e8400-e29b-41d4-a716-446655440008', 5, 'Strongly supports public health services', '660e8400-e29b-41d4-a716-446655440009'),
  ('770e8400-e29b-41d4-a716-446655440052', '550e8400-e29b-41d4-a716-446655440005', 5, 'Strongly supports environmental protection', '660e8400-e29b-41d4-a716-446655440009');
