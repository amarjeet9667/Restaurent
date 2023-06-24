import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurent_test1/app/helper/constants.dart';
import 'package:restaurent_test1/app/view/camera_screen.dart';
import 'package:restaurent_test1/app/view/screens/login_screen/login_view.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
    required this.height,
  }) : super(key: key);

  final double height;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isLogOut = false;
  String? profileImage;

  void uploadImage(File image) async {
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

        //Upload image on fireStore.
        await fireStore
            .collection('User')
            .doc(currentUser)
            .update({'photo': downloadUrl});
      }
    } catch (e) {
      log('Error uploading image: $e');
    }
  }

  Future<File?> pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        return File(pickedImage.path);
      }
    } catch (e) {
      log('Select image Error: $e');
    }
    return null;
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CameraScreen(),
                ),
              );
            },
          ),
          const Divider(
            thickness: 1,
            endIndent: 20,
            indent: 20,
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Gallery'),
            onTap: () async {
              Navigator.pop(context);
              final imageFile = await pickImage(ImageSource.gallery);
              if (imageFile != null) {
                uploadImage(imageFile);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: white,
        border: Border.all(
          color: green,
        ),
      ),
      child: Drawer(
        elevation: 0,
        backgroundColor: green.withOpacity(0.2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: fireStore
              .collection('User')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: green,
                ),
              );
            }
            final user = snapshot.data;
            return Column(
              children: [
                DrawerHeader(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Text(
                        "Hi\n${user!.get('name') ?? 'User'}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 50),
                      InkWell(
                        onTap: () {
                          showBottomSheet(context);
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: white,
                          backgroundImage: user != null
                              ? NetworkImage(user.get('photo') ?? '')
                                  as ImageProvider
                              : const AssetImage('assets/user.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                isLogOut
                    ? const Center(
                        child: CircularProgressIndicator(color: green),
                      )
                    : TextButton(
                        onPressed: () {
                          logOut();
                        },
                        child: Text(
                          "LogOut",
                          style: TextStyle(
                            color: green.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }

  void logOut() async {
    // var provider = firebaseAuth.currentUser!.providerData[0].providerId;
    await firebaseAuth.signOut();
    loginPage();
  }

  void loginPage() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginView()),
        (route) => false);
  }
}
