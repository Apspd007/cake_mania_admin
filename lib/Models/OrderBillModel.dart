import 'package:cake_mania_admin/Models/CakeOrderModel.dart';
import 'package:cake_mania_admin/Models/OrderStatusEnums.dart';
import 'package:cake_mania_admin/Models/PaymentStatusEnums.dart';

class OrderBillModel {
  final List<CakeOrderModel> cakeOrderModel;
  final OrderStatus orderStatus;
  final PaymentStatus paymentStatus;
  final double totalPrice;
  final String orderId;

  OrderBillModel({
    required this.cakeOrderModel,
    required this.totalPrice,
    required this.orderId,
    this.orderStatus = OrderStatus.pending,
    this.paymentStatus = PaymentStatus.unpaid,
  });

  static List<OrderBillModel> jsonToOrderBillList(Map<String, dynamic> json) {
    List<OrderBillModel> list = [];
    json.forEach((key, value) {
      list.add(OrderBillModel.fromJson(value));
    });
    return list;
  }

  factory OrderBillModel.fromJson(json) => OrderBillModel(
        cakeOrderModel: CakeOrderModel.jsonToOrderList(json, "cakeOrderModel"),
        totalPrice: json["totalPrice"],
        orderId: json["orderId"],
        orderStatus: OrderStatusConvertor.fromJson(json["orderStatus"]),
      );
  static Map<String, dynamic> toJson(OrderBillModel orderBillModel) => {
        // static  => {
        "cakeOrderModel": CakeOrderModel.orderListToJson(
            orderBillModel.cakeOrderModel, "cakeOrderModel")["cakeOrderModel"],
        "orderId": orderBillModel.orderId,
        "totalPrice": orderBillModel.totalPrice,
        "orderStatus": OrderStatusConvertor.toJson(orderBillModel.orderStatus),
      };
}
