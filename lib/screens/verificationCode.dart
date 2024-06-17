//import 'package:final_year/Resetpassword.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:final_year/functions/functions.dart';

class ForgotPassword2 extends StatefulWidget {
  const ForgotPassword2({super.key, required this.email});
  final String email;

  @override
  State<ForgotPassword2> createState() => _ForgotPassword2State();
}

class _ForgotPassword2State extends State<ForgotPassword2> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController _codeController = TextEditingController();
  Functions verify_code = Functions();
  bool _isLoading = false;
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter the 6-digit code',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Check ${widget.email} for a verification code",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                    key: _formkey,
                    child: TextFormField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6)
                      ],
                      decoration: const InputDecoration(
                        labelText: "Enter Code",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the verification code";
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
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });
                        FocusScope.of(context).unfocus();
                        await verify_code.verify_code(
                            context, widget.email, _codeController.text);
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
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _loading
                    ? Center(
                        child: Text(
                          'Resend code after $remainingexptime',
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      )
                    : Center(
                        child: InkWell(
                            onTap: () async {
                              setState(() {
                                _loading = true;
                                _codeController.clear();
                              });
                              counterdown();
                              // bool otpcreated =
                              //     await auth.createotp(context, widget.phonenumber);
                              // if (otpcreated)
                              //   snackbar.displaymessage(
                              //       context, 'Otp code resent', true);
                            },
                            child: const Text(
                              'Resend Code',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "If you don't see the code in your inbox, check your spam folder. If its not there, the email address may not be confirmed or may not match an existing account",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
