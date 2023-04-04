import 'package:flutter/material.dart';
import 'package:restaurent_test1/app/common_colors/colors.dart';
import 'package:restaurent_test1/app/payment_screen/pament_view.dart';

class CustomInkWellButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;

  const CustomInkWellButton({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  _CustomInkWellButtonState createState() => _CustomInkWellButtonState();
}

class _CustomInkWellButtonState extends State<CustomInkWellButton> {
  bool isTapped = false;

  void openBottomSheet(BuildContext context) {
    context;
    showBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 100,
            child: Center(
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.9,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: green,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "1 ITEM",
                          style: TextStyle(color: white),
                        ),
                        Row(
                          children: const [
                            Text(
                              "\u20B9 100",
                              style: TextStyle(
                                  color: white, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "plus taxes",
                              style: TextStyle(color: white, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const PaymentView()));
                          },
                          child: const Text(
                            "PAY NOW",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: white),
                          ),
                        ),
                        const Icon(
                          Icons.play_arrow,
                          color: white,
                          size: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTapped = !isTapped;
        });
        widget.onPressed();
        if (isTapped) {
          openBottomSheet(context);
        } else {
          Navigator.pop(context);
        }
      },
      child: Container(
        height: 40,
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isTapped
              ? widget.backgroundColor
              : widget.backgroundColor.withOpacity(0.48),
        ),
        child: isTapped
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.remove,
                      color: widget.textColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      widget.icon,
                      color: widget.textColor,
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    color: widget.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}
