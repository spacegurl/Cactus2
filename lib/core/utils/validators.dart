class Validators {
  static String? validateEmail(String? value) {
    final email = value ?? '';

    if (email.isEmpty) return 'Необходимо заполнить поле';

    const String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

    if (!RegExp(pattern).hasMatch(email.trim())) return 'Некорректный email';

    return null;
  }

  static String? validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'Необходимо заполнить поле';

    if (password.trim().length < 6) {
      return 'Пароль должен содержать не менее 6 символов';
    }

    return null;
  }

  static String? validateName(String? value) {
    final name = value ?? '';
    if (name.isEmpty) return 'Необходимо заполнить поле';

    if (name.trim().length < 4) {
      return 'Пароль должен содержать не менее 4 символов';
    }

    return null;
  }
}
