import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_test1/app/provider/addbutton_provider.dart';
import 'package:restaurent_test1/app/util/colors.dart';
import 'package:restaurent_test1/app/model/menu.dart';

class CombineCategory extends StatefulWidget {
  final List<FoodType> tabs;
  final List<String> name;
  final List<int> price;
  final List<String> image;
  final List<bool> bools;

  const CombineCategory({
    super.key,
    required this.tabs,
    required this.name,
    required this.price,
    required this.image,
    required this.bools,
  });

  @override
  State<CombineCategory> createState() => _CombineCategoryState();
}

class _CombineCategoryState extends State<CombineCategory> {
  List<int> list = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<AddButtonProvider>(
          builder: (context, value, _) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.tabs.length,
              itemBuilder: (context, index) {
                final category = widget.tabs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => setState(() {
                          if (list.contains(index)) {
                            list.remove(index);
                          } else {
                            list.add(index);
                          }
                        }),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 60,
                              child: Center(
                                child: Text(
                                  category.name,
                                  style: const TextStyle(
                                    color: green,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            !list.contains(index)
                                ? const Icon(Icons.arrow_drop_down)
                                : const Icon(
                                    Icons.play_arrow,
                                    size: 12,
                                  )
                          ],
                        ),
                      ),
                      !list.contains(index)
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: category.items.length,
                              itemBuilder: (context, innerIndex) {
                                final item = category.items[innerIndex];
                                Map<String, int> quantities = value.quantity;
                                late int quantity;

                                //1st mistake were passed name eg(if (quantities.containsKey(widget.name)) Remind my mistake

                                if (quantities.containsKey(item.name)) {
                                  quantity = quantities[item.name]!;
                                } else {
                                  quantity = 0;
                                }

                                return Column(
                                  children: [
                                    const Divider(
                                      thickness: 1,
                                    ),
                                    Container(
                                      height: 60,
                                      decoration: const BoxDecoration(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 10),
                                              !widget.bools[innerIndex]
                                                  ? const Text(
                                                      "* Out of Stock",
                                                      style: TextStyle(
                                                          color: red,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  : Text(
                                                      "₹ ${item.price}",
                                                      style: const TextStyle(
                                                          color: black,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (quantity == 0 &&
                                                  widget.bools[innerIndex]) {
                                                setState(() => quantity++);

                                                Provider.of<AddButtonProvider>(
                                                        context,
                                                        listen: false)
                                                    .addItem(
                                                  item.name,
                                                  //2nd mistake we were passed quantity here thata why payNow() shows quantity accept price
                                                  item.price,
                                                );
                                              }
                                              log(quantity.toString());
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 100,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: quantity == 0
                                                      ? green.withOpacity(0.12)
                                                      : green),
                                              child: quantity == 0
                                                  ? const Center(
                                                      child: Text(
                                                        "ADD",
                                                        style: TextStyle(
                                                            color: green,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )
                                                  : Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            if (quantity > 1) {
                                                              setState(() =>
                                                                  quantity--);

                                                              Provider.of<
                                                                  AddButtonProvider>(
                                                                context,
                                                                listen: false,
                                                              ).decreaseQuantity(
                                                                item.name,
                                                                item.price,
                                                              );
                                                            } else {
                                                              setState(() =>
                                                                  quantity = 0);
                                                              Provider.of<
                                                                  AddButtonProvider>(
                                                                context,
                                                                listen: false,
                                                              ).removeItem(
                                                                item.name,
                                                                //3rd mistake we were pass here same thing quntity thats why when user click on minus button its minus  price until all price get 0 and quantity remains .
                                                                item.price,
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
                                                            "$quantity",
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
                                                            setState(() =>
                                                                quantity++);
                                                            Provider.of<
                                                                AddButtonProvider>(
                                                              context,
                                                              listen: false,
                                                            ).increaseQuantity(
                                                              item.name,
                                                              item.price,
                                                            );
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : Container(),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          },
        ),
        const SizedBox(
          height: 90,
        ),
      ],
    );
  }
}
