// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:final_year/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _LoginState();
}

class _LoginState extends State<Signup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;
  bool validateEmail(String email) {
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(email);
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isPasswordMatching(String password, String ConfirmPassword) {
    return password == ConfirmPassword;
  }

  Future registerUser() async {
    try {
      var registerUser = await http.post(
          Uri.parse(
              'https://mqis.000webhostapp.com/finalYearProject/register.php'),
          body: {
            'username': _usernameController.text,
            'email': _emailController.text,
            'password': _passwordController.text
          });
      if (registerUser.statusCode == 200) {
        print(registerUser.body);
        var response = jsonDecode(registerUser.body);

        if (response['registered']) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Home(username: _usernameController.text)));
        } else {
          // print('jjjj');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      // appBar: AppBar(
      //   title: const Text('Login'),
      // ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Column(
                        children: [
                          Text(
                            "Welcome!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Please sign up to get started",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 20.0),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }
                                if (!validateEmail(value)) {
                                  return "Please enter valid email";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                labelText: 'Username',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your username";
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Confirm Password',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please confirm your password";
                                }
                                if (!isPasswordMatching(
                                    _passwordController.text,
                                    _confirmPasswordController.text)) {
                                  return "Password not matching";
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),

                      _isLoading
                          ? CircularProgressIndicator()
                          : Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      FocusScope.of(context).unfocus();
                                      await registerUser();
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(240, 20),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      backgroundColor: Colors.green),
                                  child: const Text(
                                    'Sign in',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Colors.purple.shade200,
                                        height: 2,
                                      ),
                                    ),
                                    const Text('Or sign up with'),
                                    Expanded(
                                      child: Container(
                                        color: Colors.purple.shade200,
                                        height: 2,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'images/google.jpeg',
                                        height: 40,
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'images/facebook.png',
                                        height: 40,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
