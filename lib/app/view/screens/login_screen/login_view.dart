import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurent_test1/app/util/colors.dart';
import 'package:restaurent_test1/app/util/login_buttons.dart';
import 'package:restaurent_test1/app/view/screens/home.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();

  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Welcome to the Fun Food World",
              style: TextStyle(
                color: green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              "assets/login.png",
              fit: BoxFit.cover,
            ),
            Form(
              key: myFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: width * 0.9,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: green,
                    ),
                    child: Center(
                      child: TextFormField(
                        style: const TextStyle(color: white),
                        cursorColor: white,
                        controller: email,
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return "Please Enter Your email";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: white),
                          suffixIcon: Icon(
                            Icons.email,
                            color: white,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 60,
                    width: width * 0.9,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: green,
                    ),
                    child: Center(
                      child: TextFormField(
                        style: const TextStyle(color: white),
                        cursorColor: white,
                        controller: pass,
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return "Please Enter Password";
                          }
                          return null;
                        },
                        obscureText: !obscureText,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          hintStyle: const TextStyle(color: white),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                            child: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Buttons(
                    buttonText: "Submit",
                    onPressed: () {
                      if (myFormKey.currentState!.validate()) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomeView(),
                          ),
                        );
                        login();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text, password: pass.text)
          .then((value) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomeView()));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: pass.text)
            .then((value) async {
          await saveUser(
              email: email.text,
              name: email.text.split('@')[0],
              photo: value.user!.photoURL ?? "");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const HomeView()));
        });
      }
    }
  }

  saveUser({
    required String email,
    required String name,
    required String photo,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final firestore = await FirebaseFirestore.instance
        .collection('Users')
        .where('uid', isEqualTo: uid)
        .get();
    if (firestore.docs.isEmpty) {
      await FirebaseFirestore.instance.collection("Users").doc(uid).set({
        "name": name,
        "email": email,
        "photo": photo,
      }).then((value) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomeView()));
      });
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomeView()));
    }
  }
}
