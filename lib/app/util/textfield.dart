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
  bool isTyping = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isTyping
          ? BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(
                      0.5,
                    ),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ])
          : BoxDecoration(
              border: Border.all(
                color: grey.shade400,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
      child: TextFormField(
        obscureText: widget.obscureText ?? false,
        style: const TextStyle(color: black),
        cursorColor: black,
        controller: widget.controller,
        validator: widget.validator,
        autofocus: true,
        onChanged: (value) {
          setState(() {
            isTyping = value.isNotEmpty;
          });
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: grey),
          suffixIcon: widget.suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
