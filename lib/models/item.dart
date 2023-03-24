// -----------------------------------------------------------------------------
// item.dart
// -----------------------------------------------------------------------------
//
// This file make objects for class to call items
// which can get five requirements parameters name,catagory,price,quantity
// and set favorite is fall

class Item {
  String name;
  String category;
  int price;
  int quantity;
  bool isFav = false;
  Item({
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
  });
}
