import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_test1/app/util/colors.dart';
import 'package:restaurent_test1/app/view/component.dart';
import 'package:restaurent_test1/app/model/menu.dart';
import 'package:restaurent_test1/app/provider/addbutton_provider.dart';
import 'package:restaurent_test1/app/provider/bottom_provider.dart';
import 'package:restaurent_test1/app/view/screens/payment_slip_view.dart';
import 'package:restaurent_test1/app/view/widgets/bottom.dart';
import 'package:restaurent_test1/app/view/widgets/drawer.dart';
import 'package:restaurent_test1/app/view/widgets/flexiblespacebar.dart';
import 'package:restaurent_test1/app/view/widgets/title.dart';

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
  List<String> mealImage = [];
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

        final image = data["image"];
        mealImage.add(image);

        final price = data["price"];
        mealPrice.add(price);

        final inStock = data["instock"];
        mealInstock.add(inStock);

        return Menu(name: name, price: price, instock: inStock, image: image);
      }).toList();

      final foodType = FoodType(name: category.toString(), items: items);
      categories.add(foodType);
      categories1.add(foodType);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (_) => MyBottomState(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          drawer: CustomDrawer(height: height),
          body: Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                slivers: [
                  SliverAppBar(
                    backgroundColor: white,
                    expandedHeight: height * 0.3,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    collapsedHeight: kToolbarHeight + 35,
                    pinned: true,
                    title: const CustomTitle(),
                    flexibleSpace: const CustomFlexibleBar(),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(0),
                      child: MyBottom(
                        categories: categories,
                      ),
                    ),
                  ),
                  CustomSliverToBox(
                    tabs: categories1,
                    price: mealPrice,
                    name: mealName,
                    image: mealImage,
                    bools: mealInstock,
                  ),
                ],
              ),
              payNow()
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSliverToBox extends StatefulWidget {
  final List<FoodType> tabs;
  final List<String> name;
  final List<String> image;
  final List<int> price;
  final List<bool> bools;

  const CustomSliverToBox({
    super.key,
    required this.tabs,
    required this.price,
    required this.name,
    required this.image,
    required this.bools,
  });

  @override
  State<CustomSliverToBox> createState() => _CustomSliverToBoxState();
}

class _CustomSliverToBoxState extends State<CustomSliverToBox> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MyBottomState>(
        builder: (context, value, child) {
          // Checking currentIndex(or we can say selected index) is in range or tabs or not if yes then FoodType(eg: suppose currentIndex == 4 then checks with widget.tabs.length if it is in rane of tabs then print foodtypes )
          //When currentIndex==0 or you can say currentIndex (< 0) is lesser than zero then (:) else condition passes (:widget.tabs.map((tab)=>FoodType(name:tab.name,items:tab.items)).toList())
          final categories = value.currentIndex >= 1 &&
                  value.currentIndex <= widget.tabs.length
              ? [
                  FoodType(
                      name: widget.tabs[value.currentIndex - 1].name,
                      items: widget.tabs[value.currentIndex - 1].items)
                ]
              : widget.tabs
                  .map(
                    (tab) => FoodType(name: tab.name, items: tab.items),
                  )
                  .toList();
          return Column(
            children: [
              CombineCategory(
                tabs: categories,
                name: widget.name,
                price: widget.price,
                image: widget.image,
                bools: widget.bools,
              ),
            ],
          );
        },
      ),
    );
  }
}

Consumer<AddButtonProvider> payNow() {
  return Consumer(
    builder: (context, value, _) => Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(height: 10),
        Card(
          margin: const EdgeInsets.only(top: 10),
          elevation: 40,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.bounceOut,
            child: !(value.cartAmount > 0)
                ? const Text("")
                : Container(
                    height: 60,
                    width: 340,
                    margin: EdgeInsets.symmetric(
                      horizontal: 15 + MediaQuery.of(context).viewInsets.bottom,
                      vertical: 12.5,
                    ),
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: green.withOpacity(1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                " ${value.cart.length} ITEMS",
                                style: const TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                "\u20B9 ${value.cartAmount} plus taxes",
                                style: const TextStyle(color: white),
                              )
                            ],
                          ),
                        ),
                        TextButton(
                          style: const ButtonStyle(
                            overlayColor: MaterialStatePropertyAll(trans),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const PaymentView()));
                          },
                          child: Row(
                            children: const [
                              Text(
                                "PAY NOW",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                  color: white,
                                ),
                              ),
                              SizedBox(width: 2.5),
                              Icon(
                                Icons.play_arrow,
                                color: white,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    ),
  );
}
