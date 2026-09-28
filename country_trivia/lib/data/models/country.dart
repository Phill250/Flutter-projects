/// Represents a country with its name and ISO codes.
class Country {
  /// Country name (e.g., "United States")
  final String name;

  /// ISO 3166-1 alpha-2 code (e.g., "US")
  final String iso2;

  /// ISO 3166-1 alpha-3 code (e.g., "USA")
  final String iso3;

  const Country({
    required this.name,
    required this.iso2,
    required this.iso3,
  });

  /// Creates a [Country] from a JSON map.
  ///
  /// Expects keys: `name`, `iso2`, `iso3`.
  /// Handles missing or null fields gracefully with fallback values.
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] as String? ?? 'Unknown',
      iso2: json['iso2'] as String? ?? '',
      iso3: json['iso3'] as String? ?? '',
    );
  }

  /// Returns the flag CDN URL for this country.
  ///
  /// Uses the lowercase ISO2 code in the URL pattern.
  /// Example: `https://flagcdn.com/w320/us.png`
  String get flagUrl => 'https://flagcdn.com/w320/${iso2.toLowerCase()}.png';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          iso2 == other.iso2;

  @override
  int get hashCode => iso2.hashCode;

  @override
  String toString() => 'Country(name: $name, iso2: $iso2, iso3: $iso3)';
}
