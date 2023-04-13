import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurent_test1/app/util/colors.dart';
import 'package:restaurent_test1/app/util/login_buttons.dart';
import 'package:restaurent_test1/app/util/textfield.dart';
import 'package:restaurent_test1/app/view/screens/home.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final myFormKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final pass = TextEditingController();
  final myValidator = (value) {
    if (value == null || value.isEmpty) {
      return "This field is required.";
    }
    return null;
  };

  bool obscureText = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: grey),
    );
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: myFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                        color: black,
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Please sign in to continue.",
                      style: TextStyle(
                        color: grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 90),
                    MyTextField(
                      hintText: "Email",
                      suffixIcon: const Icon(
                        Icons.mail,
                        color: grey,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: myValidator,
                      controller: email,
                    ),
                    const SizedBox(height: 30),
                    MyTextField(
                      hintText: "Password",
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                          color: grey,
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      obscureText: !obscureText,
                      validator: myValidator,
                      controller: pass,
                    ),
                    const SizedBox(height: 50),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: green,
                            ),
                          )
                        : Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Buttons(
                                  buttonText: "Submit",
                                  onPressed: () {
                                    if (myFormKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      login();
                                    }
                                  },
                                ),
                                const SizedBox(height: 10),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Forget Password",
                                    style: TextStyle(
                                        color: blue,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: black),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: green,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
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
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> saveUser({
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
