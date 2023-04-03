import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_test1/app/common_colors/colors.dart';
import 'package:restaurent_test1/app/home/component/component.dart';
import 'package:restaurent_test1/app/home/model/menu.dart';
import 'package:restaurent_test1/app/home/provider/bottom_provider.dart';

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
    return ChangeNotifierProvider(
      create: (_) => MyBottomState(),
      child: Scaffold(
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
                child: MyBottom(
                    price: mealPrice, name: mealName, categories: categories),
              ),
            ),
            CustomSliverToBox(
                tabs: categories1,
                price: mealPrice,
                name: mealName,
                categories: categories),
          ],
        ),
      ),
    );
  }
}

class CustomSliverToBox extends StatefulWidget {
  final List<FoodType> tabs;
  final List<String> name;
  final List<int> price;
  final List<FoodType> categories;
  const CustomSliverToBox(
      {super.key,
      required this.tabs,
      required this.price,
      required this.name,
      required this.categories});

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
            ),
          if (currentIndex == 0 || currentIndex == 2)
            Punjabi(
              tabs: widget.tabs,
              name: widget.name,
              price: widget.price,
              categories: widget.categories,
            ),
          if (currentIndex == 0 || currentIndex == 3)
            Chinese(
              tabs: widget.tabs,
              name: widget.name,
              price: widget.price,
              categories: widget.categories,
            ),
          if (currentIndex == 0 || currentIndex == 4)
            Continental(
              tabs: widget.tabs,
              name: widget.name,
              price: widget.price,
              categories: widget.categories,
            ),
          if (currentIndex == 0 || currentIndex == 5)
            Mexican(
              tabs: widget.tabs,
              name: widget.name,
              price: widget.price,
              categories: widget.categories,
            ),
          if (currentIndex == 0 || currentIndex == 6)
            Mughlai(
              tabs: widget.tabs,
              name: widget.name,
              price: widget.price,
              categories: widget.categories,
            ),
        ],
      ),
    );
  }
}
