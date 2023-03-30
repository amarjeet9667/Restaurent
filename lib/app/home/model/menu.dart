class Menu {
  final String name;
  final int price;
  final bool instock;

  Menu({
    required this.name,
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
