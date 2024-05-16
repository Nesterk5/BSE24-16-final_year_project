import 'package:flutter/material.dart';
import 'step_widget.dart';

class StepIndicator extends StatelessWidget {
  const StepIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StepWidget(
            stepNumber: 1,
            description: ' Step 1:\nClick on the plus button at the bottom',
          ),
          StepWidget(
            stepNumber: 2,
            description:
                ' Step 2:\nTake picture or upload meat image from gallery',
          ),
          StepWidget(
            stepNumber: 3,
            description: ' Step 3:\nSubmit for quality inspection',
          ),
          StepWidget(
            stepNumber: 4,
            description: ' Step 4:\nReceive inspection results',
          ),
        ],
      ),
    );
  }
}
