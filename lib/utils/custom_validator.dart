class CustomValidator {
  String? _password;
  String? _email;
  String? _userName;
  String? _phone;

  String get email => _email!;
  String get password => _password!;
  String get userName => _userName!;
  String get phone => _phone!;

  String? passwordValidator(String? password, [int minLength = 8]) {
    if (password!.trim().length < (minLength)) {
      return "minimum of $minLength characters";
    }
    _password = password;
    return null;
  }

  String? emailValidator(String? email) {
    if (email!.trim().isEmpty) {
      return 'Email required';
    } else if (!email.trim().contains('@') || !email.trim().contains('.com')) {
      return 'Inavlid email';
    }
    _email = email;
    return null;
  }

  String? nameValidator(String? name) {
    if (name!.isEmpty) {
      return 'user name required';
    }
    _userName = name;
    return null;
  }

   String? phoneNumberValidator(String? input) {
    final parsednumber = int.tryParse(input!);
    if (parsednumber == null ||
        input.trim().length != 11 ||
        !input.trim().startsWith('0')) {
      return 'invalid phone number';
    }
    _phone= input.trim();
    return null;
  }
}
