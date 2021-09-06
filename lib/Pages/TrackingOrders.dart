import 'package:cake_mania_admin/Materials.dart';
import 'package:cake_mania_admin/Models/OrderBillModel.dart';
import 'package:cake_mania_admin/Models/OrdersByUsers.dart';
import 'package:cake_mania_admin/Pages/OrderDetails.dart';
// import 'package:cake_mania_admin/Models/UserDataModel.dart';
import 'package:cake_mania_admin/Widgets/OrderBillCard.dart';
import 'package:cake_mania_admin/services/AuthenticationService.dart';
import 'package:cake_mania_admin/services/FirestoreDatabase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:provider/provider.dart';

class TrackingOrders extends StatefulWidget {
  @override
  _TrackingOrdersState createState() => _TrackingOrdersState();
}

class _TrackingOrdersState extends State<TrackingOrders> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _switchTab(),
            SizedBox(height: 20.h),
            _tabIndex == 0
                ? StreamBuilder<DocumentSnapshot<Object?>>(
                    stream: database.getOrdersBy(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final json =
                              snapshot.data!.data() as Map<String, dynamic>;
                          final ordersBy =
                              OrdersByUsers.fromJson(json["OrdersBy"]);
                          return _child(ordersBy.users);
                        } else {
                          return SizedBox.shrink();
                        }
                      } else if (snapshot.hasError) {
                        return Center(child: Text("${snapshot.error}"));
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _child(List<LocalUser> users) {
    return Expanded(
        child: ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => OrderDetails(user: users[index])));
          },
          tileColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          leading: Image.network(
            users[index].displayImage,
          ),
          trailing: Icon(
            Icons.arrow_right_rounded,
            color: Colors.black87,
            size: 35,
          ),
          title: Text(
            users[index].displayName,
            style: textStyle(
              enableShadow: false,
              color: Colors.black87,
            ),
          ),
        );
      },
    ));
  }

  Align _switchTab() {
    return Align(
      alignment: Alignment.center,
      child: FlutterToggleTab(
        width: 80.w,
        labels: ["Current", "Completed"],
        selectedIndex: _tabIndex,
        selectedLabelIndex: (int index) {
          setState(() {
            _tabIndex = index;
          });
        },
        selectedTextStyle: textStyle(
          color: Colors.black87,
          enableShadow: false,
        ),
        unSelectedTextStyle: textStyle(
          enableShadow: false,
          color: Colors.black54,
        ),
        selectedBackgroundColors: [
          MyColorScheme.aqua,
        ],
        unSelectedBackgroundColors: [
          Colors.white,
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      title: Text("Orders",
          style: textStyle(
            fontSize: 30,
            enableShadow: false,
          )),
      toolbarHeight: 80.h,
      leadingWidth: 0,
      leading: SizedBox.shrink(),
    );
  }
}
