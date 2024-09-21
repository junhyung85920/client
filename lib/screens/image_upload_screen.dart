import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../services/image_service.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});
  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  List<XFile>? _images;

  void _pickImages() async {
    var images = await ImagePickerService().pickImage();
    setState(() {
      _images = images;
    });
  }

  Future<void> _uploadImages() async {
    var uri = Uri.parse('YOUR_BACKEND_URL'); // 서버 URL
    var request = http.MultipartRequest('POST', uri);

    for (var image in _images!) {
      var multipartFile = await http.MultipartFile.fromPath(
        'picture', // 백엔드에서 기대하는 필드 이름
        image.path,
      );
      request.files.add(multipartFile);
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      print('Uploaded successfully!');
    } else {
      print('Upload failed!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application Screen"),
        actions: [
          IconButton(
            icon: Icon(Icons.upload_file),
            onPressed: _uploadImages,
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickImages,
            child: Text('Pick Images'),
          ),
          Expanded(
            child: _images == null
                ? Center(child: Text('No images selected.'))
                : GridView.builder(
                    itemCount: _images!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return Image.file(File(_images![index].path));
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
