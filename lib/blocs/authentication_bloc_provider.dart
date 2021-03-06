import 'package:flutter/material.dart';
import 'package:journal/blocs/authentication_bloc.dart';

class AuthenticationBlocProvider extends InheritedWidget {
  final AuthenticationBloc authenticationBloc;

  const AuthenticationBlocProvider({
    Key? key,
    required this.authenticationBloc,
    required Widget child,
  }) : super(key: key, child: child);

  static AuthenticationBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(
        aspect: AuthenticationBlocProvider) as AuthenticationBlocProvider;
  }

  @override
  bool updateShouldNotify(AuthenticationBlocProvider oldWidget) {
    return authenticationBloc != oldWidget.authenticationBloc;
  }
}
