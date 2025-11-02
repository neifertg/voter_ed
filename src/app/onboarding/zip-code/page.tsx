'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';

export default function ZipCodePage() {
  const [address, setAddress] = useState('');
  const [error, setError] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [useZipOnly, setUseZipOnly] = useState(false);
  const router = useRouter();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError('');
    setIsLoading(true);

    const trimmedAddress = address.trim();

    if (!trimmedAddress) {
      setError('Please enter your address');
      setIsLoading(false);
      return;
    }

    // If user just entered a zip code, validate it
    if (/^\d{5}$/.test(trimmedAddress)) {
      // Store zip code for backward compatibility
      localStorage.setItem('votered_zip_code', trimmedAddress);
      localStorage.setItem('votered_address', trimmedAddress);
      router.push('/onboarding/quiz');
      return;
    }

    // Validate address with Google Civic API
    try {
      const response = await fetch(`/api/validate-address?address=${encodeURIComponent(trimmedAddress)}`);
      const data = await response.json();

      if (data.success && data.normalizedAddress) {
        // Store both full address and extracted zip code
        localStorage.setItem('votered_address', data.normalizedAddress);
        if (data.zipCode) {
          localStorage.setItem('votered_zip_code', data.zipCode);
        }

        // Navigate to quiz
        router.push('/onboarding/quiz');
      } else {
        setError(data.error || 'Unable to validate address. Please check and try again.');
        setIsLoading(false);
      }
    } catch (err) {
      console.error('Error validating address:', err);
      setError('Error validating address. Please try again.');
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-b from-slate-50 to-white">
      {/* Progress Indicator */}
      <div className="border-b border-slate-200 bg-white">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between max-w-2xl mx-auto">
            <div className="flex items-center gap-2">
              <div className="w-8 h-8 rounded-full bg-patriot-blue-700 text-white flex items-center justify-center font-semibold text-sm">
                1
              </div>
              <span className="text-sm font-medium text-slate-900">Your Location</span>
            </div>
            <div className="flex-1 h-1 bg-slate-200 mx-4" />
            <div className="flex items-center gap-2">
              <div className="w-8 h-8 rounded-full bg-slate-200 text-slate-600 flex items-center justify-center font-semibold text-sm">
                2
              </div>
              <span className="text-sm text-slate-600">Issue Quiz</span>
            </div>
            <div className="flex-1 h-1 bg-slate-200 mx-4" />
            <div className="flex items-center gap-2">
              <div className="w-8 h-8 rounded-full bg-slate-200 text-slate-600 flex items-center justify-center font-semibold text-sm">
                3
              </div>
              <span className="text-sm text-slate-600">Your Matches</span>
            </div>
          </div>
        </div>
      </div>

      {/* Main Content */}
      <main className="container mx-auto px-4 py-16">
        <div className="max-w-xl mx-auto">
          <Link
            href="/"
            className="inline-flex items-center gap-2 text-slate-600 hover:text-slate-900 mb-8 transition-colors"
          >
            <svg
              className="w-5 h-5"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M15 19l-7-7 7-7"
              />
            </svg>
            Back to Home
          </Link>

          <div className="bg-white rounded-2xl shadow-xl p-8 md:p-12">
            <h1 className="text-3xl md:text-4xl font-bold text-slate-900 mb-4">
              Where do you live?
            </h1>
            <p className="text-lg text-slate-600 mb-8">
              We'll use your address to show you the exact candidates and ballot measures you'll see on election day.
              Your information is never stored or shared.
            </p>

            <form onSubmit={handleSubmit} className="space-y-6">
              <div>
                <label
                  htmlFor="address"
                  className="block text-sm font-medium text-slate-900 mb-2"
                >
                  Your Address
                </label>
                <input
                  id="address"
                  type="text"
                  value={address}
                  onChange={(e) => setAddress(e.target.value)}
                  placeholder={useZipOnly ? "Enter zip code (e.g., 20147)" : "123 Main St, City, State ZIP"}
                  className="w-full px-4 py-3 text-lg border border-slate-300 rounded-lg focus:ring-2 focus:ring-patriot-blue-500 focus:border-patriot-blue-500 outline-none transition-all"
                  required
                />
                <p className="mt-2 text-sm text-slate-500">
                  {useZipOnly
                    ? "Enter your 5-digit zip code"
                    : "For best results, include your street address. You can also just enter a zip code."
                  }
                </p>
              </div>

              {error && (
                <div className="p-4 bg-red-50 border border-red-200 rounded-lg">
                  <p className="text-sm text-red-800">{error}</p>
                </div>
              )}

              <button
                type="submit"
                disabled={isLoading || !address.trim()}
                className="w-full bg-patriot-red-600 hover:bg-patriot-red-700 disabled:bg-slate-300 disabled:cursor-not-allowed text-white font-semibold text-lg px-6 py-4 rounded-lg shadow-lg hover:shadow-xl transition-all duration-200"
              >
                {isLoading ? 'Validating Address...' : 'Continue to Quiz'}
              </button>

              <div className="flex items-center justify-center gap-2 text-sm">
                <svg className="w-4 h-4 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                </svg>
                <span className="text-slate-500">Your address is used only to find your ballot and is not stored</span>
              </div>
            </form>

            <div className="mt-8 pt-8 border-t border-slate-200">
              <h3 className="font-semibold text-slate-900 mb-3">
                Currently Available In:
              </h3>
              <ul className="grid grid-cols-1 md:grid-cols-2 gap-2 text-slate-600 text-sm">
                <li className="flex items-start gap-2">
                  <svg
                    className="w-5 h-5 text-patriot-blue-700 mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                      clipRule="evenodd"
                    />
                  </svg>
                  Loudoun County, Virginia
                </li>
                <li className="flex items-start gap-2">
                  <svg
                    className="w-5 h-5 text-patriot-blue-700 mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                      clipRule="evenodd"
                    />
                  </svg>
                  Lincoln County, North Carolina
                </li>
                <li className="flex items-start gap-2">
                  <svg
                    className="w-5 h-5 text-patriot-blue-700 mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                      clipRule="evenodd"
                    />
                  </svg>
                  Lehi, Utah
                </li>
                <li className="flex items-start gap-2">
                  <svg
                    className="w-5 h-5 text-patriot-blue-700 mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                      clipRule="evenodd"
                    />
                  </svg>
                  Katy, Texas
                </li>
                <li className="flex items-start gap-2">
                  <svg
                    className="w-5 h-5 text-patriot-blue-700 mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                      clipRule="evenodd"
                    />
                  </svg>
                  Cape May County, New Jersey
                </li>
                <li className="flex items-start gap-2">
                  <svg
                    className="w-5 h-5 text-patriot-blue-700 mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                      clipRule="evenodd"
                    />
                  </svg>
                  Andover, Kansas
                </li>
                <li className="flex items-start gap-2">
                  <svg
                    className="w-5 h-5 text-patriot-blue-700 mt-0.5 flex-shrink-0"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                      clipRule="evenodd"
                    />
                  </svg>
                  Bear Lake, Michigan
                </li>
              </ul>
            </div>
          </div>

          <p className="text-center text-sm text-slate-500 mt-6">
            Takes about 5 minutes • No account required
          </p>
        </div>
      </main>
    </div>
  );
}
