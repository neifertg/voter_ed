-- Add location field to issues table
-- Allows filtering issues by state/region

ALTER TABLE issues
ADD COLUMN locations TEXT[]; -- Array of state codes or 'national'

CREATE INDEX idx_issues_locations ON issues USING GIN(locations);

-- Add comment to explain the field
COMMENT ON COLUMN issues.locations IS 'Array of state codes (VA, NC, TX, etc.) or ''national'' for issues applicable to those areas';
