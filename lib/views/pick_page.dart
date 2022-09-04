import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class PickReceipt extends StatefulWidget {
  const PickReceipt({Key? key}) : super(key: key);

  @override
  State<PickReceipt> createState() => _PickReceiptState();
}

class _PickReceiptState extends State<PickReceipt> {
  bool textScanning = false;
  XFile? imageFile;
  String scannedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Image'),
      ),
      body: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            if (textScanning) const CircularProgressIndicator(),
            if (!textScanning && imageFile == null)
              Container(
                width: 300,
                height: 300,
                color: Colors.grey[300],
              ),
            if (imageFile != null)
              SizedBox(
                  width: 300,
                  height: 500,
                  child: Image.file(File(imageFile!.path))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  child: Column(
                    children: const [
                      Icon(Icons.image, size: 30),
                      Text(
                        "Gallery",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  child: Column(
                    children: const [
                      Icon(Icons.camera_alt, size: 30),
                      Text(
                        "Camera",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _clearImage,
                  child: Column(
                    children: const [
                      Icon(Icons.cancel, size: 30),
                      Text(
                        "Cancel",
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Text(scannedText),
          ],
        )),
      ),
    );
  }

  void _clearImage() {
    setState(() {
      imageFile = null;
      scannedText = '';
    });
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      setState(() {
        textScanning = false;
        imageFile = null;
        scannedText = 'Error occured while scanning';
      });
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = "$scannedText${line.text}\n";
      }
    }
    setState(() {
      textScanning = false;
    });
  }
}
