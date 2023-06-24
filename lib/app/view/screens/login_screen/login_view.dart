import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurent_test1/app/helper/constants.dart';
import 'package:restaurent_test1/app/helper/dialog_helper.dart';
import 'package:restaurent_test1/app/util/login_buttons.dart';
import 'package:restaurent_test1/app/util/textfield.dart';
import 'package:restaurent_test1/app/view/screens/home.dart';
import 'package:restaurent_test1/app/view/screens/login_screen/signup_view.dart';
import 'package:restaurent_test1/app/view/widgets/button_widget.dart';
import 'package:restaurent_test1/app/view/widgets/input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final myFormKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final forgetEmailController = TextEditingController();

  @override
void initState() {
  super.initState();
  firebaseAuth.authStateChanges().listen((User? user) {
    if (user != null) {
      // User is already logged in, navigate to the home page
      homePage();
    }
  });
}


  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required.";
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
      return 'Password is required';
    }

    const pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    final regex = RegExp(pattern);

    return !regex.hasMatch(value)
        ? 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character (!@#\$&*~).'
        : null;

    // if (!regex.hasMatch(value)) {
    //   return 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character (!@#\$&*~).';
    // } else {
    //   return "Wrong Password";
    // }
  }

  String? emailError;
  String? passwordError;

  bool obscureText = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    DialogHelper.setContext(context);
    // final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      color: black,
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Please sign in to continue.",
                    style: TextStyle(
                      color: grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Form(
                key: myFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyTextField(
                      hintText: "Email",
                      suffixIcon: const Icon(
                        Icons.mail,
                        color: grey,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        final error = validateEmail(value);
                        setState(() {
                          emailError = error;
                        });
                        return null;
                      },
                      controller: email,
                    ),
                    if (emailError != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          emailError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          passwordError!,
                          textAlign: TextAlign.left,
                          maxLines: 5,
                          style: const TextStyle(
                            fontSize: 12,
                            color: red,
                          ),
                        ),
                      ),
                    const SizedBox(height: 30),
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
                                      loginUser(
                                          email: email.text,
                                          password: password.text);
                                    }),
                                const SizedBox(height: 10),
                                TextButton(
                                  onPressed: () {
                                    forgetEmailDialog();
                                  },
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
                    onTap: () {
                      registrationPage();
                    },
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

  void checkUserLoggedIn() async {
  User? user = firebaseAuth.currentUser;

  if (user != null) {
    // User is already logged in, navigate to the home page
    homePage();
  }
}


  void loginUser({required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        DialogHelper.showLoading();
        final UserCredential userCredential = await firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);

        // Save the user authentication token locally
        final String? userToken = userCredential.user?.uid;
        if (userToken != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userToken', userToken);
        }

        homePage();
      } else {
        DialogHelper.showSnackBar(strMsg: 'Please enter all the fields', context: context);
      }
    } catch (e) {
      DialogHelper.showSnackBar(strMsg: e.toString(), title: 'Error',context: context);
    }
  }

  void forgetEmailDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter Email',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                InputWidget(
                    icon: Icons.email,
                    controller: forgetEmailController,
                    hintText: "Email"),
                const SizedBox(
                  height: 10,
                ),
                ButtonWidget(
                  onPress: () {
                    DialogHelper.showLoading();
                    forgotPass(email: forgetEmailController.text);
                  },
                  buttonText: 'Reset Password',
                  textColor: Colors.white,
                  backgroundColor: red,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void forgotPass({required String email}) async {
    if (email.isEmpty) {
      DialogHelper.hideLoading();
      DialogHelper.showSnackBar(strMsg: 'Please Entera Vailid Email!',context: context);
    } else {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
      try {
        await firebaseAuth.sendPasswordResetEmail(email: email);
        DialogHelper.hideLoading();
        DialogHelper.showErrorDialog(
            title: 'Reset Password',
            description:
                'Please check your email and click on the provided link to reset your password');
      } on FirebaseAuthException catch (e) {
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(strMsg: e.toString(),context: context);
      } catch (e) {
        DialogHelper.hideLoading();
        DialogHelper.showSnackBar(strMsg: e.toString(),context: context);
      }
    }
  }

  void homePage() {
    DialogHelper.hideLoading();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeView()),
        (route) => false);
  }

  void loginPage() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginView()),
        (route) => false);
  }

  void registrationPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignUpView()));
  }
}
