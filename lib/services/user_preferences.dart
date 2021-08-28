import 'dart:convert';
import 'package:cake_mania/Models/CakeOrderModel.dart';
import 'package:cake_mania/Notifiers/CakeOrderNotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class UserPreference {
  // static late final SharedPreferences _preferences;
  static final _preference = GetStorage('orderDetails');
  static final String _keyCakeOrderDetails = 'cakeOrderDetails';

  static Future init() async {
    await GetStorage.init('orderDetails');
  }

  static saveOrderDetails(BuildContext context) async {
    final data = Provider.of<CakeOrderNotifier>(context, listen: false);
    final json = jsonEncode(CakeOrderModel.orderListToJson(
        data.cakeOrderModel, _keyCakeOrderDetails));
    _preference.write(_keyCakeOrderDetails, json);
  }

  static getOrderDetails() {
    final json = _preference.read(_keyCakeOrderDetails);
    final List<CakeOrderModel> _value = json == null
        ? []
        : CakeOrderModel.jsonToOrderList(
            jsonDecode(json), _keyCakeOrderDetails);
    return _value;
  }

  static clearData() {
    _preference.erase();
  }
}
