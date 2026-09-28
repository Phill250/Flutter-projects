/// Represents the current state of the game.
enum GameState {
  /// Fetching countries from the API
  loading,

  /// Question displayed, awaiting user answer
  ready,

  /// Answer selected, showing feedback
  answered,

  /// All attempts exhausted, correct answer shown
  revealed,
}
