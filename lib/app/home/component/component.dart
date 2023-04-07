import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_test1/app/home/model/menu.dart';
import 'package:restaurent_test1/app/home/provider/addbutton_provider.dart';

import '../../common_colors/colors.dart';

// This is North Indian Tile.
class NorthIndian extends StatefulWidget {
  final List<FoodType> tabs;
  final List<String> name;
  final List<int> price;
  final List<String> image;
  final List<bool> bools;
  final List<FoodType> categories;

  const NorthIndian({
    super.key,
    required this.tabs,
    required this.name,
    required this.price,
    required this.categories,
    required this.image,
    required this.bools,
  });

  @override
  State<NorthIndian> createState() => _NorthIndianState();
}

class _NorthIndianState extends State<NorthIndian> {
  bool hideTile = false;
  bool onTap = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        setState(() {
          hideTile = !hideTile;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "North Indian",
                    style: TextStyle(
                      color: green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  !hideTile
                      ? const Icon(Icons.arrow_drop_down)
                      : const Icon(Icons.play_arrow, size: 15),
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
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  widget.bools[index]
                                      ? Text(
                                          "\u20B9 ${widget.price[index]}",
                                          style: const TextStyle(
                                            color: black,
                                            fontSize: 15,
                                          ),
                                        )
                                      : const Text(
                                          "*Out of stock",
                                          style: TextStyle(color: red),
                                        ),
                                  const Divider(
                                    thickness: 2,
                                    color: black,
                                  ),
                                ],
                              ),
                              Consumer<AddButtonProvider>(
                                  builder: (context, value, _) {
                                Map<String, int> quantities = value.quantity;
                                late int quantity;
                                if (quantities
                                    .containsKey(northIndianNames[index])) {
                                  quantity =
                                      quantities[northIndianNames[index]]!;
                                } else {
                                  quantity = 0;
                                }
                                return InkWell(
                                  onTap: () {
                                    if (quantity == 0 && widget.bools[index]) {
                                      setState(() => quantity++);
                                      Provider.of<AddButtonProvider>(context,
                                              listen: false)
                                          .addItem(northIndianNames[index],
                                              widget.price[index]);
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: quantity == 0
                                          ? green.withOpacity(0.15)
                                          : green,
                                    ),
                                    child: quantity == 0
                                        ? const Center(
                                            child: Text(
                                              "ADD",
                                              style: TextStyle(
                                                color: green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (quantity > 1) {
                                                    setState(() {
                                                      quantity--;
                                                    });
                                                    Provider.of<AddButtonProvider>(
                                                            context,
                                                            listen: false)
                                                        .decreaseQuantity(
                                                            northIndianNames[
                                                                index],
                                                            widget
                                                                .price[index]);
                                                  } else {
                                                    setState(() {
                                                      quantity == 0;
                                                    });
                                                    Provider.of<AddButtonProvider>(
                                                            context,
                                                            listen: false)
                                                        .removeItem(
                                                            northIndianNames[
                                                                index],
                                                            widget
                                                                .price[index]);
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: white,
                                                ),
                                              ),
                                              Text(
                                                "$quantity",
                                                style: const TextStyle(
                                                    color: white),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    quantity++;
                                                  });
                                                  Provider.of<AddButtonProvider>(
                                                          context,
                                                          listen: false)
                                                      .increaseQuantity(
                                                          northIndianNames[
                                                              index],
                                                          widget.price[index]);
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: white,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                );
                              })
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
  final List<FoodType> tabs;
  final List<String> name;
  final List<int> price;
  final List<String> image;
  final List<bool> bools;
  final List<FoodType> categories;

  const Punjabi({
    super.key,
    required this.tabs,
    required this.name,
    required this.price,
    required this.categories,
    required this.image,
    required this.bools,
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
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Punjabi",
                    style: TextStyle(
                      color: green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  !hideTile
                      ? const Icon(Icons.arrow_drop_down)
                      : const Icon(
                          Icons.play_arrow,
                          size: 15,
                        )
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
                                    textAlign: TextAlign.justify,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  widget.bools[index]
                                      ? Text(
                                          "\u20B9 ${widget.price[index]}",
                                          style: const TextStyle(
                                            color: black,
                                            fontSize: 15,
                                          ),
                                        )
                                      : const Text(
                                          "*Out of stock",
                                          style: TextStyle(color: red),
                                        ),
                                ],
                              ),
                              Consumer<AddButtonProvider>(
                                  builder: (context, value, _) {
                                Map<String, int> quantities = value.quantity;
                                late int quantity;
                                if (quantities
                                    .containsKey(punjabiName[index])) {
                                  quantity = quantities[punjabiName[index]]!;
                                } else {
                                  quantity = 0;
                                }
                                return InkWell(
                                  onTap: () {
                                    if (quantity == 0 && widget.bools[index]) {
                                      setState(() => quantity++);
                                      Provider.of<AddButtonProvider>(context,
                                              listen: false)
                                          .addItem(punjabiName[index],
                                              widget.price[index]);
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: quantity == 0
                                          ? green.withOpacity(0.15)
                                          : green,
                                    ),
                                    child: quantity == 0
                                        ? const Center(
                                            child: Text(
                                              "ADD",
                                              style: TextStyle(
                                                color: green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (quantity > 1) {
                                                    setState(() {
                                                      quantity--;
                                                    });
                                                    Provider.of<AddButtonProvider>(
                                                            context,
                                                            listen: false)
                                                        .decreaseQuantity(
                                                            punjabiName[index],
                                                            widget
                                                                .price[index]);
                                                  } else {
                                                    setState(() {
                                                      quantity == 0;
                                                    });
                                                    Provider.of<AddButtonProvider>(
                                                            context,
                                                            listen: false)
                                                        .removeItem(
                                                            punjabiName[index],
                                                            widget
                                                                .price[index]);
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: white,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    quantity++;
                                                  });
                                                  Provider.of<AddButtonProvider>(
                                                          context,
                                                          listen: false)
                                                      .increaseQuantity(
                                                          punjabiName[index],
                                                          widget.price[index]);
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: white,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                );
                              })
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
  final List<FoodType> tabs;
  final List<String> name;
  final List<int> price;
  final List<String> image;
  final List<bool> bools;
  final List<FoodType> categories;

  const Chinese({
    super.key,
    required this.tabs,
    required this.name,
    required this.price,
    required this.categories,
    required this.image,
    required this.bools,
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
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Chinese",
                    style: TextStyle(
                      color: green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  !hideTile
                      ? const Icon(Icons.arrow_drop_down)
                      : const Icon(
                          Icons.play_arrow,
                          size: 15,
                        )
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
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  widget.bools[index]
                                      ? Text(
                                          "\u20B9 ${widget.price[index]}",
                                          style: const TextStyle(
                                            color: black,
                                            fontSize: 15,
                                          ),
                                        )
                                      : const Text(
                                          "*Out of stock",
                                          style: TextStyle(color: red),
                                        ),
                                ],
                              ),
                              Consumer<AddButtonProvider>(
                                  builder: (context, value, _) {
                                Map<String, int> quantities = value.quantity;
                                late int quantity;
                                if (quantities
                                    .containsKey(chineseName[index])) {
                                  quantity = quantities[chineseName[index]]!;
                                } else {
                                  quantity = 0;
                                }
                                return InkWell(
                                  onTap: () {
                                    if (quantity == 0 && widget.bools[index]) {
                                      setState(() => quantity++);
                                      Provider.of<AddButtonProvider>(context,
                                              listen: false)
                                          .addItem(chineseName[index],
                                              widget.price[index]);
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: quantity == 0
                                          ? green.withOpacity(0.15)
                                          : green,
                                    ),
                                    child: quantity == 0
                                        ? const Center(
                                            child: Text(
                                              "ADD",
                                              style: TextStyle(
                                                color: green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (quantity > 1) {
                                                    setState(() {
                                                      quantity--;
                                                    });
                                                    Provider.of<AddButtonProvider>(
                                                            context,
                                                            listen: false)
                                                        .decreaseQuantity(
                                                            chineseName[index],
                                                            widget
                                                                .price[index]);
                                                  } else {
                                                    setState(() {
                                                      quantity == 0;
                                                    });
                                                    Provider.of<AddButtonProvider>(
                                                            context,
                                                            listen: false)
                                                        .removeItem(
                                                            chineseName[index],
                                                            widget
                                                                .price[index]);
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: white,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    quantity++;
                                                  });
                                                  Provider.of<AddButtonProvider>(
                                                          context,
                                                          listen: false)
                                                      .increaseQuantity(
                                                          chineseName[index],
                                                          widget.price[index]);
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: white,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                );
                              })
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
  final List<FoodType> tabs;
  final List<String> name;
  final List<int> price;
  final List<String> image;
  final List<bool> bools;
  final List<FoodType> categories;

  const Continental({
    super.key,
    required this.tabs,
    required this.name,
    required this.price,
    required this.categories,
    required this.image,
    required this.bools,
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
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Continental",
                    style: TextStyle(
                      color: green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  !hideTile
                      ? const Icon(Icons.arrow_drop_down)
                      : const Icon(
                          Icons.play_arrow,
                          size: 15,
                        )
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
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  widget.bools[index]
                                      ? Text(
                                          "\u20B9 ${widget.price[index]}",
                                          style: const TextStyle(
                                            color: black,
                                            fontSize: 15,
                                          ),
                                        )
                                      : const Text(
                                          "*Out of stock",
                                          style: TextStyle(color: red),
                                        ),
                                ],
                              ),
                              Consumer<AddButtonProvider>(
                                  builder: (context, value, _) {
                                Map<String, int> quantities = value.quantity;
                                late int quantity;
                                if (quantities
                                    .containsKey(continentalName[index])) {
                                  quantity =
                                      quantities[continentalName[index]]!;
                                } else {
                                  quantity = 0;
                                }
                                return InkWell(
                                  onTap: () {
                                    if (quantity == 0 && widget.bools[index]) {
                                      setState(() => quantity++);
                                      Provider.of<AddButtonProvider>(context,
                                              listen: false)
                                          .addItem(continentalName[index],
                                              widget.price[index]);
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: quantity == 0
                                          ? green.withOpacity(0.15)
                                          : green,
                                    ),
                                    child: quantity == 0
                                        ? const Center(
                                            child: Text(
                                              "ADD",
                                              style: TextStyle(
                                                color: green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (quantity > 1) {
                                                    setState(() {
                                                      quantity--;
                                                    });
                                                    Provider.of<AddButtonProvider>(
                                                            context,
                                                            listen: false)
                                                        .decreaseQuantity(
                                                            continentalName[
                                                                index],
                                                            widget
                                                                .price[index]);
                                                  } else {
                                                    setState(() {
                                                      quantity == 0;
                                                    });
                                                    Provider.of<AddButtonProvider>(
                                                            context,
                                                            listen: false)
                                                        .removeItem(
                                                            continentalName[
                                                                index],
                                                            widget
                                                                .price[index]);
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: white,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    quantity++;
                                                  });
                                                  Provider.of<AddButtonProvider>(
                                                          context,
                                                          listen: false)
                                                      .increaseQuantity(
                                                          continentalName[
                                                              index],
                                                          widget.price[index]);
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: white,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                );
                              })
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
  final List<FoodType> tabs;
  final List<String> name;
  final List<int> price;
  final List<String> image;
  final List<bool> bools;
  final List<FoodType> categories;

  const Mexican({
    super.key,
    required this.tabs,
    required this.name,
    required this.price,
    required this.categories,
    required this.image,
    required this.bools,
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
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Mexican",
                    style: TextStyle(
                      color: green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  !hideTile
                      ? const Icon(Icons.arrow_drop_down)
                      : const Icon(
                          Icons.play_arrow,
                          size: 15,
                        )
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
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  widget.bools[index]
                                      ? Text(
                                          "\u20B9 ${widget.price[index]}",
                                          style: const TextStyle(
                                            color: black,
                                            fontSize: 15,
                                          ),
                                        )
                                      : const Text(
                                          "*Out of stock",
                                          style: TextStyle(color: red),
                                        ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                ],
                              ),
                              Consumer<AddButtonProvider>(
                                  builder: (context, value, _) {
                                Map<String, int> quantities = value.quantity;
                                late int quantity;
                                if (quantities
                                    .containsKey(mexicanName[index])) {
                                  quantity = quantities[mexicanName[index]]!;
                                } else {
                                  quantity = 0;
                                }
                                return InkWell(
                                  onTap: () {
                                    if (quantity == 0 && widget.bools[index]) {
                                      setState(() => quantity++);
                                      Provider.of<AddButtonProvider>(context,
                                              listen: false)
                                          .addItem(mexicanName[index],
                                              widget.price[index]);
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: quantity == 0
                                          ? green.withOpacity(0.15)
                                          : green,
                                    ),
                                    child: quantity == 0
                                        ? const Center(
                                            child: Text(
                                              "ADD",
                                              style: TextStyle(
                                                color: green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (quantity > 1) {
                                                    setState(() {
                                                      quantity--;
                                                    });
                                                    Provider.of<AddButtonProvider>(
                                                            context,
                                                            listen: false)
                                                        .decreaseQuantity(
                                                            mexicanName[index],
                                                            widget
                                                                .price[index]);
                                                  } else {
                                                    setState(() {
                                                      quantity == 0;
                                                    });
                                                    Provider.of<AddButtonProvider>(
                                                            context,
                                                            listen: false)
                                                        .removeItem(
                                                            mexicanName[index],
                                                            widget
                                                                .price[index]);
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: white,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    quantity++;
                                                  });
                                                  Provider.of<AddButtonProvider>(
                                                          context,
                                                          listen: false)
                                                      .increaseQuantity(
                                                          mexicanName[index],
                                                          widget.price[index]);
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: white,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                );
                              })
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
  final List<FoodType> tabs;
  final List<String> name;
  final List<int> price;
  final List<String> image;
  final List<bool> bools;
  final List<FoodType> categories;

  const Mughlai({
    super.key,
    required this.tabs,
    required this.name,
    required this.price,
    required this.categories,
    required this.image,
    required this.bools,
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
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Mughlai",
                    style: TextStyle(
                      color: green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  !hideTile
                      ? const Icon(Icons.arrow_drop_down)
                      : const Icon(
                          Icons.play_arrow,
                          size: 15,
                        )
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
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    widget.bools[index]
                                        ? Text(
                                            "\u20B9 ${widget.price[index]}",
                                            style: const TextStyle(
                                              color: black,
                                              fontSize: 15,
                                            ),
                                          )
                                        : const Text(
                                            "*Out of stock",
                                            style: TextStyle(color: red),
                                          ),
                                  ],
                                ),
                              ),
                              Consumer<AddButtonProvider>(
                                  builder: (context, value, _) {
                                Map<String, int> quantities = value.quantity;
                                late int quantity;
                                if (quantities
                                    .containsKey(mughlaiName[index])) {
                                  quantity = quantities[mughlaiName[index]]!;
                                } else {
                                  quantity = 0;
                                }
                                return InkWell(
                                  onTap: () {
                                    if (quantity == 0 && widget.bools[index]) {
                                      setState(() => quantity++);
                                      Provider.of<AddButtonProvider>(context,
                                              listen: false)
                                          .addItem(mughlaiName[index],
                                              widget.price[index]);
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: quantity == 0
                                          ? green.withOpacity(0.15)
                                          : green,
                                    ),
                                    child: quantity == 0
                                        ? const Center(
                                            child: Text(
                                              "ADD",
                                              style: TextStyle(
                                                color: green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  if (quantity > 1) {
                                                    setState(() {
                                                      quantity--;
                                                    });
                                                    Provider.of<AddButtonProvider>(
                                                            context,
                                                            listen: false)
                                                        .decreaseQuantity(
                                                            mughlaiName[index],
                                                            widget
                                                                .price[index]);
                                                  } else {
                                                    setState(() {
                                                      quantity == 0;
                                                    });
                                                    Provider.of<AddButtonProvider>(
                                                            context,
                                                            listen: false)
                                                        .removeItem(
                                                            mughlaiName[index],
                                                            widget
                                                                .price[index]);
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: white,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    quantity++;
                                                  });
                                                  Provider.of<AddButtonProvider>(
                                                          context,
                                                          listen: false)
                                                      .increaseQuantity(
                                                          mughlaiName[index],
                                                          widget.price[index]);
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: white,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                );
                              })
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
