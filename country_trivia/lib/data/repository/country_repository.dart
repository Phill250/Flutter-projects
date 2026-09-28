import 'dart:math';

import '../../core/constants/app_constants.dart';
import '../models/country.dart';
import '../models/question.dart';
import '../services/api_service.dart';

/// Repository for fetching countries and generating trivia questions.
class CountryRepository {
  final ApiService _apiService;
  final Random _random;

  CountryRepository({
    ApiService? apiService,
    Random? random,
  })  : _apiService = apiService ?? ApiService(),
        _random = random ?? Random();

  /// Fetches the list of countries from the API.
  Future<List<Country>> fetchCountries() {
    return _apiService.fetchCountries();
  }

  /// Generates a trivia question, excluding already-played countries.
  ///
  /// [playedCodes] is a set of ISO2 codes for countries that have already
  /// been shown. These are excluded from the question options.
  ///
  /// If fewer than 4 countries remain after filtering, the played set is
  /// effectively reset (by using the full country list) to ensure the game
  /// never gets stuck.
  ///
  /// Returns a [Question] with 4 unique options including the correct answer.
  Question generateQuestion({
    required List<Country> countries,
    required Set<String> playedCodes,
  }) {
    if (countries.isEmpty) {
      throw ArgumentError('Countries list cannot be empty');
    }

    // Filter out already-played countries
    List<Country> available = countries
        .where((c) => !playedCodes.contains(c.iso2))
        .toList();

    // If pool is exhausted, reset and use full list
    if (available.length < AppConstants.optionsPerQuestion) {
      available = List.from(countries);
    }

    // Pick random correct answer
    final correctCountry = available[_random.nextInt(available.length)];

    // Pick 3 random distractors from remaining available countries
    final remaining = available.where((c) => c.iso2 != correctCountry.iso2).toList();
    remaining.shuffle(_random);

    final distractors = remaining.take(AppConstants.optionsPerQuestion - 1).toList();

    // Combine and shuffle options
    final options = [correctCountry, ...distractors];
    options.shuffle(_random);

    return Question(
      correctCountry: correctCountry,
      options: options,
    );
  }
}
