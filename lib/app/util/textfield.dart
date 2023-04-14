// This TextField is used in login page and signup page (eg:-email field,password field and so on)
import 'package:flutter/material.dart';
import 'package:restaurent_test1/app/util/colors.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final Widget suffixIcon;
  final bool? obscureText;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.suffixIcon,
    this.controller,
    this.validator,
    this.obscureText,
    required this.textInputAction,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  FocusNode f1 = FocusNode();
  @override
  void initState() {
    f1.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: f1.hasFocus ? 20 : 0,
        child: Center(
          child: TextFormField(
            obscureText: widget.obscureText ?? false,
            style: const TextStyle(color: black),
            cursorColor: black,
            controller: widget.controller,
            validator: widget.validator,
            focusNode: f1,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: grey),
              suffixIcon: widget.suffixIcon,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            ),
          ),
        ),
      ),
    );
  }
}
