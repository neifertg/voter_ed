import { supabase } from '@/lib/supabase';
import { NextResponse } from 'next/server';

export async function GET() {
  try {
    // Check if env vars are set
    if (!process.env.NEXT_PUBLIC_SUPABASE_URL || !process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY) {
      return NextResponse.json(
        {
          success: false,
          error: 'Supabase environment variables not configured. Please add them to Vercel.'
        },
        { status: 500 }
      );
    }

    // Test the connection by querying the issues table
    const { data, error } = await supabase
      .from('issues')
      .select('*')
      .limit(1);

    if (error) {
      return NextResponse.json(
        { success: false, error: error.message },
        { status: 500 }
      );
    }

    return NextResponse.json({
      success: true,
      message: 'Database connection successful!',
      data,
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, error: String(error) },
      { status: 500 }
    );
  }
}
