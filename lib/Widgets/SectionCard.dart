import 'package:cake_mania_admin/Materials.dart';
import 'package:cake_mania_admin/Models/CakeCardColor.dart';
import 'package:cake_mania_admin/Models/CakeModel.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final CakeCardColor cardColor;
  final List<CakeModel> cakeModels;
  SectionCard({
    required this.title,
    required this.cardColor,
    required this.cakeModels,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: GestureDetector(
        onTap: () {},
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            // gradient: _gradient(),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 0),
                  color: Colors.black38,
                  blurRadius: 15,
                  spreadRadius: 0.5),
            ],
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: SizedBox(
              height: 270.h,
              width: 200.w,
              child: Stack(
                children: [
                  _cakeWithDetails(context),
                  // _addToFav(context),
                  _addCake(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _addCake(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Align(
        alignment: Alignment.bottomRight,
        child: Icon(
          Icons.add_circle_rounded,
          size: 53.r,
          color: MyColorScheme.englishVermillion,
        ),
      ),
    );
  }

  Align _cakeWithDetails(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: OverflowBox(
        maxHeight: 260.h,
        minHeight: 200.h,
        maxWidth: 180.w,
        minWidth: 150.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Expanded(
            //   child: SizedBox(
            //     height: double.infinity,
            //     width: double.infinity,
            //     child: Center(
            //       child: DecoratedBox(
            //         decoration: BoxDecoration(
            //             color: _cardColor(context),
            //             borderRadius: BorderRadius.all(Radius.circular(20))),
            //         child: SimpleShadow(
            //           color: Colors.black87,
            //           offset: Offset(7, 8),
            //           sigma: 4,
            //           child: Center(),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: textStyle(
                    color: MyColorScheme.englishVermillion,
                    fontWeight: FontWeight.w500,
                    enableShadow: false),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                cakeModels.length.toString(),
                style: textStyle(
                    color: MyColorScheme.englishVermillion,
                    fontWeight: FontWeight.w500,
                    enableShadow: false),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Color _cardColor(BuildContext context) {
  //   switch (cardColor) {
  //     case CakeCardColor.corn:
  //       return MyColorScheme.corn;
  //     case CakeCardColor.englishVermillion:
  //       return MyColorScheme.englishVermillion;
  //     case CakeCardColor.terraCotta:
  //       return MyColorScheme.terraCotta;
  //     default:
  //       return MyColorScheme.corn;
  //   }
  // }

}
