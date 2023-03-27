import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurent_test1/app/common_colors/colors.dart';

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
    log(data.toString());

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

class CustomSliverToBox extends StatelessWidget {
  const CustomSliverToBox({
    super.key,
  });

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
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: white,
                    border: Border.all(color: black)),
                child: ListTile(
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
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 90,
                      foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: green.withOpacity(0.5)),
                      child: const Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                            color: green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
