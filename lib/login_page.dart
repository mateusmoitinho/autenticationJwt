import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passowrdController = TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 184, 184, 184),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                "Login",
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Por favor, digite seu e-mail';
                  } else if (!RegExp(
                          r"^[a-ZA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(_emailController.text)) {
                    return 'Por favor, digite um email e-mail correto';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: 'Email'),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: _passowrdController,
                keyboardType: TextInputType.text,
                validator: (senha) {
                  if (senha == null || senha.isEmpty) {
                    return 'Por favor, digite sua senha';
                  } else if (senha.length < 6) {
                    return 'Por favor, digite uma senha maior que 6 caracteres';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: 'Senha'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Entrar"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var url = Uri.parse('uri');
    var resposta = await http.post(
      url,
      body: {
        'username': _emailController.text,
        'password': _passwordController.text
      },
    );
    if (resposta.statusCode == 200) {
      print(jsonDecode(resposta.body)['token']);
      return true;
    } else
      print(jsonDecode(resposta.body));

    return false;
  }
}
