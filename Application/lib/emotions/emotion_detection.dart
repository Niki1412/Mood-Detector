import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:intl/intl.dart';
import 'package:ms_project/main.dart';
import 'package:ms_project/drawer.dart';

class EmotionDetection extends StatefulWidget {
  static const routeName = '/emotion-detection';

  const EmotionDetection({Key? key}) : super(key: key);

  @override
  State<EmotionDetection> createState() => _EmotionDetectionState();
}

class _EmotionDetectionState extends State<EmotionDetection> {
  CameraImage? cameraImage;

  CameraController? cameraController;

  String output = '';

  void beforeInit() async {
    await loadCamera();
    await loadModel();
    await Future.delayed(const Duration(seconds: 5));
    returnToHome();
  }

  @override
  void initState() {
    super.initState();
    beforeInit();
  }

  loadCamera() {
    cameraController = CameraController(cameras![1], ResolutionPreset.medium);
    cameraController!.initialize().then(
      (value) {
        if (!mounted) {
          return;
        } else {
          setState(
            () {
              cameraController!.startImageStream(
                (imageStream) {
                  cameraImage = imageStream;
                  runModel();
                },
              );
            },
          );
        }
      },
    );
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );
      for (var element in predictions!) {
        setState(
          () {
            output = element['label'];
          },
        );
      }
    }
  }

  void returnToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HiddenDrawer(
          mood: output.split(" ")[1],
        ),
      ),
    );
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  String loadColor() {
    if (output.split(" ")[1] == 'Neutral') {
      return '0xfff48fb1';
    } else if (output.split(" ")[1] == 'Disgusted') {
      return '0xff2e7d32';
    } else if (output.split(" ")[1] == 'Sad') {
      return '0xff82b1ff';
    } else if (output.split(" ")[1] == 'Fearful') {
      return '0xfffb8c00';
    } else if (output.split(" ")[1] == 'Happy') {
      return '0xffffeb3b';
    } else if (output.split(" ")[1] == 'Surprised') {
      return '0xff311b92';
    } else {
      return '0xfff44336';
    }
  }

  @override
  void dispose() {
    super.dispose();
    cameraController!.dispose();
    if (output.split(" ")[0] != -1 && output.split(" ")[1] != '') {
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.email.toString())
          .set(
        {
          DateFormat('EEEE').format(DateTime.now()).toLowerCase(): {
            'day': DateFormat('MMMd').format(DateTime.now()).toLowerCase(),
            'moodScore': int.parse(output.split(" ")[0]),
            'colorVal': loadColor().toString(),
          }
        },
        SetOptions(merge: true),
      ).then((value) => print("success"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: !cameraController!.value.isInitialized
                  ? Container()
                  : AspectRatio(
                      aspectRatio: cameraController!.value.aspectRatio,
                      child: CameraPreview(cameraController!),
                    ),
            ),
          ),
          Text(
            output,
            style: const TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
