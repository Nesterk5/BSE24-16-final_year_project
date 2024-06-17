// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:final_year/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:final_year/screens/bottombar.dart';
import 'package:final_year/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                      BottomBar(index: 0, username: _usernameController.text)));
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() {
            _isLoading = true;
          });
        }

        if (state is SignedUp) {
          context.read<AuthBloc>().add(LoginEvent(
              email: _emailController.text,
              password: _passwordController.text));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
                        Column(
                          children: [
                            Center(
                                child: Image.asset(
                              'images/app_logo.png',
                              height: 130,
                              width: 130,
                            )),
                            const Text(
                              "Welcome!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
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
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  filled: true,
                                  fillColor: const Color(0xffE8F2EC),
                                  contentPadding: const EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffE8F2EC)),
                                      borderRadius: BorderRadius.circular(15)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffE8F2EC)),
                                      borderRadius: BorderRadius.circular(15)),
                                  prefixIcon: const Icon(Icons.email),
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
                                decoration: InputDecoration(
                                  hintText: 'Username',
                                  filled: true,
                                  fillColor: const Color(0xffE8F2EC),
                                  contentPadding: const EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffE8F2EC)),
                                      borderRadius: BorderRadius.circular(15)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffE8F2EC)),
                                      borderRadius: BorderRadius.circular(15)),
                                  prefixIcon: const Icon(Icons.person),
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
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  filled: true,
                                  fillColor: const Color(0xffE8F2EC),
                                  contentPadding: const EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffE8F2EC)),
                                      borderRadius: BorderRadius.circular(15)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffE8F2EC)),
                                      borderRadius: BorderRadius.circular(15)),
                                  prefixIcon: const Icon(Icons.lock),
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
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  filled: true,
                                  fillColor: const Color(0xffE8F2EC),
                                  contentPadding: const EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffE8F2EC)),
                                      borderRadius: BorderRadius.circular(15)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xffE8F2EC)),
                                      borderRadius: BorderRadius.circular(15)),
                                  prefixIcon: const Icon(Icons.lock),
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
                            ? const CircularProgressIndicator()
                            : Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: _handleLogin(context),
                                    style: ElevatedButton.styleFrom(
                                        fixedSize:
                                            const Size(double.maxFinite, 20),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        backgroundColor: Colors.green),
                                    child: const Text(
                                      'Sign up',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Login instead?"))
                                ],
                              ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  VoidCallback _handleLogin(BuildContext context) {
    print('on Password page....');
    // print(removeSpaces(inputNumber.phoneNumber.toString()));
    return () async {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
        // String phone = _phoneController.text.trim();
        String name = _usernameController.text;
        String email = _emailController.text;
        String password = _passwordController.text.trim();

        context.read<AuthBloc>().add(SignupEvent(
            phone: '', email: email, password: password, name: name));
      }
    };
  }
}
