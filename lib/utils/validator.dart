class Validator {
  static String? nameValidate(dynamic value) {
    var emptyResult = valueExists(value);
    if (emptyResult == null || emptyResult.isEmpty) {
      if (value.toString().length < 2) {
        return 'Name must be at least 2 character';
      } else {
        return null;
      }
    } else {
      return emptyResult;
    }
  }

  static String? valueExists(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'please fill this field';
    } else {
      return null;
    }
  }

  static String? phoneValidate(dynamic value) {
    var emptyResult = valueExists(value);
    if (emptyResult == null || emptyResult.isEmpty) {
      var isphone = isNumericUsingRegularExpression(value);

      if (isphone) {
        if (value.toString().length < 9 || value.toString().length > 13) {
          return 'phone number must have at least 9 number';
        } else {
          return null;
        }
      } else {
        return 'invalid phone number';
      }
    } else {
      return emptyResult;
    }
  }

  static bool isNumericUsingRegularExpressionForPoint(String string) {
    final numericRegex = RegExp(r'^([1-9]+[0-9]*|[1-9])$');

    return numericRegex.hasMatch(string);
  }

  static bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }

  static String? passwordValidate(dynamic value) {
    var emptyResult = valueExists(value);

    if (emptyResult == null || emptyResult.isEmpty) {
      if (value.toString().length < 8) {
        return 'Your password must be at least 8 character';
      } else {
        return null;
      }
    } else {
      return emptyResult;
    }
  }

  static String? retypePasswordValidate(dynamic value, dynamic firstPass) {
    var emptyResult = valueExists(value);
    if (emptyResult == null || emptyResult.isEmpty) {
      if (value.toString().length < 8) {
        return 'Your password must be at least 8 character';
      } else if (value != firstPass) {
        return 'Both password must be the same';
      } else {
        return null;
      }
    } else {
      return emptyResult;
    }
  }

  static String? emailValidate(dynamic value) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regExp = RegExp(pattern);
    var emptyResult = valueExists(value);
    if (emptyResult != null) {
      return emptyResult;
    } else if (!regExp.hasMatch(value)) {
      return 'A valid email address should be your@email.com';
    } else {
      return null;
    }
  }
}
