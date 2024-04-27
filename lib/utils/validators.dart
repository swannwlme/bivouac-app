String? Function(String?)? emailValidator = (String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
};

String? Function(String?)? passwordValidator = (String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
};

String? Function(String?)? usernameValidator = (String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your username';
  }
  if (value.length < 4) {
    return 'Username must be at least 4 characters long';
  }
  return null;
};

String? Function(String?)? descriptionValidator = (String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a description';
  }
  return null;
};