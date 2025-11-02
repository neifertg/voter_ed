-- Expanded Cape May County, New Jersey data - Multiple offices
-- Provides comprehensive ballot coverage for all local/state races

-- ============================================================
-- SOURCES (Add New Jersey-specific sources)
-- ============================================================

INSERT INTO sources (id, name, url, source_type, credibility_score, bias_rating) VALUES
  (
    '660e8400-e29b-41d4-a716-446655440010',
    'Cape May County Government',
    'https://www.capemaycountynj.gov',
    'government',
    5,
    'center'
  ),
  (
    '660e8400-e29b-41d4-a716-446655440011',
    'New Jersey League of Municipalities',
    'https://www.njlm.org',
    'nonprofit',
    5,
    'center'
  );

-- ============================================================
-- CANDIDATES - Multiple Offices for Cape May County, NJ (Zip: 08204, 08210, 08260)
-- ============================================================

-- COUNTY FREEHOLDER/COMMISSIONER
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440053',
    'Leonard Desiderio',
    'Cape May County Commissioner - At Large',
    'Republican',
    'Local business owner focused on tourism economy, coastal protection, and fiscal responsibility.',
    ARRAY['08204', '08210', '08260']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440054',
    'Patricia Murphy',
    'Cape May County Commissioner - At Large',
    'Democrat',
    'Former mayor advocating for environmental protection, affordable housing, and healthcare access.',
    ARRAY['08204', '08210', '08260']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440055',
    'Will Morey',
    'Cape May County Commissioner - At Large',
    'Republican',
    'Engineer focused on infrastructure, beach replenishment, and supporting local businesses.',
    ARRAY['08204', '08210', '08260']
  );

-- SCHOOL BOARD (Cape May County Technical School District)
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440056',
    'Susan Richardson',
    'Cape May County Technical School Board',
    'Non-partisan',
    'Educator advocating for vocational training, STEM programs, and career readiness.',
    ARRAY['08204', '08210', '08260']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440057',
    'Frank Bateman',
    'Cape May County Technical School Board',
    'Non-partisan',
    'Business leader focused on workforce development and partnerships with local industries.',
    ARRAY['08204', '08210', '08260']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440058',
    'Maria Santos',
    'Lower Cape May Regional School Board',
    'Non-partisan',
    'Parent and community advocate focused on special education, mental health resources, and academic excellence.',
    ARRAY['08204']
  );

-- STATE ASSEMBLY
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440059',
    'Antwan McClellan',
    'New Jersey Assembly - District 1',
    'Republican',
    'Small business owner advocating for tourism support, lower property taxes, and coastal preservation.',
    ARRAY['08204', '08210', '08260']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440060',
    'Claire Swift',
    'New Jersey Assembly - District 1',
    'Republican',
    'Attorney focused on property rights, economic development, and supporting law enforcement.',
    ARRAY['08204', '08210', '08260']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440061',
    'David Cohen',
    'New Jersey Assembly - District 1',
    'Democrat',
    'Environmental scientist advocating for climate resilience, renewable energy, and coastal protection.',
    ARRAY['08204', '08210', '08260']
  );

-- STATE SENATE
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440062',
    'Michael Testa',
    'New Jersey Senate - District 1',
    'Republican',
    'Incumbent senator focused on property tax relief, tourism economy, and veterans affairs.',
    ARRAY['08204', '08210', '08260']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440063',
    'Carmen Morales',
    'New Jersey Senate - District 1',
    'Democrat',
    'Healthcare administrator advocating for expanded healthcare access, education funding, and environmental protection.',
    ARRAY['08204', '08210', '08260']
  );

-- MAYOR (Cape May City)
INSERT INTO candidates (id, name, office, party, bio, zip_codes) VALUES
  (
    '770e8400-e29b-41d4-a716-446655440064',
    'Zachary Mullock',
    'Cape May City Mayor',
    'Non-partisan',
    'Current councilman focused on historic preservation, sustainable tourism, and infrastructure maintenance.',
    ARRAY['08204']
  ),
  (
    '770e8400-e29b-41d4-a716-446655440065',
    'Helen Grant',
    'Cape May City Mayor',
    'Non-partisan',
    'Business owner advocating for economic vitality, parking solutions, and maintaining Victorian character.',
    ARRAY['08204']
  );

