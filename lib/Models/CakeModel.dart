import 'package:cake_mania_admin/Models/IngredientModel.dart';
import 'package:cake_mania_admin/Widgets/CakeCard.dart';

class CakeModel {
  final int cakeId;
  final String name;
  final String imageUrl;
  final double price;
  final List<IngredientModel>? ingredient;
  final String details;

  CakeModel({
    required this.cakeId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.details,
    this.ingredient,
  });

  factory CakeModel.fromJson(Map<String, dynamic> json) => CakeModel(
        cakeId: json["cakeId"],
        name: json["name"].toString(),
        imageUrl: json["imageUrl"].toString(),
        price: json["price"] as double,
        details: json["details"],
        ingredient: json["ingredient"],
      );

  static Map<String, dynamic> toJson(CakeModel cakeModel) => {
        "cakeId": cakeModel.cakeId,
        "name": cakeModel.name,
        "imageUrl": cakeModel.imageUrl,
        "price": cakeModel.price,
        "details": cakeModel.details,
        "ingredient": cakeModel.ingredient,
      };
  static List<CakeModel> jsonToCakeModelList(json) {
    final list = List<CakeModel>.from(json.map((x) => CakeModel.fromJson(x)));
    return list;
  }

  static List<CakeModel> sectionListToCakeModelList(
      List<CakeModel> cakemodels) {
    final list = List<CakeModel>.from(cakemodels.map((x) => x));
    return list;
  }

  static List<CakeCard> cakeModelListToCakeCardList(
      List<CakeModel> cakemodels) {
    final list = List<CakeCard>.from(cakemodels.map((x) => CakeCard(
        cakeModel: CakeModel(
            cakeId: x.cakeId,
            name: x.name,
            imageUrl: x.imageUrl,
            price: x.price,
            details: x.details))));
    return list;
  }
}
