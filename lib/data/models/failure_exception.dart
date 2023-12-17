class FailureException {
  String message;

  FailureException(
    this.message,
  );

  @override
  String toString() => 'FailureException(message: $message)';
}
