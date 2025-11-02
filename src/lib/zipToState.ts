// Maps zip codes to state codes for location-specific content

const ZIP_TO_STATE_MAP: Record<string, string> = {
  // Virginia - Loudoun County
  '20147': 'VA',
  '20148': 'VA',
  '20164': 'VA',
  '20165': 'VA',

  // North Carolina - Lincoln County
  '28092': 'NC',
  '28090': 'NC',

  // Utah - Lehi
  '84003': 'UT',
  '84005': 'UT',
  '84043': 'UT',

  // Texas - Katy
  '77449': 'TX',
  '77450': 'TX',
  '77493': 'TX',

  // New Jersey - Cape May County
  '08204': 'NJ',
  '08210': 'NJ',
  '08260': 'NJ',

  // Kansas - Andover
  '67002': 'KS',

  // Michigan - Bear Lake
  '49614': 'MI',
};

export function getStateFromZip(zipCode: string): string | null {
  return ZIP_TO_STATE_MAP[zipCode] || null;
}

export function isValidZipCode(zipCode: string): boolean {
  return zipCode in ZIP_TO_STATE_MAP;
}
