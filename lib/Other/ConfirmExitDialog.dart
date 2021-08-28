import 'package:cake_mania/Materials.dart';
import 'package:cake_mania/services/user_preferences.dart';
import 'package:flutter/material.dart';

class ConfirmExit {
  static Future<bool> showComfirmExitDialog(
      BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey) async {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      return true;
    } else
      return (await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    backgroundColor: Theme.of(context).canvasColor,
                    title: Text(
                      'Exit?',
                      style: textStyle(fontSize: 28, enableShadow: false),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop<bool>(context, false);
                          },
                          child: Text(
                            'No',
                            style: textStyle(enableShadow: false),
                          )),
                      TextButton(
                          onPressed: () async {
                            await UserPreference.saveOrderDetails(context).then(
                                (value) => Navigator.pop<bool>(context, true));
                          },
                          child: Text('Yes',
                              style: textStyle(enableShadow: false))),
                    ],
                  ))) ??
          false;
  }
}












                // TextButton(
                //     onPressed: () {
                //       Navigator.pop<bool>(context, false);
                //     },
                //     child: Text('No')),
                // TextButton(
                //     onPressed: () {
                //       Navigator.pop<bool>(context, true);
                //     },
                //     child: Text('Yes')),