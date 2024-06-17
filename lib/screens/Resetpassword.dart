import 'dart:async';

import 'package:final_year/functions/functions.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.email});
  final String email;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isPasswordMatching(String password, String ConfirmPassword) {
    return password == ConfirmPassword;
  }

  Functions update_password = Functions();
  bool _isLoading = false;
  // ignore: unused_field
  bool _loading = true;
  String remainingexptime = '';
  void counterdown() {
    int remainingtime = 120;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingtime == 0) {
        timer.cancel();

        setState(() {
          _loading = false;
        });
      } else {
        remainingtime--;
        int minutes = remainingtime ~/ 60;
        int sec = remainingtime % 60;
        setState(() {
          remainingexptime = '$minutes:${sec.toString().padLeft(2, '0')}';
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    counterdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Choose a new Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              const Text(
                "To secure your account, choose a strong password you haven't used before and is atleast 8 characters long ",
                style: TextStyle(fontSize: 20),
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration:
                            const InputDecoration(labelText: 'New password'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your new password";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                            labelText: 'Retype new password'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password";
                          }
                          if (!isPasswordMatching(_passwordController.text,
                              _confirmPasswordController.text)) {
                            return "Password not matching";
                          }

                          return null;
                        },
                      )
                    ],
                  )),
              _isLoading
                  ? const CircularProgressIndicator()
                  : Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              FocusScope.of(context).unfocus();
                              await update_password.updatePassword(context,
                                  widget.email, _passwordController.text);
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(240, 20),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              backgroundColor: Colors.green),
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
