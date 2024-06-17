import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageUploadingScreen extends StatefulWidget {
  final File imageFile;

  const ImageUploadingScreen({required this.imageFile, Key? key})
      : super(key: key);

  @override
  _ImageUploadingScreenState createState() => _ImageUploadingScreenState();
}

class _ImageUploadingScreenState extends State<ImageUploadingScreen> {
  bool _isUploading = true;
  String _message = "Please wait... your photo is scanning";

  @override
  void initState() {
    super.initState();
    _uploadImage();
  }

  Future<void> _uploadImage() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://mqis.000webhostapp.com/finalYearProject/upload.php'),
    );
    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        widget.imageFile.path,
      ),
    );
    var res = await request.send();
    if (res.statusCode == 200) {
      final response = await http.Response.fromStream(res);
      setState(() {
        _isUploading = false;
        _message = "Image uploaded successfully";
      });
      print(response.body);
    } else {
      setState(() {
        _isUploading = false;
        _message = "Image upload failed";
      });
      print('Image upload failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload photo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _isUploading
                ? const CircularProgressIndicator()
                : const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 80,
                  ),
            const SizedBox(height: 20),
            Text(
              _message,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('View Result'),
        ),
      ),
    );
  }
}
