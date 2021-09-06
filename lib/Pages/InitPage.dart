import 'package:cake_mania_admin/Pages/HomePage.dart';
import 'package:cake_mania_admin/services/FirestoreDatabase.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class InitPage extends StatefulWidget {
  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void didChangeDependencies() {
    // final database = Provider.of<Database>(context);
    // database.initData(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
