import 'package:flutter/material.dart';
import 'package:journal/blocs/login_bloc.dart';
import 'package:journal/services/authentication.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(AuthenticationService());
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
          child: Icon(
            Icons.account_circle,
            size: 88.0,
            color: Colors.white,
          ),
          preferredSize: Size.fromHeight(40.0),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StreamBuilder(
                stream: _loginBloc.email,
                builder: (BuildContext context, AsyncSnapshot snapshot) =>
                    TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    icon: const Icon(Icons.mail_outline),
                    errorText: snapshot.error?.toString(),
                  ),
                  onChanged: _loginBloc.emailChanged.add,
                ),
              ),
              StreamBuilder(
                stream: _loginBloc.password,
                builder: (BuildContext context, AsyncSnapshot snapshot) =>
                    TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    icon: const Icon(Icons.security),
                    errorText: snapshot.error?.toString(),
                  ),
                  onChanged: _loginBloc.passwordChanged.add,
                ),
              ),
              const SizedBox(height: 48.0),
              _buildLoginAndCreateButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginAndCreateButtons() {
    return StreamBuilder(
      stream: _loginBloc.loginOrCreateButton,
      initialData: 'Login',
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == 'Login') {
          return _buttonsLogin();
        } else if (snapshot.data == 'Create Account') {
          return _buttonsCreateAccount();
        }
        return Container();
      },
    );
  }

  Widget _buttonsLogin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StreamBuilder(
          initialData: false,
          stream: _loginBloc.enableLoginCreateButton,
          builder: (BuildContext context, AsyncSnapshot snapshot) =>
              ElevatedButton(
            child: const Text('Login'),
            style: ElevatedButton.styleFrom(
              primary: Colors.lightGreen.shade200,
            ),
            onPressed: snapshot.data
                ? () => _loginBloc.loginOrCreateChanged.add('Login')
                : null,
          ),
        ),
        TextButton(
          child: const Text('Create Account'),
          onPressed: () =>
              _loginBloc.loginOrCreateButtonChanged.add('Create Account'),
        ),
      ],
    );
  }

  Widget _buttonsCreateAccount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        StreamBuilder(
          initialData: false,
          stream: _loginBloc.enableLoginCreateButton,
          builder: (BuildContext context, AsyncSnapshot snapshot) =>
              MaterialButton(
            elevation: 16.0,
            child: const Text('Create Account'),
            color: Colors.lightGreen.shade200,
            disabledColor: Colors.grey.shade100,
            onPressed: snapshot.data
                ? () => _loginBloc.loginOrCreateChanged.add('Create Account')
                : null,
          ),
        ),
        TextButton(
          child: const Text('Login'),
          onPressed: () => _loginBloc.loginOrCreateButtonChanged.add('Login'),
        ),
      ],
    );
  }
}
