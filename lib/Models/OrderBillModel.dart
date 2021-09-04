import 'package:cake_mania_admin/Models/CakeOrderModel.dart';
import 'package:cake_mania_admin/Models/OrderStatusEnums.dart';
import 'package:cake_mania_admin/Models/PaymentStatusEnums.dart';
import 'package:cake_mania_admin/services/AuthenticationService.dart';

class OrderBillModel {
  final List<CakeOrderModel> cakeOrderModel;
  final LocalUser user;
  final OrderStatus orderStatus;
  final PaymentStatus paymentStatus;
  final double totalPrice;
  final String orderId;

  OrderBillModel({
    required this.cakeOrderModel,
    required this.user,
    required this.totalPrice,
    required this.orderId,
    this.orderStatus = OrderStatus.pending,
    this.paymentStatus = PaymentStatus.unpaid,
  });

  factory OrderBillModel.fromJson(json) => OrderBillModel(
        cakeOrderModel: CakeOrderModel.jsonToOrderList(json, "cakeOrderModel"),
        user: LocalUser.fromJson(json["user"]),
        totalPrice: json["totalPrice"],
        orderId: json["orderId"],
        orderStatus: OrderStatusConvertor.fromJson(json["orderStatus"]),
      );
  static Map<String, dynamic> toJson(OrderBillModel orderBillModel) => {
        // static  => {
        "cakeOrderModel": CakeOrderModel.orderListToJson(
            orderBillModel.cakeOrderModel, "cakeOrderModel")["cakeOrderModel"],
        "user": LocalUser.toJson(orderBillModel.user),
        "orderId": orderBillModel.orderId,
        "totalPrice": orderBillModel.totalPrice,
        "orderStatus": OrderStatusConvertor.toJson(orderBillModel.orderStatus),
      };
}
