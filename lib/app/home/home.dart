import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_test1/app/common_colors/colors.dart';
import 'package:restaurent_test1/app/home/provider/provider.dart';

import '../../common_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> tabList = ["All Category"];
  late String firstTab;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    firstTab = tabList.first;
    final jsonMenu = await rootBundle.loadString("assets/menu.json");
    Map<String, dynamic> data = jsonDecode(jsonMenu);

    for (int i = 0; i < data.length; i++) {
      String sTablist = data.keys.elementAt(i);
      tabList.add(sTablist);
      setState(() {});
    }
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
              child: MyBottom(tabs: tabList),
            ),
          ),
          const CustomSliverToBox(),
        ],
      ),
    );
  }
}

// void fetchData() async {
//   final jsonData = await rootBundle.loadString("assets/menu.json");
//   Map<String, dynamic> data = jsonDecode(jsonData);

//   // final name = data['name'];
//   // final itemData = data['item'];
//   final name = data.containsKey('name') ? data['name'] : "";
//   final itemData = data.containsKey('item') ? data['item'] : [];

//   final item = itemData.map((data) {
//     final name = data['name'];
//     final price = data['price'];
//     final instock = data['instock'];
//     return Menu(name: name, price: price, instock: instock);
//   }).toList();

//   final restaurent = FoodTypes(name: name, item: item);
// }

class CustomSliverToBox extends StatefulWidget {
  const CustomSliverToBox({
    super.key,
  });

  @override
  State<CustomSliverToBox> createState() => _CustomSliverToBoxState();
}

class _CustomSliverToBoxState extends State<CustomSliverToBox> {
  bool tap = true;
  int increase = 1;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 90),
          itemCount: 30,
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
                      thickness: 1,
                    ),
                  ),
                  ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "North Indian",
                          style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          '\u20B9 100',
                          style: TextStyle(
                            color: black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        setState(() {
                          tap = false;
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
                                        MaterialStateProperty.all(green),
                                    fixedSize: MaterialStateProperty.all(
                                      Size(
                                        MediaQuery.of(context).size.width * 0.8,
                                        50,
                                      ),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ChangeNotifierProvider(
                                        create: (context) => HomeProvider(),
                                        child: Consumer<HomeProvider>(
                                          builder: (context, provider, child) {
                                            return Text(
                                              "Item $increase",
                                              style: const TextStyle(
                                                  color: white,
                                                  fontWeight: FontWeight.bold),
                                            );
                                          },
                                        ),
                                      ),
                                      const Text(
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
                      child: tap
                          ? Container(
                              height: 40,
                              width: 100,
                              foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: green.withOpacity(0.2)),
                              child: const Center(
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    color: green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: 40,
                              width: 100,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: green),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ChangeNotifierProvider(
                                    create: (context) => HomeProvider(),
                                    child: Consumer<HomeProvider>(
                                      builder: (context, provider, child) {
                                        return InkWell(
                                          onTap: () {
                                            provider.itemIncreses();
                                          },
                                          child: const Icon(
                                            Icons.remove,
                                            color: white,
                                            size: 18,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {},
                                      child: const Icon(
                                        Icons.add,
                                        color: white,
                                        size: 18,
                                      )),
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
