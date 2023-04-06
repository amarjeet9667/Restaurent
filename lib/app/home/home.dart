import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_test1/app/common_colors/colors.dart';
import 'package:restaurent_test1/app/home/component/component.dart';
import 'package:restaurent_test1/app/home/model/menu.dart';
import 'package:restaurent_test1/app/home/provider/addbutton_provider.dart';
import 'package:restaurent_test1/app/home/provider/bottom_provider.dart';
import 'package:restaurent_test1/app/payment_screen/pament_view.dart';

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
    return ChangeNotifierProvider(
      create: (_) => MyBottomState(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                slivers: [
                  SliverAppBar(
                    backgroundColor: white,
                    expandedHeight: 250,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    collapsedHeight: kToolbarHeight + 50,
                    pinned: true,
                    title: const CustomTitle(),
                    flexibleSpace: const CustomFlexibleBar(),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(0),
                      child: MyBottom(
                        price: mealPrice,
                        name: mealName,
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
                    categories: categories,
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
  final List<FoodType> categories;
  const CustomSliverToBox({
    super.key,
    required this.tabs,
    required this.price,
    required this.name,
    required this.categories,
    required this.image,
    required this.bools,
  });

  @override
  State<CustomSliverToBox> createState() => _CustomSliverToBoxState();
}

class _CustomSliverToBoxState extends State<CustomSliverToBox> {
  @override
  Widget build(BuildContext context) {
    final currentIndexProvider = Provider.of<MyBottomState>(context);
    final currentIndex = currentIndexProvider.currentIndex;

    return SliverToBoxAdapter(
      child: Column(
        children: [
          if (currentIndex == 0 || currentIndex == 1)
            NorthIndian(
              tabs: widget.tabs,
              name: widget.name,
              price: widget.price,
              categories: widget.categories,
              image: widget.image,
              bools: widget.bools,
            ),
          if (currentIndex == 0 || currentIndex == 2)
            Punjabi(
              tabs: widget.tabs,
              name: widget.name,
              price: widget.price,
              categories: widget.categories,
              bools: widget.bools,
              image: widget.image,
            ),
          if (currentIndex == 0 || currentIndex == 3)
            Chinese(
              tabs: widget.tabs,
              name: widget.name,
              price: widget.price,
              categories: widget.categories,
              bools: widget.bools,
              image: widget.image,
            ),
          if (currentIndex == 0 || currentIndex == 4)
            Continental(
              tabs: widget.tabs,
              name: widget.name,
              price: widget.price,
              categories: widget.categories,
              bools: widget.bools,
              image: widget.image,
            ),
          if (currentIndex == 0 || currentIndex == 5)
            Mexican(
              tabs: widget.tabs,
              name: widget.name,
              price: widget.price,
              categories: widget.categories,
              bools: widget.bools,
              image: widget.image,
            ),
          if (currentIndex == 0 || currentIndex == 6)
            Mughlai(
              tabs: widget.tabs,
              name: widget.name,
              price: widget.price,
              categories: widget.categories,
              bools: widget.bools,
              image: widget.image,
            ),
        ],
      ),
    );
  }
}

Consumer<AddButtonProvider> payNow() {
  return Consumer(
    builder: (context, value, _) => Card(
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
                            "${value.cart.length} ITEM",
                            style: const TextStyle(
                              color: white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              letterSpacing: 2,
                            ),
                          ),
                          Text(
                            "\u20B9 ${value.cartAmount}  plus taxes",
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
  );
}
