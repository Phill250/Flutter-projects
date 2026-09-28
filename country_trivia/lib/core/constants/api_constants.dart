/// API endpoint and CDN URL constants for the Country Trivia app.
class ApiConstants {
  ApiConstants._();

  /// Base URL for the countries API (countriesnow.space)
  static const String countriesUrl =
      'https://countriesnow.space/api/v0.1/countries/flag/images';

  /// Flag CDN URL pattern. Replace `{iso}` with the lowercase ISO2 code.
  /// Example: https://flagcdn.com/w320/us.png
  static const String flagCdnPattern = 'https://flagcdn.com/w320/{iso}.png';

  /// HTTP request timeout duration
  static const Duration timeoutDuration = Duration(seconds: 10);
}
