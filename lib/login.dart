import 'package:final_year/bottombar.dart';
import 'package:final_year/forgotpassword.dart';
import 'package:final_year/functions/notifications.dart';
import 'package:final_year/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:final_year/home.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  bool validateEmail(String email) {
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(email);
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Future loginUser() async {
    try {
      var loginUser = await http.post(
          Uri.parse(
              'https://mqis.000webhostapp.com/finalYearProject/login.php'),
          body: {
            'email': _emailController.text,
            'password': _passwordController.text
          }).timeout(const Duration(seconds: 30));
      if (loginUser.statusCode == 200) {
        print(loginUser.body);
        var response = jsonDecode(loginUser.body);

        if (response['successful_login']) {
          // ignore: use_build_context_synchronously
          String username = response['username'];
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomBar(
                        index: 0,
                        username: username,
                      )));
        } else {
          // ignore: use_build_context_synchronously
          displaymessage(context, 'Invalid email or password', false);
        }
        ;
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      resizeToAvoidBottomInset: true,
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
                            "Welcome Back",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "empowering you to elevate your quality control processes",
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
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ForgotPassword()));
                                  },
                                  child: const Text(
                                    'Forgot password?',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });
                                FocusScope.of(context).unfocus();
                                await loginUser();
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(10),
                                fixedSize: const Size(240, 20),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                backgroundColor: Colors.green),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Sign in',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Signup()));
                            },
                            child: const Text(
                              "Don't have an account? Signup",
                            ),
                          ),
                          const SizedBox(
                            height: 10,
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
