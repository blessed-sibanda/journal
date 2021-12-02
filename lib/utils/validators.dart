import 'dart:async';

class Validators {
  final validateEmail = StreamTransformer.fromHandlers(
    handleData: (String email, sink) {
      if (email.contains('@') && email.contains('.')) {
        sink.add(email);
      } else if (email.isNotEmpty) {
        sink.addError('Enter a valid email');
      }
    },
  );

  final validatePassword = StreamTransformer.fromHandlers(
    handleData: (String password, sink) {
      if (password.length >= 6) {
        sink.add(password);
      } else if (password.isNotEmpty) {
        sink.addError('Password needs to be at least 6 characters');
      }
    },
  );
}
