import 'package:cake_mania/Models/CakeOrderModel.dart';
import 'package:cake_mania/services/user_preferences.dart';
import 'package:flutter/foundation.dart';

class CakeOrderNotifier extends ChangeNotifier {
  List<CakeOrderModel> _cakeOrderModel = UserPreference.getOrderDetails();
  List<CakeOrderModel> get cakeOrderModel => _cakeOrderModel;
  int get totalOrders => _cakeOrderModel.length;

  void add(CakeOrderModel event) {
    bool _add = true;
    if (!_cakeOrderModel.contains(event)) {
      _cakeOrderModel.forEach((element) {
        if (element.cakeId == event.cakeId && element.flavor == event.flavor) {
          _add = false;
          element.quantity = event.quantity;
          print('Already Added');
        }
      });
    } else {
      print('not added');
    }
    if (_add) {
      _cakeOrderModel.add(event);
      notifyListeners();
      print('added');
    }
  }

  void deleteAllOrders() {
    _cakeOrderModel.clear();
    notifyListeners();
  }

  void deleteOrderAt(int index) {
    _cakeOrderModel.removeAt(index);
    notifyListeners();
  }

  void changeFlavorAt(int index, String flavor) {
    _cakeOrderModel.elementAt(index).flavor = flavor;
    notifyListeners();
  }

  void changeQuantityAt(int index, int quantity) {
    _cakeOrderModel.elementAt(index).quantity = quantity;
    notifyListeners();
  }

  void changeAddOnsAt(int index, List<String> addOns) {
    _cakeOrderModel.elementAt(index).addOns = addOns;
    notifyListeners();
  }
}
