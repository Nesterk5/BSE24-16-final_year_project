import 'dart:convert';

import 'package:final_year/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

class InspectionDetails extends StatefulWidget {
  final Map<String, dynamic> data;
  const InspectionDetails({super.key, required this.data});

  @override
  State<InspectionDetails> createState() => _InspectionDetailsState();
}

class _InspectionDetailsState extends State<InspectionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Inspection Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.data['name'],
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
            ),
            Text(
              'Inspection Date:  ${widget.data['date_scanned']}',
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              // height: 160,
              // width: double.maxFinite,
              // color: Colors.amber,
              child: widget.data['image'] != false
                  ? Image.memory(base64Decode(widget.data['image']))
                  : const Text(''),
            ),
            const Text('Beef'),
            Text(
              widget.data['score'].toString(),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Text(
                  'Verdict: ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  widget.data['class_label'],
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Overall Score'),
                Text("${widget.data['score'] * 100}")
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            ProgressBar(
              value: widget.data['score'],
              width: double.maxFinite,
              gradient: const LinearGradient(
                colors: [
                  Color(0xffDE2E21),
                  Color(0xffDE2E21),
                ],
              ),
              backgroundColor: const Color(0xFFeeeeee),
            ),
            const SizedBox(
              height: 40,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Inspector's Note",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                Icon(Icons.note_alt_outlined)
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.appGreen,
                  fixedSize: const Size(double.maxFinite, 45),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'))
          ],
        ),
      ),
    );
  }
}
