import 'country.dart';

/// Represents a trivia question with a correct answer and options.
class Question {
  /// The correct country for this question
  final Country correctCountry;

  /// List of answer options (always contains 4 unique countries)
  final List<Country> options;

  const Question({
    required this.correctCountry,
    required this.options,
  });

  /// Validates that the question is well-formed.
  ///
  /// Returns true if:
  /// - Options contains exactly 4 countries
  /// - All options are unique
  /// - Options includes the correct answer
  bool get isValid =>
      options.length == 4 &&
      options.map((c) => c.iso2).toSet().length == 4 &&
      options.any((c) => c.iso2 == correctCountry.iso2);

  @override
  String toString() =>
      'Question(correct: ${correctCountry.name}, options: ${options.map((c) => c.name).toList()})';
}
