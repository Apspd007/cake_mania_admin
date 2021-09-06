import 'package:cake_mania_admin/Materials.dart';
import 'package:cake_mania_admin/Pages/HomePage.dart';
import 'package:cake_mania_admin/Pages/InitPage.dart';
import 'package:cake_mania_admin/Pages/Loginpage.dart';
import 'package:cake_mania_admin/services/AuthenticationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthBase>(context);
    return ScreenUtilInit(
      designSize: Size(414, 736),
      builder: () => MaterialApp(
        title: 'Cake Mania Admin',
        theme: themeData(),
        home: Scaffold(
          body: SafeArea(
            child: StreamBuilder<LocalUser?>(
                stream: _auth.authStateChange(),
                builder:
                    (BuildContext context, AsyncSnapshot<LocalUser?> snapshot) {
                  if (snapshot.hasData) {
                    final _user = snapshot.data!;
                    if (snapshot.connectionState == ConnectionState.active) {
                      return Provider(
                          create: (_) => LocalUser(
                                uid: _user.uid,
                                email: _user.email,
                                displayName: _user.displayName,
                                displayImage: _user.displayImage,
                                emailVerified: _user.emailVerified,
                              ),
                          child: InitPage());
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text(snapshot.error.toString());
                  } else {
                    return Loginpage();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
