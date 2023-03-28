// class Menu {
//   final String? name;
//   final int? price;
//   final bool? instock;

//   Menu({
//     required this.name,
//     required this.price,
//     required this.instock,
//   });
// }

// class FoodTypes {
//   final String? name;
//   final List<Menu>? item;

//   FoodTypes({
//     required this.name,
//     required this.item,
//   });
// }

class Menu {
  String name;
  int price;
  bool inStock;

  Menu({
    required this.name,
    required this.price,
    required this.inStock,
  });

  factory Menu.fromJson(dynamic json) {
    return Menu(
      name: json['name'] as String,
      price: json['price'] as int,
      inStock: json['instock'] as bool,
    );
  }
}

class FoodType {
  String name;
  List<Menu> items;

  FoodType({
    required this.name,
    required this.items,
  });

  factory FoodType.fromJson(dynamic json, {required String name}) {
    var temp = json[name] as List;
    List<Menu> items = temp.map((e) => Menu.fromJson(e)).toList();
    return FoodType(name: name, items: items);
  }
}
