import 'package:cake_mania_admin/Models/SectionModel.dart';
import 'package:flutter/foundation.dart';

class SectionModelNotifier extends ChangeNotifier {
  List<SectionModel> _sectionCard = [];
  List<String> _sectionNames = [];
  List<String> get sectionNames => _sectionNames;

  List<SectionModel> get sectionCards => _sectionCard;

  void addSection(SectionModel sectionCard) {
    _sectionCard.add(sectionCard);
    // notifyListeners();
  }

  void addSectionNames(List<SectionModel> sectionCards) {
    sectionCards.forEach((element) {
      if (!_sectionNames.contains(element.title)) {
        _sectionNames.add(element.title);
      }
    });
    // notifyListeners();
  }
}
