import 'package:flutter/material.dart';
import 'package:journal/blocs/authentication_bloc.dart';
import 'package:journal/blocs/authentication_bloc_provider.dart';
import 'package:journal/blocs/home_bloc.dart';
import 'package:journal/blocs/home_bloc_provider.dart';
import 'package:journal/services/authentication.dart';
import 'package:journal/services/db_firestore.dart';
import 'pages/home.dart';
import 'pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthenticationService _authenticationService =
        AuthenticationService();
    final AuthenticationBloc _authenticationBloc =
        AuthenticationBloc(_authenticationService);
    return AuthenticationBlocProvider(
      authenticationBloc: _authenticationBloc,
      child: StreamBuilder(
          initialData: null,
          stream: _authenticationBloc.user,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                color: Colors.lightGreen,
                child: const CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return HomeBlocProvider(
                child: _buildMaterialApp(const MyHomePage(title: 'Journal')),
                homeBloc: HomeBloc(
                  DbFirestoreService(),
                  _authenticationService,
                ),
                uid: snapshot.data,
              );
            } else {
              return _buildMaterialApp(const Login());
            }
          }),
    );
  }

  MaterialApp _buildMaterialApp(Widget homePage) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        canvasColor: Colors.lightGreen.shade50,
        bottomAppBarColor: Colors.lightGreen,
      ),
      home: homePage,
    );
  }
}
