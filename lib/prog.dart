library gson_prog;

/// Error generator
class ErrorGenerator {
  /// Error generator
  ErrorGenerator();

  /// Generate error
  Exception error(String error) {
    return Exception(error);
  }
}
