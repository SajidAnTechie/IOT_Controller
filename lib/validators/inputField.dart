class InputFieldValidator {
  static String validateEmailField(String value) {
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

  static String validateUsernameFiled(String value) {
    if (value == null || value.isEmpty) {
      return "Username is required.";
    }

    return null;
  }

  static String validateAddressFiled(String value) {
    if (value == null || value.isEmpty) {
      return "Address is required.";
    }

    return null;
  }

  static String validatePasswordField(String value) {
    if (value == null || value.isEmpty) {
      return "Password is required.";
    }

    return null;
  }
}
