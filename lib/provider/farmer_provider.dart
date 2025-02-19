import 'package:flutter/material.dart';

class FarmerProvider with ChangeNotifier{
  Map<String, Map<String, dynamic>>  _farmers = {};

  Map<String, Map<String, dynamic>> get farmer => _farmers;

  void addOrUpdateFarmer(Map<String, dynamic> farmer) {
    _farmers[farmer['name']] = farmer;
    notifyListeners();
  }

  void setActive(String name, bool isActive) {
    if (_farmers.containsKey(name)) {
      _farmers[name]!['isActive'] = isActive;
      notifyListeners();
    }
  }
}