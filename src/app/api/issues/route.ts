import { supabase } from '@/lib/supabase';
import { NextResponse } from 'next/server';
import { getStateFromZip } from '@/lib/zipToState';

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url);
    const zipCode = searchParams.get('zipCode');

    let query = supabase
      .from('issues')
      .select(`
        *,
        explanations:issue_explanations(*)
      `)
      .order('created_at', { ascending: true });

    // If zip code provided, filter by location
    if (zipCode) {
      const state = getStateFromZip(zipCode);
      if (state) {
        // Get issues that include this state in their locations array
        query = query.contains('locations', [state]);
      }
    }

    const { data: issues, error } = await query;

    if (error) {
      return NextResponse.json(
        { success: false, error: error.message },
        { status: 500 }
      );
    }

    return NextResponse.json({
      success: true,
      issues,
    });
  } catch (error) {
    return NextResponse.json(
      { success: false, error: String(error) },
      { status: 500 }
    );
  }
}
