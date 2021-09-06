import 'package:cake_mania_admin/Materials.dart';
import 'package:cake_mania_admin/Models/OrderBillModel.dart';
import 'package:cake_mania_admin/Widgets/OrderBillCard.dart';
import 'package:cake_mania_admin/services/AuthenticationService.dart';
import 'package:cake_mania_admin/services/FirestoreDatabase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatelessWidget {
  final LocalUser user;
  OrderDetails({
    required this.user,
  });
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<DocumentSnapshot<Object?>>(
            future: db.getOrderDetail(user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final json = snapshot.data!.data() as Map<String, dynamic>;
                  final confirmOrders =
                      OrderBillModel.jsonToOrderBillList(json);
                  // print(json);

                  return SingleChildScrollView(
                    child: Column(
                        children: _children(confirmOrders),
                        ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              } else if (snapshot.hasError) {
                return SizedBox.shrink();
              } else {
                return SizedBox.shrink();
              }
            }),
      ),
    );
  }

  List<Widget> _children(List<OrderBillModel> confirmOrders) {
    final List<Widget> list = [];
    confirmOrders.forEach((element) {
      list.add(OrderBillCard(
        orderBillCard: element,
        user: user,
      ));
    });
    return list;
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      title: Center(
        child: Text("${user.displayName}",
            style: textStyle(
              fontSize: 30,
              enableShadow: false,
            )),
      ),
      toolbarHeight: 80.h,
      leadingWidth: 0,
      leading: SizedBox.shrink(),
    );
  }
}
