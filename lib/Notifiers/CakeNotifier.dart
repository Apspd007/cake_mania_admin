import 'package:cake_mania_admin/Widgets/CakeCard.dart';
import 'package:flutter/material.dart';

class CakeNotifier extends ChangeNotifier {
  List<CakeCard> _cakeCard = [];

  List<CakeCard> get cakeCards => _cakeCard;

  void addSection(CakeCard cakeCard) {
    _cakeCard.add(cakeCard);
    notifyListeners();
  }
}
