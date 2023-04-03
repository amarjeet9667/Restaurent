import 'package:flutter/material.dart';
import 'package:restaurent_test1/app/home/model/menu.dart';

import '../../common_colors/colors.dart';

// This is North Indian Tile.
class NorthIndian extends StatefulWidget {
  final List<FoodType> tabs;
  final List<String> name;
  final List<int> price;
  final List<FoodType> categories;

  const NorthIndian({
    super.key,
    required this.tabs,
    required this.name,
    required this.price,
    required this.categories,
  });

  @override
  State<NorthIndian> createState() => _NorthIndianState();
}

class _NorthIndianState extends State<NorthIndian> {
  bool hideTile = false;
  bool onTap = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          hideTile = !hideTile;
        });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "North Indian",
                    style: TextStyle(
                      color: green,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
              if (!hideTile)
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.name
                        .where((name) => widget.categories.any((category) =>
                            category.name.contains("North Indian") &&
                            category.items.any((item) => item.name == name)))
                        .length,
                    itemBuilder: (context, index) {
                      final northIndianNames = widget.name
                          .where((name) => widget.categories.any((category) =>
                              category.name.contains("North Indian") &&
                              category.items.any((item) => item.name == name)))
                          .toList();

                      return Column(
                        children: [
                          const Divider(
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    northIndianNames[index],
                                    style: const TextStyle(
                                        color: black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\u20B9 ${widget.price[index]}",
                                    style: const TextStyle(
                                      color: black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                    color: black,
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    onTap = !onTap;
                                  });
                                },
                                child: onTap
                                    ? Container(
                                        height: 40,
                                        width: 100,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: green,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                        ),
                                      )
                                    : Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: green.withOpacity(0.4),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Add",
                                            style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
            ],
          ),
        ),
      ),
    );
  }
}

// This is Punjabi Tile.
class Punjabi extends StatefulWidget {
  final List<String> name;
  final List<int> price;
  final List<FoodType> categories;
  final List<FoodType> tabs;

  const Punjabi({
    super.key,
    required this.tabs,
    required this.name,
    required this.price,
    required this.categories,
  });

  @override
  State<Punjabi> createState() => _PunjabiState();
}

class _PunjabiState extends State<Punjabi> {
  bool hideTile = false;
  bool onTap = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          hideTile = !hideTile;
        });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Punjabi",
                    style: TextStyle(
                      color: green,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
              if (!hideTile)
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.name
                        .where((name) => widget.categories.any((category) =>
                            category.name.contains("Punjabi") &&
                            category.items.any((item) => item.name == name)))
                        .length,
                    itemBuilder: (context, index) {
                      final punjabiName = widget.name
                          .where((name) => widget.categories.any((category) =>
                              category.name.contains("Punjabi") &&
                              category.items.any((item) => item.name == name)))
                          .toList();

                      return Column(
                        children: [
                          const Divider(
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(
                                    thickness: 1,
                                    color: black,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                  Text(
                                    punjabiName[index],
                                    style: const TextStyle(
                                        color: black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\u20B9 ${widget.price[index]}",
                                    style: const TextStyle(
                                      color: black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    onTap = !onTap;
                                  });
                                },
                                child: onTap
                                    ? Container(
                                        height: 40,
                                        width: 100,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: green,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                        ),
                                      )
                                    : Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: green.withOpacity(0.4),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Add",
                                            style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ],
                      );
                    })
            ],
          ),
        ),
      ),
    );
  }
}

// This is Chinese Tile.

class Chinese extends StatefulWidget {
  final List<String> name;
  final List<int> price;
  final List<FoodType> categories;
  final List<FoodType> tabs;

  const Chinese({
    super.key,
    required this.tabs,
    required this.name,
    required this.price,
    required this.categories,
  });

  @override
  State<Chinese> createState() => _ChineseState();
}

class _ChineseState extends State<Chinese> {
  bool hideTile = false;
  bool onTap = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          hideTile = !hideTile;
        });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Chinese",
                    style: TextStyle(
                      color: green,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
              if (!hideTile)
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.name
                        .where((name) => widget.categories.any((category) =>
                            category.name.contains("Chinese") &&
                            category.items.any((item) => item.name == name)))
                        .length,
                    itemBuilder: (context, index) {
                      final chineseName = widget.name
                          .where((name) => widget.categories.any((category) =>
                              category.name.contains("Chinese") &&
                              category.items.any((item) => item.name == name)))
                          .toList();

                      return Column(
                        children: [
                          const Divider(
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(
                                    thickness: 1,
                                    color: black,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                  Text(
                                    chineseName[index],
                                    style: const TextStyle(
                                        color: black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\u20B9 ${widget.price[index]}",
                                    style: const TextStyle(
                                      color: black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    onTap = !onTap;
                                  });
                                },
                                child: onTap
                                    ? Container(
                                        height: 40,
                                        width: 100,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: green,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                        ),
                                      )
                                    : Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: green.withOpacity(0.4),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Add",
                                            style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ],
                      );
                    })
            ],
          ),
        ),
      ),
    );
  }
}
// This is Continental Tile.

