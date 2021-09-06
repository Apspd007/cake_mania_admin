import 'package:cake_mania_admin/Materials.dart';
import 'package:cake_mania_admin/Models/CakeModel.dart';
import 'package:cake_mania_admin/Models/SectionModel.dart';
import 'package:cake_mania_admin/Notifiers/SectionNotifier.dart';
import 'package:cake_mania_admin/Other/ConfirmExitDialog.dart';
import 'package:cake_mania_admin/Widgets/CakeCard.dart';
import 'package:cake_mania_admin/Widgets/FancyDrawer.dart';
import 'package:cake_mania_admin/Widgets/SectionCard.dart';
import 'package:cake_mania_admin/services/AuthenticationService.dart';
import 'package:cake_mania_admin/services/FirestoreDatabase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => ConfirmExit.showComfirmExitDialog(context, _scaffoldKey),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(context),
        drawer: FancyDrawer(),
        drawerEnableOpenDragGesture: true,
        body: _mainBody(context),
      ),
    );
  }

  Widget _mainBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.w),
      child: Column(
        children: [
          _profile(context),
          SizedBox(height: 20.h),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  _sections("Sections", context),
                  _cakes("Cakes", context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _sections(String title, BuildContext context) {
    final database = Provider.of<Database>(context);
    final sectionModelNotifier = Provider.of<SectionModelNotifier>(context);
    return StreamBuilder<QuerySnapshot<Object?>>(
      stream: database.getSections(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.active) {
            final sectionList =
                SectionModel.jsonToSectionList(snapshot.data!.docs);
            final List<SectionCard> sectionCards =
                SectionModel.sectionModelListToSectionCardList(sectionList);
            sectionModelNotifier.addSectionNames(sectionList);
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 400.h,
                minHeight: 260.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: textStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Row(
                        children: sectionCards,
                      ),
                    ),
                  )
                ],
              ),
            );
            // return Center();
          } else {
            return Center();
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return Center();
        }
      },
    );
  }

  Widget _cakes(String title, BuildContext context) {
    final database = Provider.of<Database>(context);
    // database.getOrders();
    return StreamBuilder<DocumentSnapshot<Object?>>(
      stream: database.getAllCakes(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.active) {
            final json = snapshot.data!.data() as Map<String, dynamic>;
            final data = CakeModel.jsonToCakeModelList(json["cakeList"]);
            final cakeCards = CakeModel.cakeModelListToCakeCardList(
              data,
            );
            return _child(title, cakeCards);
          } else {
            return Center();
          }
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return Center();
        }
      },
    );
  }

  ConstrainedBox _child(String title, List<CakeCard> cakeCards) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 400.h,
        minHeight: 260.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: textStyle(
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Row(
                children: cakeCards,
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    // final user = Provider.of<LocalUser>(context);
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Image.asset('assets/Menu.png'),
        onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        splashRadius: 0.001,
      ),
      leadingWidth: 100.w,
      toolbarHeight: 80.h,
      actions: [],
    );
  }

  Widget _profile(BuildContext context) {
    final _user = Provider.of<LocalUser>(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(1.5, 3.5),
                  blurRadius: 4,
                  color: Colors.black38),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(_user.displayImage,
                fit: BoxFit.cover, height: 55.r, width: 55.r),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 16.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hey! ${_user.displayName.split(" ")[0]}',
                style: textStyle(),
              ),
              Text(
                'What’s Special Today?',
                style: textStyle(fontSize: 18),
              ),
            ],
          ),
        )
      ],
    );
  }
}
