//import 'package:final_year/forgotpassword2.dart';
import 'dart:convert';

import 'package:final_year/functions/functions.dart';
import 'package:final_year/functions/notifications.dart';
import 'package:final_year/verificationCode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  Functions sendemail = Functions();
  bool _isLoading = false;
  bool validateEmail(String email) {
    final emailRegex = RegExp(
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    return emailRegex.hasMatch(email);
  }

  Future sendCode() async {
    try {
      var sendCode = await http.post(
          Uri.parse(
              'https://mqis.000webhostapp.com/finalYearProject/send_verification_code.php'),
          body: {
            'email': _emailController.text,
          }).timeout(Duration(seconds: 60));
      if (sendCode.statusCode == 200) {
        print(sendCode.body);
        var response = jsonDecode(sendCode.body);

        if ((response['user_exists'] == true) &&
            (response['createcode'] == true)) {
          String receiver = _emailController.text;
          String code = response['code'].toString();
          String username = response['username'];
          // ignore: use_build_context_synchronously
          bool emailtoReceiver =
              await sendemail.sendEmail(receiver, code, username);
          // ignore: use_build_context_synchronously
          if (emailtoReceiver == true) {
            // ignore: use_build_context_synchronously
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ForgotPassword2(email: _emailController.text)));
          } else {
            // ignore: use_build_context_synchronously
            displaymessage(
                context,
                'There was an error sending the verification code. Please retry',
                false);
          }
        } else if ((response['user_exists'] == true) &&
            (response['createcode'] == false)) {
          // ignore: use_build_context_synchronously
          displaymessage(
              context,
              'There was an error sending the verification code. Please retry',
              false);
        } else {
          // ignore: use_build_context_synchronously
          displaymessage(context, 'The specified user does not exist', false);
        }
      }
    } catch (e) {
      print(e);
    }
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
            children: [
              const Text(
                'Forgot Password',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: _formkey,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      if (!validateEmail(value)) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "We'll send a verification code to this Email if it matches an existing account",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 50,
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            FocusScope.of(context).unfocus();
                            await sendCode();
                            setState(() {
                              _isLoading = false;
                            });
                            // ignore: use_build_context_synchronously
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ForgotPassword2(
                            //               email: _emailController.text,
                            //             )));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(240, 20),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            backgroundColor: Colors.green),
                        child: const Text(
                          'Next',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