-- ============================================================
-- CANDIDATE POSITIONS - All Cape May County candidates
-- ============================================================

-- Leonard Desiderio (County Commissioner) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440053', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports tourism and small business development', '660e8400-e29b-41d4-a716-446655440010'),
  ('770e8400-e29b-41d4-a716-446655440053', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes property tax increases', '660e8400-e29b-41d4-a716-446655440010'),
  ('770e8400-e29b-41d4-a716-446655440053', '550e8400-e29b-41d4-a716-446655440009', 4, 'Supports infrastructure for coastal areas', '660e8400-e29b-41d4-a716-446655440010'),
  ('770e8400-e29b-41d4-a716-446655440053', '550e8400-e29b-41d4-a716-446655440005', 3, 'Supports balanced environmental approach', '660e8400-e29b-41d4-a716-446655440010');

-- Patricia Murphy (County Commissioner) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440054', '550e8400-e29b-41d4-a716-446655440005', 5, 'Strongly supports environmental and coastal protection', '660e8400-e29b-41d4-a716-446655440010'),
  ('770e8400-e29b-41d4-a716-446655440054', '550e8400-e29b-41d4-a716-446655440003', 4, 'Supports affordable housing initiatives', '660e8400-e29b-41d4-a716-446655440010'),
  ('770e8400-e29b-41d4-a716-446655440054', '550e8400-e29b-41d4-a716-446655440008', 5, 'Strongly supports healthcare access', '660e8400-e29b-41d4-a716-446655440010');

-- Will Morey (County Commissioner) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440055', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports beach replenishment and infrastructure', '660e8400-e29b-41d4-a716-446655440010'),
  ('770e8400-e29b-41d4-a716-446655440055', '550e8400-e29b-41d4-a716-446655440007', 4, 'Supports local business development', '660e8400-e29b-41d4-a716-446655440010'),
  ('770e8400-e29b-41d4-a716-446655440055', '550e8400-e29b-41d4-a716-446655440005', 4, 'Supports coastal environmental protection', '660e8400-e29b-41d4-a716-446655440010');

-- Susan Richardson (School Board) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440056', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports vocational education funding', '660e8400-e29b-41d4-a716-446655440011'),
  ('770e8400-e29b-41d4-a716-446655440056', '550e8400-e29b-41d4-a716-446655440007', 4, 'Supports career training partnerships', '660e8400-e29b-41d4-a716-446655440011');

-- Frank Bateman (School Board) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440057', '550e8400-e29b-41d4-a716-446655440001', 4, 'Supports workforce development programs', '660e8400-e29b-41d4-a716-446655440011'),
  ('770e8400-e29b-41d4-a716-446655440057', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports business-education partnerships', '660e8400-e29b-41d4-a716-446655440011');

-- Maria Santos (School Board) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440058', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports education funding for all students', '660e8400-e29b-41d4-a716-446655440011'),
  ('770e8400-e29b-41d4-a716-446655440058', '550e8400-e29b-41d4-a716-446655440006', 4, 'Supports school safety and mental health programs', '660e8400-e29b-41d4-a716-446655440011');

-- Antwan McClellan (State Assembly) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440059', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports tourism and hospitality industry', '660e8400-e29b-41d4-a716-446655440011'),
  ('770e8400-e29b-41d4-a716-446655440059', '550e8400-e29b-41d4-a716-446655440002', 1, 'Strongly opposes property tax increases', '660e8400-e29b-41d4-a716-446655440011'),
  ('770e8400-e29b-41d4-a716-446655440059', '550e8400-e29b-41d4-a716-446655440005', 4, 'Supports coastal preservation efforts', '660e8400-e29b-41d4-a716-446655440011');

