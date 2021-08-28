import 'package:cake_mania/Widgets/CakeCard.dart';

class CakeModel {
  final int cakeId;
  final String name;
  final String imageUrl;
  final double price;

  CakeModel({
    required this.cakeId,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  static List<CakeCard> cakeCardsFromCakeModelList(
      List<CakeModel> data, CakeCardColor cardColor) {
    List<CakeCard> _list = [];

    data.forEach((element) {
      _list.add(CakeCard(
        cakeModel: element,
        cardColor: cardColor,
      ));
    });
    return _list;
  }

  static List<CakeModel> cakeModelListFromDB(json) {
    final List<CakeModel> _data = [];
    if (json["cakeList"] != null) {
      json["cakeList"].forEach((x) {
        _data.add((CakeModel.fromJson(x)));
      });
      return _data;
    } else {
      return [];
    }
  }

  factory CakeModel.fromJson(Map<String, dynamic> json) => CakeModel(
        cakeId: json["cakeId"].toInt(),
        name: json["name"].toString(),
        imageUrl: json["imageUrl"].toString(),
        price: json["price"].toDouble(),
      );

  static Map<String, dynamic> toJson(CakeModel cakeModel) => {
        "cakeId": cakeModel.cakeId,
        "name": cakeModel.name,
        "imageUrl": cakeModel.imageUrl,
        "price": cakeModel.price,
      };
}

enum CakeCardColor { corn, englishVermillion, terraCotta }
