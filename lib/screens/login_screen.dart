import 'package:flutter/material.dart';
import 'package:hello_flutter/API/auth_api.dart';
import 'package:hello_flutter/screens/sign_up.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      hintText: 'example@mail.com', label: Text('Email')),
                  validator: (val) {
                    if (val == null) {
                      return "email can't be null";
                    } else if (val.isEmpty) {
                      return "email can't be empty";
                    }
                    return null;
                  }),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(label: Text('Password')),
                validator: (val) {
                  if (val == null) {
                    return "pass can't be null";
                  } else if (val.isEmpty) {
                    return "pass can't be empty";
                  } else if (val.length <= 6) {
                    return "should be longer than 6";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await AuthApi().logIn(
                            emailController.text, passwordController.text);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Home()));
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Text('Login')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const SignUp()));
                  },
                  child: const Text('Sign Up'))
            ],
          )),
    );
  }
}
