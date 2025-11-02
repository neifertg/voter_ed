// Test address validation with various Loudoun County addresses

const testAddresses = [
  '123 Main St, Ashburn, VA 20147',
  '456 Maple Ave, Leesburg, VA 20176',
  '789 Oak Street, Sterling, VA 20164',
  '20147',  // Just zip code
  '43330 Junction Plaza, Ashburn, VA 20147', // Real commercial address
];

async function testAddressValidation() {
  console.log('Testing address validation...\n');

  for (const address of testAddresses) {
    console.log('='.repeat(70));
    console.log(`Testing: "${address}"`);
    console.log('='.repeat(70));

    try {
      const encodedAddress = encodeURIComponent(address);
      const url = `http://localhost:3000/api/validate-address?address=${encodedAddress}`;

      console.log(`Calling: ${url}\n`);

      const response = await fetch(url);
      const data = await response.json();

      console.log(`Status: ${response.status} ${response.statusText}`);
      console.log(`Success: ${data.success}`);

      if (data.success) {
        console.log(`Normalized: ${data.normalizedAddress}`);
        console.log(`Zip Code: ${data.zipCode}`);
        console.log(`Has Election Data: ${data.hasElectionData}`);
        console.log(`Fallback: ${data.fallback || false}`);
        if (data.divisions) {
          console.log(`Divisions: ${data.divisions.length} found`);
        }
      } else {
        console.log(`Error: ${data.error}`);
      }

    } catch (error) {
      console.error(`Fetch error: ${error.message}`);
    }

    console.log('\n');
  }
}

testAddressValidation();
