import 'package:flutter/material.dart';

class InspectionHistory extends StatefulWidget {
  const InspectionHistory({super.key});

  @override
  State<InspectionHistory> createState() => _InspectionHistoryState();
}

class _InspectionHistoryState extends State<InspectionHistory> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
                child: Text(
              'Inspection History',
              style: TextStyle(fontSize: 25),
            ))
          ],
        ),
      )),
    );
  }
}
