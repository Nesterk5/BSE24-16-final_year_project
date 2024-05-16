import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddSampleDialog extends StatelessWidget {
  const AddSampleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('UPLOAD MEAT IMAGE'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Either upload image from gallery or take a picture'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Handle the upload image action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  fixedSize: const Size(140, 40),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
                icon: const Icon(Icons.cloud_upload),
                label: const Text('Upload'),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  // Handle the take picture action here
                  // Launch the camera
                  final XFile? image = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                  );
                  // Handle the captured image
                  if (image != null) {
                    // Process the captured image
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(140, 40),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Take Picture'),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
