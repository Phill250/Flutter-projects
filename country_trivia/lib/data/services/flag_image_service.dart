import '../../core/constants/api_constants.dart';

/// Service for building flag image CDN URLs.
class FlagImageService {
  FlagImageService._();

  /// Returns the flag CDN URL for the given ISO2 code.
  ///
  /// The ISO2 code is lowercased before being inserted into the URL.
  ///
  /// Example:
  /// ```dart
  /// FlagImageService.getFlagUrl('US');
  /// // Returns: 'https://flagcdn.com/w320/us.png'
  /// ```
  static String getFlagUrl(String iso2) {
    return ApiConstants.flagCdnPattern.replaceAll(
      '{iso}',
      iso2.toLowerCase(),
    );
  }
}
