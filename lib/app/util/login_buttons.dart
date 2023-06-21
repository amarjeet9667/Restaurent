import 'package:flutter/material.dart';
import 'package:restaurent_test1/app/helper/constants.dart';

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
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 55,
        width: width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            begin: Alignment.center,
            end: Alignment.centerRight,
            colors: [
              orange1,
              orange2,
              orange3,
              orange4,
              orange5,
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              color: white,
            )
          ],
        ),
      ),
    );
  }
}
