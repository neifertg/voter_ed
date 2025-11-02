import { NextResponse } from 'next/server';

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const address = searchParams.get('address');

    if (!address) {
      return NextResponse.json(
        { success: false, error: 'Address is required' },
        { status: 400 }
      );
    }

    const apiKey = process.env.GOOGLE_CIVIC_API_KEY;

    if (!apiKey) {
      console.error('Google Civic API key not configured');
      // Fallback: if it's a zip code, allow it through
      if (/^\d{5}$/.test(address.trim())) {
        return NextResponse.json({
          success: true,
          normalizedAddress: address.trim(),
          zipCode: address.trim(),
          fallback: true,
        });
      }
      return NextResponse.json(
        { success: false, error: 'Address validation service unavailable' },
        { status: 503 }
      );
    }

    // Try to validate address using Google Civic API
    const encodedAddress = encodeURIComponent(address);
    const url = `https://www.googleapis.com/civicinfo/v2/representatives?address=${encodedAddress}&key=${apiKey}`;

    const response = await fetch(url);
    const data = await response.json();

    if (!response.ok) {
      // If address validation fails but it's a zip code, allow it
      if (/^\d{5}$/.test(address.trim())) {
        return NextResponse.json({
          success: true,
          normalizedAddress: address.trim(),
          zipCode: address.trim(),
          fallback: true,
        });
      }

      return NextResponse.json(
        {
          success: false,
          error: 'Unable to validate address. Please check the address and try again.'
        },
        { status: 400 }
      );
    }

    // Extract normalized address from response
    const normalizedAddress = data.normalizedInput?.line1
      ? `${data.normalizedInput.line1}, ${data.normalizedInput.city}, ${data.normalizedInput.state} ${data.normalizedInput.zip}`
      : address;

    const zipCode = data.normalizedInput?.zip?.substring(0, 5) || '';

    return NextResponse.json({
      success: true,
      normalizedAddress,
      zipCode,
      divisions: data.divisions ? Object.keys(data.divisions) : [],
      hasElectionData: true,
    });
  } catch (error) {
    console.error('Error validating address:', error);

    // Fallback for zip codes
    const { searchParams } = new URL(request.url);
    const address = searchParams.get('address') || '';
    if (/^\d{5}$/.test(address.trim())) {
      return NextResponse.json({
        success: true,
        normalizedAddress: address.trim(),
        zipCode: address.trim(),
        fallback: true,
      });
    }

    return NextResponse.json(
      { success: false, error: 'Error validating address. Please try again.' },
      { status: 500 }
    );
  }
}
