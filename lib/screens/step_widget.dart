import 'package:flutter/material.dart';

class StepWidget extends StatelessWidget {
  final int stepNumber;
  final String description;
  const StepWidget({
    super.key,
    required this.stepNumber,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 20,
                    child: Text(
                      stepNumber.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  if (stepNumber != 4) // Add vertical line if not the last step
                    Container(
                      height: 40,
                      width: 2,
                      color: Colors.black,
                    ),
                ],
              ),
              const SizedBox(width: 5),
              Expanded(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: Text(description),
              ))
            ],
          ),
          const SizedBox(height: 10), // Space between steps
        ],
      ),
    );
  }
}
