import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_laravel_sanctum/providers/auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  void sumbit() {
    Provider.of<Auth>(context, listen: false)
        .login(credentials: {'email': _email, 'password': _password});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login Screen'),
        ),
        body: Form(
            key: _formKey,
            child: Scrollbar(
                child: SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Email', hintText: 'kalsma@gmail.com'),
                    onSaved: (value) {
                      _email = value;
                    },
                    initialValue: 'erick@gmail.com',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    onSaved: (value) {
                      _password = value;
                    },
                    initialValue: 'password',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some password';
                      }
                      return null;
                    },
                  ),
                  TextButton(
                      onPressed: () {
                        _formKey.currentState!.save();
                        if (_formKey.currentState!.validate()) {
                          log(_email!);
                          log(_password!);
                          sumbit();
                        }
                      },
                      child: const Text('Login'))
                ],
              ),
            ))));
  }
}
