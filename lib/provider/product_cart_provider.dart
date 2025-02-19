import 'package:flutter/material.dart';
import '../shop_page.dart';

class ProductCartProvider extends ChangeNotifier {
  final List<Product> _items = [];
  final Map<Product, int> _quantities = {};

  List<Product> get items => _items;

  var orderObj = [];

  void add(Product item) {
    if (_quantities.containsKey(item)) {
      _quantities[item] = _quantities[item]! + 1;
      for (var obj in orderObj) {
        if (obj['productId'] == item.id) {
          obj['quantity'] = _quantities[item];
          break;
        }
      }
    } else {
      _items.add(item);
      orderObj.add({"productId": item.id, "quantity": 1});
      _quantities[item] = 1;
    }
    print(orderObj);
    notifyListeners();
  }

  void remove(Product item) {
    if (_quantities.containsKey(item) && _quantities[item]! > 1) {
      _quantities[item] = _quantities[item]! - 1;
    } else {
      _items.remove(item);
      _quantities.remove(item);
    }
    notifyListeners();
  }

  int getQuantity(Product item) {
    return _quantities[item] ?? 0;
  }

  void delete(Product item) {
    _items.remove(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    _quantities.clear();
    notifyListeners();
  }

  double getCartTotal() {
    return _items.fold(
        0,
        (previousValue, item) =>
            previousValue + (item.price * (_quantities[item] ?? 1)) + 199);
  }
}














// import 'package:flutter/material.dart';
// import '../shop_page.dart';
//
// class ProductCartProvider extends ChangeNotifier{
//   final List<Product> _items = [];
//
//   List<Product> get items => _items;
//
//   void add(Product item){
//     _items.add(item);
//     notifyListeners();
//   }
//
//   void remove(Product item){
//     _items.remove(item);
//     notifyListeners();
//   }
//
//   void removeAll(Product item){
//     _items.clear();
//     notifyListeners();
//   }
//
//   double getCartTotal(){
//     return _items.fold(0, (previousValue, item)=>previousValue + item.price + 199);
//   }
// }