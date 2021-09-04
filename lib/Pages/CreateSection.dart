import 'package:cake_mania_admin/Materials.dart';
import 'package:cake_mania_admin/Models/CakeModel.dart';
import 'package:cake_mania_admin/Notifiers/SectionNotifier.dart';
import 'package:cake_mania_admin/Widgets/SectionCard.dart';
import 'package:cake_mania_admin/services/FirestoreDatabase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateSection extends StatefulWidget {
  @override
  _CreateSectionState createState() => _CreateSectionState();
}

class _CreateSectionState extends State<CreateSection> {
  final TextEditingController _sectionName = TextEditingController();
  String? _color;
  final List<DropdownMenuItem<String>> _listColor = [
    DropdownMenuItem(
      child: Text('Corn'),
      value: 'corn',
    ),
    DropdownMenuItem(
      child: Row(
        children: [
          Text('English Vermillion'),
        ],
      ),
      value: "englishVermillion",
    ),
    DropdownMenuItem(
      child: Text('Terra Cotta'),
      value: "terraCotta",
    ),
  ];
  bool _pressed = false;

  validate(Database database) {
    if (_sectionName.text != "" && _color != null) {
      print('ok');
      database.createSection(_sectionName.text, _color!);
      Navigator.of(context).pop();
    } else {
      print("not ok");
    }
  }

  @override
  void dispose() {
    _sectionName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Create Section',
                  style: textStyle(fontSize: 30),
                ),
              ),
              _textField(_sectionName),
              _colorSelect(),
              Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _button(
                      title: "Create",
                      database: database,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _colorSelect() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white60,
              width: 3,
              style: BorderStyle.solid,
            )),
        child: DropdownButton<String>(
          value: _color,
          items: _listColor,
          underline: SizedBox.shrink(),
          hint: Text(
            'Select Color',
            style: textStyle(fontSize: 25, enableShadow: false),
          ),
          style: textStyle(fontSize: 25, enableShadow: false),
          onChanged: (value) {
            setState(() {
              _color = value;
            });
          },
        ),
      ),
    );
  }

  Widget _textField(TextEditingController _controller) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextField(
        controller: _controller,
        style: textStyle(
          enableShadow: false,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: 'Section Name',
          hintStyle: textStyle(enableShadow: false),
          helperText: 'ex. Chocolate Cakes',
          helperStyle: textStyle(
            enableShadow: false,
            fontSize: 20,
          ),
          border: OutlineInputBorder(
            gapPadding: 50,
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 50,
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white,
              width: 3,
              style: BorderStyle.solid,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            gapPadding: 50,
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: Colors.white60,
              width: 3,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }

  Widget _button({required String title, required Database database}) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        width: double.infinity,
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          boxShadow: _pressed
              ? [
                  BoxShadow(
                    color: Colors.white30,
                    offset: Offset.zero,
                  )
                ]
              : [],
        ),
        child: GestureDetector(
          onTapDown: (_) {
            setState(() {
              _pressed = true;
            });
          },
          onTapUp: (_) {
            setState(() {
              _pressed = false;
            });
            validate(database);
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: MyColorScheme.corn,
                borderRadius: BorderRadius.circular(40)),
            child: Center(
                child: Text(title,
                    style: textStyle(
                        fontSize: 25,
                        color: Colors.black87,
                        enableShadow: false))),
          ),
        ));
  }
}
