class BaseFailure {
  final String errorMessage;

  const BaseFailure({
    this.errorMessage = 'Ha ocurrido un error inesperado',
  });

  @override
  String toString() {
    return """BaseFailure{
      errorMessage: $errorMessage
    }""";
  }
}
