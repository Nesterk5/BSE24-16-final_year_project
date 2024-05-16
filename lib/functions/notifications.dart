import 'package:flutter/material.dart';

void displaymessage(BuildContext context, String message, bool success) {
  final Snackbar = SnackBar(
      dismissDirection: DismissDirection.up,
      duration: const Duration(seconds: 1, milliseconds: 500),
      // margin:
      //     EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 140),
      content: Row(
        children: [
          success
              ? const Icon(Icons.check, color: Colors.white)
              : const Icon(
                  Icons.error,
                  color: Colors.white,
                ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Wrap(children: [
            Text(
              message,
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.fade,
            )
          ])),
        ],
      ),
      backgroundColor: success
          ? Color.fromARGB(255, 19, 175, 24)
          : Color.fromARGB(255, 236, 31, 16));
  ScaffoldMessenger.of(context).showSnackBar(Snackbar);
}
