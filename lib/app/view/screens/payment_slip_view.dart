import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:just_audio/just_audio.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_test1/app/helper/dialog_helper.dart';
import 'package:restaurent_test1/app/provider/addbutton_provider.dart';
import 'package:restaurent_test1/app/helper/constants.dart';
import 'package:restaurent_test1/app/view/screens/home.dart';
import 'package:restaurent_test1/app/view/screens/succeful_screen.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({
    super.key,
  });

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  Dio dio = Dio();
  bool _isPaymentSuccessful = false;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Map<String, dynamic>? paymentIntent;
  @override
  Widget build(BuildContext context) {
    String payAmount =
        (context.read<AddButtonProvider>().cartAmount + 25).toString();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white.withOpacity(0.92),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Consumer<AddButtonProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      child: Text(
                        "Tutor Bin Canteen",
                        style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: white),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: green,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Delivery in 25 mins",
                            style: TextStyle(
                                color: black, fontWeight: FontWeight.bold),
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
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              children: [
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
                          if (value.cartAmount >= 1)
                            Expanded(
                              child: Consumer<AddButtonProvider>(
                                builder: (context, value, _) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: value.cart.length,
                                      itemBuilder: (context, index) {
                                        final name =
                                            value.cart.keys.elementAt(index);
                                        final price = value.cart[name]!;
                                        int quantity =
                                            value.quantity[name] ?? 1;

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          child: quantity == 0
                                              ? Container()
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.circle,
                                                              size: 10,
                                                              color: green,
                                                            ),
                                                            const SizedBox(
                                                                width: 15),
                                                            Text(
                                                              name,
                                                              style:
                                                                  const TextStyle(
                                                                color: black,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      25),
                                                          child: Text(
                                                            "₹ ${price.toString()}",
                                                            style:
                                                                const TextStyle(
                                                              color: black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      width: 100,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: green,
                                                      ),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                if (value
                                                                        .cartAmount >=
                                                                    1) {
                                                                  value
                                                                      .decreaseQuantity(
                                                                    name,
                                                                    price,
                                                                  );
                                                                }
                                                              },
                                                              child: const Icon(
                                                                Icons.remove,
                                                                color: white,
                                                              ),
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                quantity
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 18,
                                                                  color: white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                value
                                                                    .increaseQuantity(
                                                                        name,
                                                                        price);
                                                              },
                                                              child: const Icon(
                                                                Icons.add,
                                                                color: white,
                                                              ),
                                                            ),
                                                          ]),
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                const HomeView()));
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
                    Consumer<AddButtonProvider>(
                      builder: (context, value, _) {
                        return Container(
                          height: height * 0.2,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "SubTotal",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\u20B9 ${value.cartAmount}",
                                    style: const TextStyle(
                                        color: black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(MdiIcons.officeBuilding),
                                      const SizedBox(width: 5),
                                      const Text("GST"),
                                      const SizedBox(width: 5),
                                      Icon(MdiIcons.informationOutline,
                                          size: 16),
                                    ],
                                  ),
                                  const Text("₹ 25",
                                      style: TextStyle(
                                          color: green,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        "Grand Total",
                                        style: TextStyle(
                                            color: green,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "₹ ${value.cartAmount + 25}",
                                    style: const TextStyle(
                                        color: green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            height: 160,
            width: width,
            decoration: const BoxDecoration(
              color: white,
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Please login to place an order ",
                        style: TextStyle(
                          color: red,
                          fontSize: 18,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: red,
                        size: 15,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: green,
                            size: 18,
                          ),
                          Text(
                            "Delivery at : ",
                            style: TextStyle(
                                color: green,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                                color: green,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Change",
                          style: TextStyle(
                              color: green,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                Consumer<AddButtonProvider>(
                  builder: (context, value, child) {
                    return InkWell(
                      onTap: () async {
                        paymentIntent = await createPaymentIntent(
                            '${value.cartAmount + 25}', 'INR');
                        makePayment('${value.cartAmount + 25}', 'INR');
                      },
                      child: Container(
                        height: 60,
                        width: width * 0.90,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: green,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "\u20B9 ${value.cartAmount + 25}",
                                  style: const TextStyle(
                                      color: white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "Total",
                                  style: TextStyle(
                                    color: white,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                Text(
                                  "PAY NOW ",
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.play_arrow,
                                  size: 15,
                                  color: white,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void makePayment(String amount, String currency) async {
    try {
      paymentIntent = await createPaymentIntent(amount, currency);
      if (paymentIntent != null && paymentIntent!['client_secret'] != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            // applePay: const PaymentSheetApplePay(merchantCountryCode: 'IN'),
            googlePay: const PaymentSheetGooglePay(
              currencyCode: 'INR',
              merchantCountryCode: 'IN',
            ),
            style: ThemeMode.dark,
            merchantDisplayName: 'AMARJEET',
          ),
        );
        displayPaymentSheet();
      } else {
        DialogHelper.showSnackBar(
            strMsg: 'Invalid payment intent.', context: context);
      }
    } catch (e) {
      log('Error:-${e.toString()}');
      DialogHelper.showSnackBar(
          strMsg: 'Error while transaction: ${e.toString()}', context: context);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      setState(() {
        paymentIntent = null;
      });

      _processPayment();
    } on StripeException catch (e) {
      DialogHelper.showSnackBar(
          strMsg: 'Error while transaction: ${e.toString()}', context: context);
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> headers = {
        'Authorization':
            'Bearer sk_test_51NLkXBSFN73JriRHnkq8w0bnfOdaCAf1wB1zzZU19YFHDqiLD5APKk9ndwjeu9DOnLhEChMumGCwkP864RpBqL4H002NneUGyx',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: body,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        return json.decode(response.toString());
      }
    } catch (e) {
      DialogHelper.showSnackBar(
          strMsg: 'Error while creating payment intent: ${e.toString()}',
          context: context);
      log(e.toString());
      return null;
    }
    return null;
  }

  calculateAmount(String amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }

  void _processPayment() {
    Future.delayed(const Duration(seconds: 2), () async {
      setState(() {
        _isPaymentSuccessful = true;
      });

      _playSuccessSound();

      Future.delayed(const Duration(milliseconds: 100), () async {
        try {
          const String recipientId =
              'acct_1234567890abcdefghijklmnopqrstuvwxyz';
          const String recipientName = 'Amarjeet';

          final Map<String, dynamic> paymentData = {
            'payment': context.read<AddButtonProvider>().cartAmount + 25,
            'recipient_name': recipientName,
            'time': DateTime.now().toIso8601String(),
          };

          paymentData['recipient_id'] = recipientId;

          await fireStore
              .collection('User')
              .doc(firebaseAuth.currentUser!.uid)
              .collection('paymentHistory')
              .add(paymentData);

          setState(() {
            paymentIntent = null;
          });
        } catch (e) {
          DialogHelper.showSnackBar(
            strMsg: 'Error while storing data: ${e.toString()}',
            context: context,
          );
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SuccessfulPage()),
        );
      });
    });
  }

  Future<void> _playSuccessSound() async {
    final player = AudioPlayer();
    await player.setAsset('assets/sound.mp3');
    await player.play();
  }
}
