import 'dart:ui';
import 'package:cake_mania/Materials.dart';
import 'package:cake_mania/services/AuthenticationService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cake_mania/Designs/painter.dart';
import 'package:cake_mania/Widgets/UIButton.dart';
import 'package:cake_mania/Widgets/UIDialogBox.dart';
import 'package:cake_mania/Designs/WaveClip.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loginpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthBase _authBase = Provider.of<AuthBase>(context);
    final padding = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      // backgroundColor: DarkUIColors.loginpageBackgroundColor,
      body: Container(
        padding: EdgeInsets.only(bottom: padding),
        // padding: EdgeInsets.symmetric(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            wavesContainer(),
            centerText(context),
            loginButton(context, _authBase),
          ],
        ),
      ),
    );
  }

  Container centerText(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(width: _size.width / 2),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                  text: 'CAKE\n',
                  style: GoogleFonts.varelaRound(
                    // color: Colors.white,
                    color: MyColorScheme.englishVermillion,
                    fontSize: 80.sp,
                    shadows: [
                      Shadow(
                          offset: Offset(0, 5),
                          blurRadius: 6,
                          color: Colors.black38),
                    ],
                  ),
                  children: [
                    TextSpan(
                        text: 'MANIA',
                        style: GoogleFonts.varelaRound(
                          color: Colors.white,
                          fontSize: 80.sp,
                          shadows: [
                            Shadow(
                                offset: Offset(0, 5),
                                blurRadius: 6,
                                color: Colors.black38),
                          ],
                        ))
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Container loginButton(BuildContext context, AuthBase _authBase) {
    return Container(
      height: 100.h,
      width: 220.h,
      child: Padding(
        padding: EdgeInsets.only(bottom: 40.h),
        child: UILoginButton(
          googleImage: Image.asset(
            'assets/google_logo.png',
            width: 22.r,
            height: 22.r,
          ),
          text: 'Continue',
          textSize: 22.sp,
          height: 80.h,
          width: 200.w,
          borderRadius: 60,
          elevation: 5,
          onPressed: () async {
            var connectivityResult = await (Connectivity().checkConnectivity());
            if (connectivityResult == ConnectivityResult.wifi ||
                connectivityResult == ConnectivityResult.mobile) {
              await _authBase.signInWithGoogle();
            } else if (connectivityResult == ConnectivityResult.none) {
              UIDialog.showUIDialog(
                title: 'No Internet!',
                titleColor: Colors.red[400],
                context: context,
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'ok',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Container wavesContainer() {
    return Container(
      height: 250.h,
      child: Stack(
        children: [
          CustomPaint(
            painter: SecondShadowPainter(),
            child: Container(
              height: 250.h,
              child: ClipPath(
                clipper: SecondWaveClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  height: 245.h,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          CustomPaint(
            painter: FirstShadowPainter(),
            child: Container(
              height: 230.h,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: MyColorScheme.englishVermillion,
                  height: 225.h,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
