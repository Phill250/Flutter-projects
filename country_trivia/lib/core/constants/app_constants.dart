/// Game configuration constants for the Country Trivia app.
class AppConstants {
  AppConstants._();

  /// Maximum number of attempts per question
  static const int maxAttempts = 3;

  /// Points awarded for correct answer on first attempt
  static const int pointsFirstAttempt = 10;

  /// Points awarded for correct answer on second attempt
  static const int pointsSecondAttempt = 8;

  /// Points awarded for correct answer on third attempt
  static const int pointsThirdAttempt = 5;

  /// Number of answer options per question
  static const int optionsPerQuestion = 4;
}
