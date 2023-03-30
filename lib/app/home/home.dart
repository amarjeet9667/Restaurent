import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurent_test1/app/common_colors/colors.dart';
import 'package:restaurent_test1/app/home/model/menu.dart';

import '../../common_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<FoodType> categories = [FoodType(name: "All Categories", items: [])];
  List<FoodType> categories1 = [];
  List<String> mealName = [];
  List<int> mealPrice = [];
  List<bool> mealInstock = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    final jsonMenu = await rootBundle.loadString("assets/menu.json");
    Map<String, dynamic> data = jsonDecode(jsonMenu);

    for (final category in data.keys) {
      final itemData = data[category];

      final items = itemData.map((data) {
        final name = data["name"];
        mealName.add(name);

        final price = data["price"];
        mealPrice.add(price);

        final inStock = data["instock"];
        mealInstock.add(inStock);

        return Menu(name: name, price: price, instock: inStock);
      }).toList();

      final foodType = FoodType(name: category.toString(), items: items);
      categories.add(foodType);
      categories1.add(foodType);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            backgroundColor: white,
            automaticallyImplyLeading: false,
            elevation: 0,
            expandedHeight: 260,
            pinned: true,
            title: const CustomTitle(),
            flexibleSpace: const CustomFlexibleBar(),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: MyBottom(tabs: categories),
            ),
          ),
          CustomSliverToBox(
              tabs: categories1, price: mealPrice, name: mealName),
        ],
      ),
    );
  }
}

class CustomSliverToBox extends StatefulWidget {
  final List<FoodType> tabs;
  final List<String> name;
  final List<int> price;
  const CustomSliverToBox(
      {super.key, required this.tabs, required this.price, required this.name});

  @override
  State<CustomSliverToBox> createState() => _CustomSliverToBoxState();
}

class _CustomSliverToBoxState extends State<CustomSliverToBox> {
  bool isChange = true;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 90),
          itemCount: widget.tabs.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: const Divider(
                      thickness: 2,
                    ),
                  ),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.tabs[index].name,
                          style: const TextStyle(
                            color: black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.name[index],
                              style: const TextStyle(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isChange = !false;
                                });
                                showBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 20),
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    green),
                                            fixedSize:
                                                MaterialStateProperty.all(
                                              Size(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                50,
                                              ),
                                            ),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: const [
                                              Text(
                                                "Item ",
                                                style: TextStyle(
                                                    color: white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "Pay Now",
                                                style: TextStyle(
                                                  color: white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                height: 42,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: green.withOpacity(0.5),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Add",
                                    style: TextStyle(color: white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          "mealPrice",
                          style: TextStyle(
                            color: black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

// ListTile(
//                     leading: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.tabs[index].name,
//                           style: const TextStyle(
//                             color: black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           '\u20B9 ${widget.price[index]}',
//                           style: const TextStyle(
//                             color: black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     trailing: GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             isChange = !false;
//                           });
//                           showBottomSheet(
//                               context: context,
//                               builder: (context) {
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 40, vertical: 20),
//                                   child: ElevatedButton(
//                                     onPressed: () {},
//                                     style: ButtonStyle(
//                                       backgroundColor:
//                                           MaterialStateProperty.all(green),
//                                       fixedSize: MaterialStateProperty.all(
//                                         Size(
//                                           MediaQuery.of(context).size.width *
//                                               0.8,
//                                           50,
//                                         ),
//                                       ),
//                                       shape: MaterialStateProperty.all(
//                                         RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(20),
//                                         ),
//                                       ),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: const [
//                                         Text(
//                                           "Item ",
//                                           style: TextStyle(
//                                               color: white,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                           "Pay Now",
//                                           style: TextStyle(
//                                             color: white,
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               });
//                         },
//                         child: Container(
//                           height: 40,
//                           width: 100,
//                           foregroundDecoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(7),
//                               color: green.withOpacity(0.2)),
//                           child: const Center(
//                             child: Text(
//                               "Add",
//                               style: TextStyle(
//                                 color: green,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                         ),
//                   ),