// import 'package:cake_mania/Models/UserDataModel.dart';
// import 'package:cake_mania/Widgets/CakeCard.dart';
// import 'package:cake_mania/services/AuthenticationService.dart';
// import 'package:cake_mania/services/FirestoreDatabase.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class FavoritePage extends StatelessWidget {
//   final LocalUser user;
//   FavoritePage({
//     required this.user,
//   });
//   @override
//   Widget build(BuildContext context) {
//     final database = Provider.of<Database>(context);
//     return Scaffold(
//         body: StreamBuilder<DocumentSnapshot<Object?>>(
//             stream: database.getUserDataAsStream(user.uid),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 final Map<String, dynamic> json =
//                     snapshot.data!.data() as Map<String, dynamic>;
//                 final UserData userData = UserData.from(json);
//                 if (snapshot.connectionState == ConnectionState.active) {
//                   return GridView.builder(
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                       ),
//                       itemBuilder: (BuildContext context, int index) {
//                         return Center();
//                       });
//                 } else {
//                   return Center(child: CircularProgressIndicator());
//                 }
//               } else if (snapshot.hasError) {
//                 return Center(child: Text(snapshot.error.toString()));
//               } else {
//                 return Center(child: CircularProgressIndicator());
//               }
//             }));
//   }
// }
