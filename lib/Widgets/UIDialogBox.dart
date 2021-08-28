import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIDialog {
  static Future<void> showUIDialog({
    required String title,
    Color? titleColor = Colors.black87,
    required BuildContext context,
    required List<Widget> actions,
  }) async {
    showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      duration: Duration(milliseconds: 300),
      animationType: DialogTransitionType.slideFromBottom,
      curve: Curves.easeOutCirc,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
            height: 30.h,
            width: double.infinity,
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                fontSize: 20.h,
                color: titleColor,
              ),
            ))),
        actions: actions,
      ),
    );
  }
}