/// Utility class to wrap result data.
///
/// Evaluate the result using a switch statement:
/// ```dart
/// switch (result) {
///   case Ok(): {
///     print(result.value);
///   }
///   case Error(): {
///     print(result.error);
///   }
/// }
/// ```
sealed class Result<T> {
  const Result();

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.ok(T? value) = Ok<T>;

  /// Creates an error [Result], completed with the specified [error].
  const factory Result.error(Object error) = Error<T>;
}

/// Subclass of Result for values
final class Ok<T> extends Result<T> {
  const Ok(this.value);

  /// Returned value in result
  final T? value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// Subclass of Result for errors
final class Error<T> extends Result<T> {
  const Error(this.error);

  /// Returned error in result
  final Object error;

  @override
  String toString() => 'Result<$T>.error($error)';
}