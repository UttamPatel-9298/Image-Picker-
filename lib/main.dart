import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Image Picker Demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ImagePickerPage(),
    );
  }
}

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  File? myimagepath;

  Future<void> imageSelection() async {
    try {
      final imagetemp = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (imagetemp == null) return;
      final imagelocation = File(imagetemp.path);
      setState(() {
        myimagepath = imagelocation;
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to Select Image: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Picker Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: imageSelection,
              child: const Text("Select Image from Gallery"),
            ),
            const SizedBox(height: 20),
            myimagepath != null
                ? Image.file(
                    myimagepath!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  )
                : const Text("No Image Selected"),
            Text(
              'Notice : You have to use Emulator or your Mobile, Image piker can not work in Destop',
            ),
          ],
        ),
      ),
    );
  }
}
