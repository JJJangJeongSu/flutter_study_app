import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final _fireBase = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

  var passwordControl = TextEditingController();

  String? _emailInput;

  String? _passwordInput;

  bool? loginMode;

  @override
  void initState() {
    super.initState();
    loginMode = true;
  }

  @override
  Widget build(BuildContext context) {
    void _login() async {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
      }

      try {
        final userCredential = await _fireBase.signInWithEmailAndPassword(
            email: _emailInput!, password: _passwordInput!);
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication failed.'),
          ),
        );
      }
    }

    void _signUp() async {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
        print(_emailInput);
        print(_passwordInput);
      }

      try {
        final userCredential = await _fireBase.createUserWithEmailAndPassword(
            email: _emailInput!, password: _passwordInput!);
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message ?? 'Authentication failed.'),
          ),
        );
      }
    }

    return Scaffold(
      body: Form(
          key: _formkey,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(label: Text("Email")),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email field empty";
                      } else if (!value.contains('@')) {
                        return "Email should be example@example.com";
                      }
                    },
                    onSaved: (newValue) {
                      _emailInput = newValue;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text("Password"),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Password field is empty";
                      } else if (value.length < 6) {
                        return "Too short";
                      }
                    },
                    onSaved: (newValue) {
                      _passwordInput = newValue;
                    },
                    obscureText: true,
                    enableSuggestions: false,
                    controller: passwordControl,
                  ),
                  if (loginMode!)
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Verify your password"),
                      ),
                      validator: (value) {
                        String curPassword = passwordControl.text;
                        if (value != curPassword) {
                          return "Password is incorrect";
                        }
                      },
                      obscureText: true,
                      enableSuggestions: false,
                    ),
                  const SizedBox(
                    height: 50,
                  ),
                  FilledButton(
                    onPressed: loginMode! ? _login : _signUp,
                    child: Text(loginMode! ? "Login" : "Create Account"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        loginMode = !loginMode!;
                      });
                    },
                    child: Text(loginMode!
                        ? "Have no account?"
                        : "Already have an account?"),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
