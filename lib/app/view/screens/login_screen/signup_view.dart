import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:restaurent_test1/app/helper/constants.dart';
import 'package:restaurent_test1/app/util/login_buttons.dart';
import 'package:restaurent_test1/app/util/textfield.dart';
import 'package:restaurent_test1/app/view/screens/home.dart';
import 'package:restaurent_test1/app/view/screens/login_screen/login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final formKey = GlobalKey<FormState>();
  final fName = TextEditingController();
  final lName = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confPassword = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return " This field is required";
    }
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    const pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    final regex = RegExp(pattern);

    return !regex.hasMatch(value)
        ? 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character (!@#\$&*~).'
        : null;
  }

  bool isTrue = false;
  bool isConf = false;
  bool isLoading = false;
  String? emailError;
  String? passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListTile(
                leading: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back, color: grey),
                ),
                title: const Text(
                  "Create An Account",
                  style: TextStyle(
                      color: black, fontSize: 20, fontWeight: FontWeight.w800),
                ),
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyTextField(
                        hintText: "First Name",
                        textInputAction: TextInputAction.next,
                        suffixIcon: const Icon(
                          Icons.person,
                          color: grey,
                        ),
                        controller: fName,
                      ),
                      MyTextField(
                        hintText: "Last Name",
                        textInputAction: TextInputAction.next,
                        suffixIcon: const Icon(
                          Icons.more_horiz,
                          color: grey,
                        ),
                        controller: lName,
                      ),
                      MyTextField(
                        hintText: "Phone no.",
                        textInputAction: TextInputAction.next,
                        maxLength: 10,
                        suffixIcon: const Icon(
                          Icons.phone,
                          color: grey,
                        ),
                        controller: phone,
                      ),
                      MyTextField(
                        hintText: "Email",
                        textInputAction: TextInputAction.next,
                        suffixIcon: const Icon(
                          Icons.email,
                          color: grey,
                        ),
                        controller: email,
                        validator: (value) {
                          final eError = validateEmail(value);
                          setState(() {
                            emailError = eError;
                          });
                          return null;
                        },
                      ),
                      if (emailError != null)
                        Text(
                          emailError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      MyTextField(
                        hintText: "Password",
                        obscureText: !isTrue,
                        textInputAction: TextInputAction.next,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isTrue = !isTrue;
                            });
                          },
                          child: Icon(
                            isTrue ? Icons.visibility : Icons.visibility_off,
                            color: grey,
                          ),
                        ),
                        validator: (value) {
                          final pError = validatePassword(value);
                          setState(() {
                            passwordError = pError;
                          });
                          return null;
                        },
                        controller: password,
                      ),
                      if (passwordError != null)
                        Text(
                          passwordError!,
                          textAlign: TextAlign.left,
                          maxLines: 5,
                          style: const TextStyle(
                            fontSize: 12,
                            color: red,
                          ),
                        ),
                      MyTextField(
                        hintText: "Confirm Password",
                        obscureText: !isConf,
                        textInputAction: TextInputAction.done,
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              isConf = !isConf;
                            });
                          },
                          child: Icon(
                            isConf ? Icons.visibility : Icons.visibility_off,
                            color: grey,
                          ),
                        ),
                        validator: (value) {
                          if (value != password.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                        controller: confPassword,
                      ),
                    ],
                  ),
                ),
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 30, top: 50),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Buttons(
                          buttonText: "SIGN UP",
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              registerUser(
                                  name: fName.text,
                                  email: email.text,
                                  password: password.text,
                                  phone: phone.text);
                            }
                          },
                        ),
                      ),
                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Row(
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: black),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          color: green,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void registerUser(
      {required String name,
      required String email,
      required String password,
      required String phone}) async {
    try {
      if (name.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          phone.isNotEmpty) {
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String? token = await FirebaseMessaging.instance.getToken();
        saveUserDetails(
          uid: cred.user!.uid,
          token: token,
          name: name,
          phone: phone,
          email: email,
          password: password,
          photo: '',
        );

        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomeView()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LoginView()));
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void saveUserDetails({
    required String uid,
    String? token,
    required String name,
    required String email,
    required String password,
    required String phone,
    required String photo,
  }) async {
    await FirebaseFirestore.instance.collection("User").doc(uid).set({
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      'photo': photo
    });
  }
}
