import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:restaurent_test1/app/helper/constants.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  late List<CameraDescription> cameras;
  String? profileImage;
  bool isBack = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize({int index = 0}) async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    await controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> uploadImage(File image) async {
    try {
      final currentUser = firebaseAuth.currentUser!.uid;
      final firebaseStorageRef = firebaseStorage.ref();
      final newImageRef =
          firebaseStorageRef.child('profile_image/$currentUser.jpg');

      final uploadTask = newImageRef.putFile(image);
      final snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        final downloadUrl = await newImageRef.getDownloadURL();
        setState(() {
          profileImage = downloadUrl;
        });

        // Update the Firestore document with the image URL
        await fireStore
            .collection('User')
            .doc(currentUser)
            .update({'photo': downloadUrl});
      }
    } catch (e) {
      log('Error uploading image: $e');
    }
  }

  Widget buildCameraPreview() {
    if (!controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
            ),
            child: profileImage == null
                ? buildCameraPreview()
                : Image.network(profileImage!),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: SizedBox.expand(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.browse_gallery_rounded,
                      color: blue,
                      size: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.takePicture().then((value) {
                        File file = File(value.path);
                        uploadImage(file);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(360),
                          border: Border.all(color: blue)),
                      child: const CircleAvatar(
                          backgroundColor: Colors.transparent, radius: 30),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await controller.dispose().then((value) {
                        if (isBack) {
                          initialize(index: 1);
                          setState(() {
                            isBack = false;
                          });
                        } else {
                          initialize(index: 0);
                          setState(() {
                            isBack = true;
                          });
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.flip_camera_ios,
                      color: blue,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
