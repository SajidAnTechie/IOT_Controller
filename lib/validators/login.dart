class LoginValidator {
  static String validateEmail(String value) {
    if (value == null || value.isEmpty) {
      return "Email is required.";
    }

    const pattern = r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return "Please enter the valid email.";
    }
    return null;
  }

  static String validatePassword(String value) {
    if (value == null || value.isEmpty) {
      return "Password is required.";
    }
    return null;
  }
}
