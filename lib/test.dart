import 'dart:typed_data';

import 'package:final_year/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TestConnection extends StatefulWidget {
  const TestConnection({super.key});

  @override
  State<TestConnection> createState() => _TestConnectionState();
}

class _TestConnectionState extends State<TestConnection> {
  Uint8List? _imageBytes;

  Future<void> _selectImage() async {
    final Uint8List? selectedImage = await pickImage();
    setState(() {
      _imageBytes = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_imageBytes != null)
              FutureBuilder(
                  future: Functions.process_image(_imageBytes),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return Center(child: Text('Data: ${snapshot.data}'));
                    } else {
                      return Center(child: Text('No data available'));
                    }
                  }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectImage,
              child: Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Uint8List?> pickImage() async {
    final ImagePicker _picker = ImagePicker();

    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      // No image was selected
      return null;
    }

    // Convert the image to Uint8List
    final Uint8List imageBytes = Uint8List.fromList(await image.readAsBytes());
    return imageBytes;
  }
}
