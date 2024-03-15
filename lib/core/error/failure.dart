class Failure {
  final String message;
  // we wrap the this.message with square brackets for when it get's empty value the String will be an default value
  Failure([this.message = 'An unexpected error occurred ']);
}
