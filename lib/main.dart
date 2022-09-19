import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:autenticationjwt/boasvindas_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // HttpOverrides.global = MyHttpOverrides();

  // runApp(const MyApp());

  var _headers = {
    'Authorization':
        'Basic PEJhc2ljIEF1dGggVXNlcm5hbWU+OjxCYXNpYyBBdXRoIFBhc3N3b3JkPg==',
    'Content-Type': 'application/json',
  };

  var _body = json.encode({
    "email": 'teste@gmail.com',
    "password": 'senha12345',
  });

  var _url = Uri.parse('http://localhost:3001/token');

  var _client = http.Client();
  var response = await _client.post(_url, headers: _headers, body: _body);

  log(response.body);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'login',
      home: BoasVindasPage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
