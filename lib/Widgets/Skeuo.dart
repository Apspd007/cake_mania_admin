import 'package:flutter/material.dart';

Widget convex(String txt) {
  return Center(
    child: Container(
      height: 200,
      width: 200,
      child: Center(child: Icon(Icons.favorite_border)),
      decoration: BoxDecoration(
          color: Color(0xFFf8fbf8),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(10.0, 10.0),
                blurRadius: 10.0,
                spreadRadius: 2.0),
            BoxShadow(
                color: Colors.white,
                offset: Offset(-10.0, -10.0),
                blurRadius: 10.0,
                spreadRadius: 2.0)
          ]),
    ),
  );
}

List<Color> _fill = <Color>[
  Colors.grey.shade200,
  Color(0xFFf8fbf8),
  Colors.white
];

Widget concav(String txt, Color _clr) {
  return Container(
    height: 200,
    width: 200,
    child: Center(
      child: Icon(
        Icons.favorite,
        color: Colors.red,
      ),
    ),
    decoration: BoxDecoration(
      color: _clr,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: _fill,
        stops: [0.1, 0.5, 0.9],
      ),
    ),
  );
}
