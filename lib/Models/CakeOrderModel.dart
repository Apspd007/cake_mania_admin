class CakeOrderModel {
  final int cakeId;
  final String name;
  final double price;
  String flavor;
  int quantity;
  List<String>? addOns;

  CakeOrderModel({
    required this.cakeId,
    required this.name,
    required this.price,
    required this.flavor,
    required this.quantity,
    this.addOns,
  });
  Map<String, dynamic> toJson() => {
        "cakeId": cakeId,
        "name": name,
        "price": price,
        "flavor": flavor,
        "quantity": quantity,
        "addOns": addOns
      };

  factory CakeOrderModel.fromJson(dynamic json) => CakeOrderModel(
        cakeId: json["cakeId"],
        name: json["name"],
        price: json["price"],
        flavor: json["flavor"],
        quantity: json["quantity"],
        addOns: json["addOns"] ?? [],
      );

// convert list of orders to json file
  static Map<String, dynamic> orderListToJson(
          List<CakeOrderModel> cakeOrderModel, String key) =>
      {
        key: List<dynamic>.from(cakeOrderModel.map((e) => e.toJson())),
      };

// convert json file to list of orders
  static List<CakeOrderModel> jsonToOrderList(json, String key) =>
      List<CakeOrderModel>.from(
          json[key].map((x) => CakeOrderModel.fromJson(x)));
}
