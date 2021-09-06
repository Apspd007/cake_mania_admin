import 'package:cake_mania_admin/Models/OrdersByUsers.dart';
import 'package:flutter/cupertino.dart';

class OrdersByUsersNotifier extends ChangeNotifier {
  List<OrdersByUsers> _list = [];
  List<OrdersByUsers> get ordersByUsers => _list;

  void addOrdersByUsers(OrdersByUsers ordersByUsers) {
    _list.add(ordersByUsers);
  }
}
