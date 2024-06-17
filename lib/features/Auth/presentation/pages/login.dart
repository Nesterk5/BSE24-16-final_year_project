import 'package:final_year/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:final_year/screens/bottombar.dart';
import 'package:final_year/screens/forgotpassword.dart';
import 'package:final_year/functions/notifications.dart';
import 'package:final_year/features/Auth/presentation/pages/register.dart';
import 'package:final_year/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
//import 'package:final_year/screens/home.dart';
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
          print(response);
          // ignore: use_build_context_synchronously
          displaymessage(context, 'Invalid email or password', false);
        }
        ;
      }
      print(loginUser.body);
    } catch (e) {
      // ignore: avoid_print
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
        if (state is Authenticated) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BottomBar(index: 0, username: state.user.name)));
        }
        if (state is AuthError) {
          displaymessage(context, 'Failed to login', false);
          // context.read<AuthBloc>().add(InitialiseAuthEvent());
          setState(() {
            _isLoading = false;
          });
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [
                            Center(
                                child: Image.asset(
                              'images/app_logo.png',
                              height: 130,
                              width: 130,
                            )),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Welcome Back",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 28),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "empowering you to elevate your quality control processes",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50.0),
                        Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your email";
                                  }
                                  if (!validateEmail(value)) {
                                    return "Please enter valid email";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Email...',
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
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffE8F2EC)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    prefixIcon: const Icon(Icons.lock),
                                  )),
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
                              onPressed: _handleLogin(context),
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(0),
                                  fixedSize: const Size(double.maxFinite, 25),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  backgroundColor: AppColors.appGreen),
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
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Container(
                            //         color: Colors.purple.shade200,
                            //         height: 2,
                            //       ),
                            //     ),
                            //     const Text('Or sign up with'),
                            //     Expanded(
                            //       child: Container(
                            //         color: Colors.purple.shade200,
                            //         height: 2,
                            //       ),
                            //     )
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     ClipRRect(
                            //       borderRadius: BorderRadius.circular(20),
                            //       child: Image.asset(
                            //         'images/google.jpeg',
                            //         height: 40,
                            //       ),
                            //     ),
                            //     ClipRRect(
                            //       borderRadius: BorderRadius.circular(20),
                            //       child: Image.asset(
                            //         'images/facebook.png',
                            //         height: 40,
                            //       ),
                            //     )
                            //   ],
                            // )
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
    return () async {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
        // String phone = _phoneController.text.trim();
        String email = _emailController.text.trim();
        String password = _passwordController.text.trim();
        print("submitting");
        print(email);
        print(password);
        context
            .read<AuthBloc>()
            .add(LoginEvent(email: email, password: password));
      }
    };
  }
}
