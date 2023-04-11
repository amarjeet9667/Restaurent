import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_test1/app/provider/addbutton_provider.dart';
import 'package:restaurent_test1/app/util/colors.dart';
import 'package:restaurent_test1/app/view/screens/home.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({
    super.key,
  });

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: white.withOpacity(0.12),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Center(
          child: Text(
            "Tutor Bin Canteen",
            style: TextStyle(
                color: black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: white),
              child: Row(
                children: const [
                  Icon(
                    Icons.access_time_outlined,
                    color: green,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Delivery in 25 mins",
                    style: TextStyle(color: black, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      children: const [
                        Icon(Icons.paste, color: green),
                        SizedBox(width: 10),
                        Text(
                          "Your Order",
                          style: TextStyle(
                              color: black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Consumer<AddButtonProvider>(
                      builder: (context, value, _) {
                        return ListView.builder(
                            itemCount: value.cart.length,
                            itemBuilder: (context, index) {
                              final name = value.cart.keys.elementAt(index);
                              final price = value.cart[name];
                              log(value.cart[name].toString());
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          size: 10,
                                          color: green,
                                        ),
                                        const SizedBox(width: 15),
                                        Text(
                                          name,
                                          style: const TextStyle(
                                            color: black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: Text(
                                        "₹ ${price.toString()}",
                                        style: const TextStyle(
                                          color: black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Add more items ?",
                          style: TextStyle(color: black),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (builder) => const HomeView()));
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: green,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: height * 0.2,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "SubTotal",
                        style: TextStyle(
                            color: black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\u20B9 100",
                        style: TextStyle(
                            color: black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
