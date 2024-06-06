import 'dart:convert';
//import 'dart:ffi';

import 'package:final_year/Resetpassword.dart';
import 'package:final_year/functions/notifications.dart';
import 'package:final_year/login.dart';
import 'package:final_year/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;
import 'package:odoo_rpc/odoo_rpc.dart';

class Functions {
  Future<bool> sendEmail(String receiver, String code, String name) async {
    // Note that using a username and password for gmail only works if
    // you have two-factor authentication enabled and created an App password.
    // Search for "gmail app password 2fa"
    // The alternative is to use oauth.
    String username = 'meatqualitysystem@gmail.com';
    String password = 'lznusnhmcakpscjh';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    String emailmessage = '''
<!DOCTYPE html>
<html>
  <head>
    <style>
    .outer-card {
  background-color: #f2f2f2; /* Light grey background color */
  padding: 20px;
  border-radius: 10px; /* Rounded corners */
}

.inner-card {
  background-color: #ffffff; /* White background color */
  padding: 20px;
  border-radius: 8px; /* Rounded corners */
  
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Box shadow for depth */
}
    </style>
  </head>
  <body>
     <div class="outer-card">
  <div class="inner-card">
    <h2>Hi $name</h2>
    <p>Enter this code to reset your password</p>
    <h2>$code</h2>
  </div>
</div>
  </body>
</html>
''';
    final message = Message()
      ..from = Address(username, 'Meat Quality System')
      ..recipients.add(receiver)
      //   ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      //   ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject =
          'Verification code for password reset :: 😀 :: ${DateTime.now()}'
      //..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = emailmessage;

    try {
      await send(message, smtpServer);

      return true;
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
    // DONE

    // // Let's send another message using a slightly different syntax:
    // //
    // // Addresses without a name part can be set directly.
    // // For instance `..recipients.add('destination@example.com')`
    // // If you want to display a name part you have to create an
    // // Address object: `new Address('destination@example.com', 'Display name part')`
    // // Creating and adding an Address object without a name part
    // // `new Address('destination@example.com')` is equivalent to
    // // adding the mail address as `String`.
    // final equivalentMessage = Message()
    //   ..from = Address(username, 'Your name 😀')
    //   ..recipients.add(Address('destination@example.com'))
    //   ..ccRecipients.addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
    //   ..bccRecipients.add('bccAddress@example.com')
    //   ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
    //   ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    //   ..html = '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>'
    //   ..attachments = [
    //     FileAttachment(File('exploits_of_a_mom.png'))
    //       ..location = Location.inline
    //       ..cid = '<myimg@3.141>'
    //   ];

    // final sendReport2 = await send(equivalentMessage, smtpServer);

    // // Sending multiple messages with the same connection
    // //
    // // Create a smtp client that will persist the connection
    // var connection = PersistentConnection(smtpServer);

    // // Send the first message
    // await connection.send(message);

    // // send the equivalent message
    // await connection.send(equivalentMessage);

    // // close the connection
    // await connection.close();
  }

  // ignore: non_constant_identifier_names
  Future verify_code(BuildContext context, String email, String code) async {
    try {
      var verify_code = await http.post(
          Uri.parse(
              'https://mqis.000webhostapp.com/finalYearProject/verify_code.php'),
          body: {
            'email': email,
            'code': code,
          }).timeout(Duration(seconds: 60));
      if (verify_code.statusCode == 200) {
        print(verify_code.body);
        var response = jsonDecode(verify_code.body);

        if (response['valid_code'] == true) {
          if (response['not_expired']) {
            // String email = response['email'];
            // ignore: use_build_context_synchronously
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResetPassword(
                          email: email,
                        )));
          } else {
            // ignore: use_build_context_synchronously
            displaymessage(context, 'Verification code expired', false);
          }
        } else {
          // ignore: use_build_context_synchronously
          displaymessage(context, 'Invalid code', false);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  // ignore: non_constant_identifier_names
  Future updatePassword(
      BuildContext context, String email, String password) async {
    try {
      var updatePassword = await http.post(
          Uri.parse(
              'https://mqis.000webhostapp.com/finalYearProject/update_password.php'),
          body: {
            'email': email,
            'new_Password': password,
          }).timeout(const Duration(seconds: 60));
      if (updatePassword.statusCode == 200) {
        print(updatePassword.body);
        var response = jsonDecode(updatePassword.body);

        if (response['password_updated'] == true) {
          // ignore: use_build_context_synchronously
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Login()));
        } else {
          // ignore: use_build_context_synchronously
          displaymessage(context, 'Failed to update password', false);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future process_image() async {
    var image;
    final client = OdooClient(DATABASE_URL);

    final session =
        await client.authenticate(DATABASE_NAME, USERNAME, PASSWORD);

  
    var response = await client.callKw({
      'model': 'meat.quality',
      'method': 'process_image',
      'args': [
        'self',
        {
          'name': image,
        }
      ],
      'kwargs': {},
    }).timeout(const Duration(seconds: 120));

    print(response);
    return response;
  }
}
