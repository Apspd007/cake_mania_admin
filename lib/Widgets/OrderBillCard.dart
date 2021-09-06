import 'package:cake_mania_admin/Materials.dart';
import 'package:cake_mania_admin/services/AuthenticationService.dart';
import 'package:cake_mania_admin/services/FirestoreDatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cake_mania_admin/Models/OrderBillModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class OrderBillCard extends StatefulWidget {
  final LocalUser user;
  final OrderBillModel orderBillCard;
  OrderBillCard({
    required this.orderBillCard,
    required this.user,
  });

  @override
  _OrderBillCardState createState() => _OrderBillCardState();
}

class _OrderBillCardState extends State<OrderBillCard> {
  late String _status;
  final List<DropdownMenuItem<String>> itemsList = [
    DropdownMenuItem(
      child: Text("pending"),
      value: "pending",
    ),
    DropdownMenuItem(
      child: Text("accepted"),
      value: "accepted",
    ),
    DropdownMenuItem(
      child: Text("rejected"),
      value: "rejected",
    ),
    DropdownMenuItem(
      child: Text("onHold"),
      value: "onHold",
    ),
  ];

  changeStaus(String value, BuildContext context) {
    final db = Provider.of<Database>(context, listen: false);
    db.updateOrderStatus(value, widget.user.uid, widget.orderBillCard.orderId);
    setState(() {});
  }

  @override
  void initState() {
    _status = "${widget.orderBillCard.orderStatus.toString().split(".")[1]}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: Offset.zero,
              blurRadius: 10,
              color: Colors.black45,
            ),
          ]),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: _children(widget.orderBillCard, context),
          ),
        ],
      ),
    );
  }

  List<Widget> _children(OrderBillModel orderBillCard, BuildContext context) {
    List<Widget> list = [];
    orderBillCard.cakeOrderModel.forEach((element) {
      list.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              element.imageUrl,
              height: 50.h,
            ),
            SizedBox(width: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  element.name,
                  style: textStyle(
                    enableShadow: false,
                    fontSize: 24,
                    color: Colors.black87,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "${element.price} x ${element.quantity}",
                      style: textStyle(
                        enableShadow: false,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Text(
                      "Total :  ${element.price * element.quantity}",
                      style: textStyle(
                        enableShadow: false,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ));
      list.add(SizedBox(height: 10.h));
    });
    list.add(Divider(
      endIndent: 10,
      indent: 10,
      thickness: 2,
      color: Colors.black54,
    ));
    list.add(
      Padding(
        padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Grand Total :  ${orderBillCard.totalPrice}",
              style: textStyle(
                  enableShadow: false, fontSize: 18, color: Colors.black87),
            ),
            // Text(
            //   "${orderBillCard.orderStatus.toString().split(".")[1]}",
            //   style: textStyle(
            //       enableShadow: false, fontSize: 18, color: Colors.black87),
            // ),
            DropdownButton<String>(
              items: itemsList,
              dropdownColor: Colors.white,
              value: _status,
              onChanged: (value) {
                changeStaus(value!, context);
                setState(() {
                  _status = value;
                });
              },
            ),
          ],
        ),
      ),
    );
    return list;
  }
}