class Continental extends StatefulWidget {
  final List<String> name;
  final List<int> price;
  final List<FoodType> categories;
  final List<FoodType> tabs;

  const Continental({
    super.key,
    required this.tabs,
    required this.name,
    required this.price,
    required this.categories,
  });

  @override
  State<Continental> createState() => _ContinentalState();
}

class _ContinentalState extends State<Continental> {
  bool hideTile = false;
  bool onTap = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          hideTile = !hideTile;
        });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Continental",
                    style: TextStyle(
                      color: green,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
              if (!hideTile)
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.name
                        .where((name) => widget.categories.any((category) =>
                            category.name.contains("Continental") &&
                            category.items.any((item) => item.name == name)))
                        .length,
                    itemBuilder: (context, index) {
                      final continentalName = widget.name
                          .where((name) => widget.categories.any((category) =>
                              category.name.contains("Continental") &&
                              category.items.any((item) => item.name == name)))
                          .toList();

                      return Column(
                        children: [
                          const Divider(
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(
                                    thickness: 1,
                                    color: black,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                  Text(
                                    continentalName[index],
                                    style: const TextStyle(
                                        color: black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\u20B9 ${widget.price[index]}",
                                    style: const TextStyle(
                                      color: black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    onTap = !onTap;
                                  });
                                },
                                child: onTap
                                    ? Container(
                                        height: 40,
                                        width: 100,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: green,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                        ),
                                      )
                                    : Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: green.withOpacity(0.4),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Add",
                                            style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ],
                      );
                    })
            ],
          ),
        ),
      ),
    );
  }
}

class Mexican extends StatefulWidget {
  final List<String> name;
  final List<int> price;
  final List<FoodType> categories;
  final List<FoodType> tabs;

  const Mexican({
    super.key,
    required this.tabs,
    required this.name,
    required this.price,
    required this.categories,
  });

  @override
  State<Mexican> createState() => _MexicanState();
}

class _MexicanState extends State<Mexican> {
  bool hideTile = false;
  bool onTap = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          hideTile = !hideTile;
        });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Mexican",
                    style: TextStyle(
                      color: green,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
              if (!hideTile)
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.name
                        .where((name) => widget.categories.any((category) =>
                            category.name.contains("Mexican") &&
                            category.items.any((item) => item.name == name)))
                        .length,
                    itemBuilder: (context, index) {
                      final mexicanName = widget.name
                          .where((name) => widget.categories.any((category) =>
                              category.name.contains("Mexican") &&
                              category.items.any((item) => item.name == name)))
                          .toList();

                      return Column(
                        children: [
                          const Divider(
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mexicanName[index],
                                    style: const TextStyle(
                                        color: black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\u20B9 ${widget.price[index]}",
                                    style: const TextStyle(
                                      color: black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    onTap = !onTap;
                                  });
                                },
                                child: onTap
                                    ? Container(
                                        height: 40,
                                        width: 100,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: green,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                        ),
                                      )
                                    : Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: green.withOpacity(0.4),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Add",
                                            style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ],
                      );
                    })
            ],
          ),
        ),
      ),
    );
  }
}

class Mughlai extends StatefulWidget {
  final List<String> name;
  final List<int> price;
  final List<FoodType> categories;
  final List<FoodType> tabs;

  const Mughlai({
    super.key,
    required this.tabs,
    required this.name,
    required this.price,
    required this.categories,
  });

  @override
  State<Mughlai> createState() => _MughlaiState();
}

class _MughlaiState extends State<Mughlai> {
  bool hideTile = false;
  bool onTap = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          hideTile = !hideTile;
        });
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Mughlai",
                    style: TextStyle(
                      color: green,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
              if (!hideTile)
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.name
                        .where((name) => widget.categories.any((category) =>
                            category.name.contains("Mughlai") &&
                            category.items.any((item) => item.name == name)))
                        .length,
                    itemBuilder: (context, index) {
                      final mughlaiName = widget.name
                          .where((name) => widget.categories.any((category) =>
                              category.name.contains("Mughlai") &&
                              category.items.any((item) => item.name == name)))
                          .toList();

                      return Column(
                        children: [
                          const Divider(
                            thickness: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      mughlaiName[index],
                                      style: const TextStyle(
                                          color: black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "\u20B9 ${widget.price[index]}",
                                      style: const TextStyle(
                                        color: black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    onTap = !onTap;
                                  });
                                },
                                child: onTap
                                    ? Container(
                                        height: 40,
                                        width: 100,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: green,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                        ),
                                      )
                                    : Container(
                                        height: 40,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: green.withOpacity(0.4),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Add",
                                            style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
            ],
          ),
        ),
      ),
    );
  }
}
