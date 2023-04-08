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
  final List<FoodType> categories;
  const CombineCategory({
    super.key,
    required this.tabs,
    required this.name,
    required this.price,
    required this.image,
    required this.bools,
    required this.categories,
  });

  @override
  State<CombineCategory> createState() => _CombineCategoryState();
}

class _CombineCategoryState extends State<CombineCategory> {
  bool hideTile = false;
  bool onChange = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AddButtonProvider>(
      builder: (context, value, child) {
        Map<String, int> quantities = value.quantity;
        late int quantity;
        if (quantities.containsKey(widget.name)) {
          quantity = quantities[widget.name]!;
        } else {
          quantity = 0;
        }
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                        child: Text(
                          category.name,
                          style: const TextStyle(
                            color: green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: category.items.length,
                      itemBuilder: (context, index) {
                        final item = category.items[index];
                        return Column(
                          children: [
                            const Divider(),
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
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      !widget.bools[index]
                                          ? const Text(
                                              "* Out of Stock",
                                              style: TextStyle(
                                                  color: red,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              "₹ ${item.price}",
                                              style: const TextStyle(
                                                  color: black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (quantity == 0 &&
                                            widget.bools[index]) {
                                          setState(() => quantity++);
                                          Provider.of<AddButtonProvider>(
                                                  context,
                                                  listen: false)
                                              .addItem(widget.name[index],
                                                  widget.price[index]);
                                        }
                                        onChange = !onChange;
                                      });
                                    },
                                    child: Container(
                                        height: 40,
                                        width: 100,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: !onChange
                                              ? green.withOpacity(0.12)
                                              : green,
                                        ),
                                        child: quantity == 0
                                            ? const Center(
                                                child: Text(
                                                  "ADD",
                                                  style: TextStyle(
                                                      color: green,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {},
                                                    child: const Icon(
                                                      Icons.remove,
                                                      color: white,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: const Icon(
                                                      Icons.add,
                                                      color: white,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        );
      },
    );
  }
}

// SizedBox(
//       height: 600,
//       child: ListView.separated(
//         itemBuilder: (context, index) {
//           final category = widget.categories[index];

//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   category.name,
//                   style: const TextStyle(
//                       fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const ClampingScrollPhysics(),
//                 itemCount: category.items.length,
//                 itemBuilder: (context, index) {
//                   final item = category.items[index];

//                   return ListTile(
//                     title: Text(item.name),
//                     trailing: Text("\$${item.price}"),
//                   );
//                 },
//               ),
//             ],
//           );
//         },
//         separatorBuilder: (context, index) => const Divider(),
//         itemCount: widget.categories.length,
//       ),
//     );