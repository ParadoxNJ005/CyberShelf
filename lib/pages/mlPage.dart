import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class Mlpage extends StatefulWidget {
  const Mlpage({super.key});

  @override
  State<Mlpage> createState() => _MlpageState();
}

class _MlpageState extends State<Mlpage> {
  XFile? image;
  String output = 'No prediction yet';
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
        output = 'Processing...'; // Reset output when a new image is picked
      });
      runModel();
    }
  }

  Future<void> runModel() async {
    if (isProcessing) return;
    setState(() {
      isProcessing = true;
    });

    if (image != null) {
      try {
        var predictions = await Tflite.runModelOnImage(
          path: image!.path,
          imageMean: 127.5,
          imageStd: 127.5,
          numResults: 2,
          threshold: 0.1,
          asynch: true,
        );

        setState(() {
          if (predictions != null && predictions.isNotEmpty) {
            output = predictions.map((e) => e['label']).join(', ');
          } else {
            output = 'No prediction';
          }
        });
      } catch (e) {
        setState(() {
          output = 'Error running model: $e';
        });
      } finally {
        setState(() {
          isProcessing = false;
        });
        await Tflite.close(); // Unload the model
      }
    }
  }

  loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/labels.txt",
      );
    } catch (e) {
      setState(() {
        output = 'Error loading model: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Classification")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: image == null
                  ? Center(child: Text("No image selected"))
                  : Image.file(File(image!.path)),
            ),
          ),
          ElevatedButton(
            onPressed: pickImage,
            child: Text("Pick Image"),
          ),
          SizedBox(height: 20),
          Text(
            output,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