-- Claire Swift (State Assembly) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440060', '550e8400-e29b-41d4-a716-446655440006', 5, 'Strongly supports law enforcement funding', '660e8400-e29b-41d4-a716-446655440011'),
  ('770e8400-e29b-41d4-a716-446655440060', '550e8400-e29b-41d4-a716-446655440007', 4, 'Supports economic development initiatives', '660e8400-e29b-41d4-a716-446655440011'),
  ('770e8400-e29b-41d4-a716-446655440060', '550e8400-e29b-41d4-a716-446655440002', 2, 'Opposes property tax increases', '660e8400-e29b-41d4-a716-446655440011');

-- David Cohen (State Assembly) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440061', '550e8400-e29b-41d4-a716-446655440005', 5, 'Strongly supports environmental protection and climate action', '660e8400-e29b-41d4-a716-446655440011'),
  ('770e8400-e29b-41d4-a716-446655440061', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports coastal infrastructure resilience', '660e8400-e29b-41d4-a716-446655440011'),
  ('770e8400-e29b-41d4-a716-446655440061', '550e8400-e29b-41d4-a716-446655440001', 4, 'Supports education funding', '660e8400-e29b-41d4-a716-446655440011');

-- Michael Testa (State Senate) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440062', '550e8400-e29b-41d4-a716-446655440002', 1, 'Strongly opposes property tax increases', '660e8400-e29b-41d4-a716-446655440011'),
  ('770e8400-e29b-41d4-a716-446655440062', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports tourism economy', '660e8400-e29b-41d4-a716-446655440011'),
  ('770e8400-e29b-41d4-a716-446655440062', '550e8400-e29b-41d4-a716-446655440006', 5, 'Strongly supports veterans and public safety', '660e8400-e29b-41d4-a716-446655440011');

-- Carmen Morales (State Senate) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440063', '550e8400-e29b-41d4-a716-446655440008', 5, 'Strongly supports healthcare expansion', '660e8400-e29b-41d4-a716-446655440011'),
  ('770e8400-e29b-41d4-a716-446655440063', '550e8400-e29b-41d4-a716-446655440001', 5, 'Strongly supports education funding', '660e8400-e29b-41d4-a716-446655440011'),
  ('770e8400-e29b-41d4-a716-446655440063', '550e8400-e29b-41d4-a716-446655440005', 5, 'Strongly supports environmental protection', '660e8400-e29b-41d4-a716-446655440011');

-- Zachary Mullock (Mayor) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440064', '550e8400-e29b-41d4-a716-446655440005', 4, 'Supports historic and environmental preservation', '660e8400-e29b-41d4-a716-446655440010'),
  ('770e8400-e29b-41d4-a716-446655440064', '550e8400-e29b-41d4-a716-446655440009', 5, 'Strongly supports infrastructure maintenance', '660e8400-e29b-41d4-a716-446655440010'),
  ('770e8400-e29b-41d4-a716-446655440064', '550e8400-e29b-41d4-a716-446655440007', 4, 'Supports sustainable tourism', '660e8400-e29b-41d4-a716-446655440010');

-- Helen Grant (Mayor) positions
INSERT INTO candidate_positions (candidate_id, issue_id, position, position_text, source_id) VALUES
  ('770e8400-e29b-41d4-a716-446655440065', '550e8400-e29b-41d4-a716-446655440007', 5, 'Strongly supports business and economic vitality', '660e8400-e29b-41d4-a716-446655440010'),
  ('770e8400-e29b-41d4-a716-446655440065', '550e8400-e29b-41d4-a716-446655440009', 4, 'Supports infrastructure improvements', '660e8400-e29b-41d4-a716-446655440010'),
  ('770e8400-e29b-41d4-a716-446655440065', '550e8400-e29b-41d4-a716-446655440010', 4, 'Supports smart zoning for parking and access', '660e8400-e29b-41d4-a716-446655440010');
