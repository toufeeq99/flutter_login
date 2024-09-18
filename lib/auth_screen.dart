import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login_page/log_out.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final String apiUrl =
      'https://erpapi.erpaga.com/api/ApiAuthentication/Authenticate';
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  Future<void> loginUser(String email, String password) async {
    try {
      var body = jsonEncode({
        'email': email,
        'password': password,
      });

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      // Print the full response body
      print("Response body: ${response.body}");
      print("Response body: ${response.statusCode}");

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        // Access the accessToken inside the nested 'token' object
        if (jsonResponse != null && jsonResponse['token'] != null) {
          String accessToken = jsonResponse['token']['accessToken'];
          print("Login successful, Access Token: $accessToken");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const LogOut()), // Navigate to HomePage
          );
        } else {
          print("Error: Access token is missing or null in the response");
        }
      } else {
        print("Login failed, Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.blueAccent.shade700,
        Colors.blueAccent.shade400,
        Colors.blueAccent.shade200
      ], begin: Alignment.topCenter)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Welcom Back',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Card(
                    margin: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade200))),
                              child: TextField(
                                controller: emailcontroller,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    label: Text(
                                  'Email Adress',
                                )),
                              ),
                            ),
                            TextField(
                              controller: passwordcontroller,
                              decoration: const InputDecoration(
                                  label: Text('Password')),
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Forget password',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        loginUser(
                            emailcontroller.text, passwordcontroller.text);
                      },
                      child: const Text(
                        'Log in',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 200,
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
