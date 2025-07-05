extension StringValidation on String? {
  bool isValidEmail() {
    if (this != null) {
      return this!.contains('@gmail.com') ||
          this!.contains('@hotmail.com') ||
          this!.contains('@outlook.com') ||
          this!.contains('@yahoo.com');
    }
    return false;
  }

  bool isvalidPassword() {
    return isSpecialCharactersString() && isUpperCaseAndLowerCaseInString();
  }

  bool isSpecialCharactersString() {
    if (this != null) {
      return this!.contains('!') ||
          this!.contains('#') ||
          this!.contains('@') ||
          this!.contains('&') ||
          this!.contains('^') ||
          this!.contains('*');
    }
    return false;
  }

  bool isUpperCaseAndLowerCaseInString() {
    bool upperCase = false;
    bool lowerCase = false;

    for (var i = 0; i < (this?.length ?? 0); i++) {
      if (this?[i] == this?[i].toUpperCase() &&
          isCharacter(this?.codeUnitAt(i) ?? 0)) {
        upperCase = true;
      }
      if (this?[i] == this?[i].toLowerCase() &&
          isCharacter(this?.codeUnitAt(i) ?? 0)) {
        lowerCase = true;
      }
    }

    return lowerCase && upperCase;
  }

  bool isCharacter(int char) {
    return isSmallAlphabet(char) || isCapitalAlphabet(char);
  }

  bool isSmallAlphabet(int char) {
    return char >= 97 && char <= 122;
  }

  bool isCapitalAlphabet(int char) {
    return char >= 65 && char <= 90;
  }

  bool isValidPhoneNumber() {
    return isDigitString() && this?.length == 11;
  }

  bool isDigitString() {
    return this?.codeUnits.every(
              (element) => element >= 48 && element <= 57,
            ) ??
        false;
  }
}
