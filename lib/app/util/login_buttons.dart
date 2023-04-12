import 'package:flutter/material.dart';
import 'package:restaurent_test1/app/util/colors.dart';

class Buttons extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  const Buttons({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(green.withOpacity(0.7)),
        fixedSize: MaterialStateProperty.all(
          Size(width * 0.9, 50),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
