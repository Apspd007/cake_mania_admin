import 'dart:math';

import 'package:cake_mania_admin/Materials.dart';
import 'package:cake_mania_admin/Models/CakeModel.dart';
import 'package:cake_mania_admin/Notifiers/CakeNotifier.dart';
import 'package:cake_mania_admin/Notifiers/SectionNotifier.dart';
import 'package:cake_mania_admin/Widgets/CakeCard.dart';
import 'package:cake_mania_admin/services/FirestoreDatabase.dart';
import 'package:cake_mania_admin/services/FirestoreStorage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddCake extends StatefulWidget {
  @override
  _AddCakeState createState() => _AddCakeState();
}

class _AddCakeState extends State<AddCake> {
  final TextEditingController _cakeName = TextEditingController();
  final TextEditingController _cakePrice = TextEditingController();
  final TextEditingController _details = TextEditingController();
  late final FilePickerResult? _pickerResult;
  // String? _ingrediant;
  // final List<DropdownMenuItem<String>> _listIngredients = [
  //   DropdownMenuItem(
  //     child: Text('Corn'),
  //     value: 'corn',
  //   ),
  //   DropdownMenuItem(
  //     child: Row(
  //       children: [
  //         Text('English Vermillion'),
  //       ],
  //     ),
  //     value: "englishVermillion",
  //   ),
  //   DropdownMenuItem(
  //     child: Text('Terra Cotta'),
  //     value: "terraCotta",
  //   ),
  // ];
  String _downloadUrl = "";

  bool _pressed = false;
  String _filePath = "";
  String _fileExtension = "";
  bool uploadCompleted = false;

  StorageBase _storageBase = MyStorage();

  String? _sectionName;
  List<DropdownMenuItem<String>> _sectionItems(
      SectionModelNotifier sectionModelList) {
    List<DropdownMenuItem<String>> list = [];
    sectionModelList.sectionNames.forEach((element) {
      list.add(DropdownMenuItem(
        child: Text(
          "$element",
          style: textStyle(enableShadow: false),
        ),
        value: "$element",
      ));
    });
    return list;
    // print(list);
  }

  void validate(Database database) {
    if (_cakeName.text != "" && _cakePrice.text != "" && _sectionName != null) {
      print('ok');
      database.addCakeToSection(
        _sectionName!,
        CakeModel(
          cakeId: DateTime.now().hashCode,
          imageUrl: _downloadUrl,
          name: _cakeName.text,
          price: double.tryParse(_cakePrice.text)!,
          details: _details.text,
        ),
      );
    } else {
      print("not ok");
    }
  }

  Future initFilePicker() async {
    _pickerResult = await FilePicker.platform.pickFiles();
    if (_pickerResult != null) {
      _filePath = _pickerResult!.files.single.path;
      _fileExtension = _pickerResult!.files.single.extension!;
    }
  }

  Future upload() async {
    final uploadTask = _storageBase.uploadFile(
        fileName: "image.$_fileExtension", filePath: _filePath);
    final snapshot = await uploadTask!.whenComplete(() {});
    _downloadUrl = await snapshot.ref.getDownloadURL();
    if (_downloadUrl != "") {
      print(_downloadUrl);
      setState(() {
        uploadCompleted = true;
      });
    } else {}
  }

  @override
  void dispose() {
    _cakeName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cakeNotifer = context.read<CakeNotifier>();
    final sectionModelList = context.read<SectionModelNotifier>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Add Cake',
                    style: textStyle(fontSize: 30),
                  ),
                ),
                _textField(
                  controller: _cakeName,
                  hintText: 'Cake Name',
                  textInputAction: TextInputAction.next,
                ),
                _textField(
                  controller: _cakePrice,
                  hintText: "Cake Price",
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                ),
                _selectImage(),
                _detailField(
                  controller: _details,
                  hintText: "Details",
                  textInputAction: TextInputAction.done,
                ),
                _selectSection(context, sectionModelList),
                //  Add Cake Button
                SizedBox(height: 60.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _button(
                    title: "Add Cake",
                    context: context,
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _selectSection(
      BuildContext context, SectionModelNotifier sectionModelList) {
    return Container(
      height: 65.h,
      width: MediaQuery.of(context).size.width / 2 + 20.w,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white70,
          width: 3,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          child: DropdownButton<String>(
            value: _sectionName,
            items: _sectionItems(sectionModelList),
            hint: Text("Select Section", style: textStyle(enableShadow: false)),
            iconSize: 35,
            iconEnabledColor: Colors.white,
            underline: SizedBox.shrink(),
            onChanged: (value) {
              setState(() {
                _sectionName = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Padding _selectImage() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _filePicker(),
          _uploadButton(),
        ],
      ),
    );
  }

  Expanded _filePicker() {
    return Expanded(
      child: Container(
        height: 60,
        padding: EdgeInsets.only(right: 20),
        child: OutlinedButton(
          onPressed: initFilePicker,
          child: Text("Select a picture",
              style: textStyle(enableShadow: false, fontSize: 25)),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
            side: MaterialStateProperty.all<BorderSide?>(BorderSide(
                color: Colors.white, width: 3, style: BorderStyle.solid)),
          ),
        ),
      ),
    );
  }

  SizedBox _uploadButton() {
    return SizedBox(
      height: 50,
      width: 80,
      child: OutlinedButton(
          style: ButtonStyle(),
          onPressed: upload,
          child: Icon(
            uploadCompleted ? Icons.close_rounded : Icons.upload_rounded,
            color: Colors.white,
            size: 40,
          )),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    required TextInputAction textInputAction,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        style: textStyle(
          enableShadow: false,
          fontSize: 20,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: textStyle(enableShadow: false),
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

  Widget _detailField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    required TextInputAction textInputAction,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: 6,
        textInputAction: textInputAction,
        style: textStyle(
          enableShadow: false,
          fontSize: 23,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: textStyle(enableShadow: false),
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

  Widget _button({required String title, required BuildContext context}) {
    final database = Provider.of<Database>(context);
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
            Navigator.pop(context);
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
