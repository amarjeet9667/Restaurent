import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_test1/app/provider/addbutton_provider.dart';
import 'package:restaurent_test1/app/helper/constants.dart';
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
                      child: Row(
                        children: const [
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
                                    children: const [
                                      Icon(MdiIcons.officeBuilding),
                                      SizedBox(width: 5),
                                      Text("GST"),
                                      SizedBox(width: 5),
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
                                  Row(
                                    children: const [
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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
                      Row(
                        children: const [
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
                    return Container(
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
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "PAY NOW ",
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Icon(
                                Icons.play_arrow,
                                size: 15,
                                color: white,
                              )
                            ],
                          ),
                        ],
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
}
