import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  String? _emailInput;
  String? _passwordInput;

  @override
  Widget build(BuildContext context) {
    void _submit() {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
        print(_emailInput);
        print(_passwordInput);
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
                        return "이메일이 비어있다";
                      } else if (!value.contains('@')) {
                        return "이메일 형식을 맞추자";
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
                        return "비밀번호에는 뭐라도 적어라";
                      } else if (value.length < 6) {
                        return "너무 짧은 것 같은데?";
                      }
                    },
                    onSaved: (newValue) {
                      _passwordInput = newValue;
                    },
                    obscureText: true,
                    enableSuggestions: false,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  FilledButton(onPressed: _submit, child: const Text("Login"))
                ],
              ),
            ),
          )),
    );
  }
}
