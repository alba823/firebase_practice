class PasswordState {
  final bool highlightErrors;
  final bool containsNumbers;
  final bool containsLowercase;
  final bool containsUppercase;
  final bool correctLength;

  bool get isValid =>
      correctLength &&
          containsLowercase &&
          containsUppercase &&
          containsNumbers;

  PasswordState({
    bool? highlightErrors,
    bool? containsNumbers,
    bool? containsLowercase,
    bool? containsUppercase,
    bool? correctLength,
  })  : highlightErrors = highlightErrors ?? false,
        containsNumbers = containsNumbers ?? false,
        containsLowercase = containsLowercase ?? false,
        containsUppercase = containsUppercase ?? false,
        correctLength = correctLength ?? false;

  PasswordState checkPassword(String? password) {
    final containsNumbers = password?.contains(RegExp("[0-9]"));
    final containsLowercase = password?.contains(RegExp("[a-z]"));
    final containsUppercase = password?.contains(RegExp("[A-Z]"));
    final correctLength = (password?.length ?? 0) >= 8;
    bool highlightErrors = this.highlightErrors;

    if (correctLength &&
        containsLowercase == true &&
        containsUppercase == true &&
        containsNumbers == true) {
      highlightErrors = false;
    }

    return PasswordState(
      highlightErrors: highlightErrors,
      containsNumbers: containsNumbers,
      containsLowercase: containsLowercase,
      containsUppercase: containsUppercase,
      correctLength: correctLength,
    );
  }

  PasswordState setHighlightErrors(bool value) => PasswordState(
    highlightErrors: value,
    containsNumbers: containsNumbers,
    correctLength: correctLength,
    containsUppercase: containsUppercase,
    containsLowercase: containsLowercase,
  );
}