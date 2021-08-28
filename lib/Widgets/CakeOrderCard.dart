import 'package:cake_mania/Materials.dart';
import 'package:cake_mania/Models/CakeOrderModel.dart';
import 'package:cake_mania/Notifiers/CakeOrderNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CakeOrderCard extends StatefulWidget {
  final int index;
  final CakeOrderModel cakeOrderCard;
  CakeOrderCard({
    required this.index,
    required this.cakeOrderCard,
  });

  @override
  _CakeOrderCardState createState() => _CakeOrderCardState();
}

class _CakeOrderCardState extends State<CakeOrderCard> {
  List<DropdownMenuItem<String>> _flavorList = [
    DropdownMenuItem(
      child: Text('Mango'),
      onTap: () {},
      value: 'Mango',
    ),
    DropdownMenuItem(
      child: Text('Strawberry'),
      onTap: () {},
      value: 'Strawberry',
    ),
  ];
  List<DropdownMenuItem<int>> _quantityList = [
    DropdownMenuItem(
      child: Text('1'),
      onTap: () {},
      value: 1,
    ),
    DropdownMenuItem(
      child: Text('2'),
      onTap: () {},
      value: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final _cakeOrderNotifier = context.read<CakeOrderNotifier>();
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFF6CBD2), borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(5, 15, 10, 15),
      width: double.infinity,
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Image.asset(
            'assets/cake.png',
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Whit Frozen Cake',
                  style: textStyle(
                      color: Color(0xFF3D3D3D),
                      fontWeight: FontWeight.w500,
                      enableShadow: false)),
              Text('\u{20B9}2000',
                  style: textStyle(
                      color: Color(0xFF3D3D3D),
                      fontWeight: FontWeight.w500,
                      enableShadow: false)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownButton<String>(
                    value: widget.cakeOrderCard.flavor,
                    hint: Text('Flavor',
                        style: textStyle(
                            color: Color(0xFF3D3D3D),
                            fontSize: 15,
                            enableShadow: false)),
                    style: textStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        enableShadow: false),
                    dropdownColor: Colors.white,
                    iconEnabledColor: Color(0xFF3D3D3D),
                    underline: DecoratedBox(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black87,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                    items: _flavorList,
                    onChanged: (String? flavor) {
                      setState(() {
                        _cakeOrderNotifier.changeFlavorAt(
                            widget.index, flavor!);
                      });
                    },
                  ),
                  DropdownButton<int>(
                    value: widget.cakeOrderCard.quantity,
                    hint: Text('Quantity',
                        style: textStyle(
                            color: Color(0xFF3D3D3D),
                            fontSize: 15,
                            enableShadow: false)),
                    style: textStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        enableShadow: false),
                    dropdownColor: Colors.white,
                    iconEnabledColor: Color(0xFF3D3D3D),
                    underline: DecoratedBox(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black87,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
                    items: _quantityList,
                    onChanged: (int? quantity) {
                      setState(() {
                        _cakeOrderNotifier.changeQuantityAt(
                            widget.index, quantity!);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
