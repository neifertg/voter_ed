import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const apiKey = process.env.GOOGLE_CIVIC_API_KEY;
const address = '21933 Bramblebush Terrace, Broadlands, VA 20148, USA';

console.log('Testing Google Civic API with address:', address);
console.log('API Key:', apiKey ? `${apiKey.substring(0, 10)}...` : 'NOT FOUND');

const url = `https://www.googleapis.com/civicinfo/v2/representatives?address=${encodeURIComponent(address)}&key=${apiKey}`;

try {
  const response = await fetch(url);
  const data = await response.json();

  console.log('\nResponse Status:', response.status, response.statusText);
  console.log('Response OK:', response.ok);
  console.log('\nResponse Keys:', Object.keys(data));
  console.log('\nHas normalizedInput:', !!data.normalizedInput);

  if (data.normalizedInput) {
    console.log('\n normalizedInput:', JSON.stringify(data.normalizedInput, null, 2));
  }

  if (data.error) {
    console.log('\nError from API:', JSON.stringify(data.error, null, 2));
  }

  if (data.offices) {
    console.log('\nNumber of offices:', data.offices.length);
  }

} catch (error) {
  console.error('Fetch error:', error);
}
