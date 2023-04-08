class Menu {
  final String name;
  final String image;
  final int price;
  final bool instock;

  Menu({
    required this.name,
    required this.image,
    required this.price,
    required this.instock,
  });
}

class FoodType {
  final String name;
  final List items;

  FoodType({
    required this.name,
    required this.items,
  });
}
