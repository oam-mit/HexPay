import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hexpay/backend/views/authview.dart';
import 'package:hexpay/frontend/widgets/SpinnerWidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BusinessType {
  String type;
  BusinessType(this.type);

  static List<BusinessType> getBusinessTypes() {
    List<BusinessType> _list = [
      BusinessType('Groceries'),
      BusinessType('Stationery'),
      BusinessType('Fruits'),
      BusinessType('General Store'),
      BusinessType('Medical Store')
    ];

    return _list;
  }
}

class ShopRegisterScreen extends StatefulWidget {
  @override
  _ShopRegisterScreenState createState() => _ShopRegisterScreenState();
}

class _ShopRegisterScreenState extends State<ShopRegisterScreen> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _upiIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _shopNameController = TextEditingController();
  TextEditingController _gstNumberController = TextEditingController();
  TextEditingController _landmarkController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  String _selectedBusinessType;

  File _image;
  final _picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  List<DropdownMenuItem<String>> getBusinessTypes() {
    List<BusinessType> _list = BusinessType.getBusinessTypes();
    List<DropdownMenuItem<String>> _itemList = [];

    for (var type in _list) {
      _itemList.add(DropdownMenuItem<String>(
        child: Text(type.type),
        value: type.type,
      ));
    }

    return _itemList;
  }

  void selectBusinessType(String value) {
    this.setState(() {
      _selectedBusinessType = value;
    });
  }

  Future<Map<String, dynamic>> _getMappedInputs() async {
    print(_image.path);
    return {
      'first_name': _firstNameController.text,
      'last_name': _lastNameController.text,
      'email': _emailController.text,
      'upi_id': _upiIdController.text,
      'password': _passwordController.text,
      'shop_name': _shopNameController.text,
      'gst_number': _gstNumberController.text,
      'landmark': _landmarkController.text,
      'city': _cityController.text,
      'pin_code': _pinCodeController.text,
      'type_of_business': _selectedBusinessType,
      'phone': _phoneController.text,
      'image': await MultipartFile.fromFile(_image.path,
          filename: _image.path.split('/').last)
    };
  }

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'Shop Registration',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                      hintText: 'First Name',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                      hintText: 'Last Name',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                  decoration: InputDecoration(
                      hintText: 'Phone',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _upiIdController,
                  decoration: InputDecoration(
                      hintText: 'UPI ID',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _shopNameController,
                  decoration: InputDecoration(
                      hintText: 'Shop Name',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _gstNumberController,
                  decoration: InputDecoration(
                      hintText: 'GST Number',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _landmarkController,
                  decoration: InputDecoration(
                      hintText: 'Landmark',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(
                      hintText: 'City',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _pinCodeController,
                  decoration: InputDecoration(
                      hintText: 'Pincode',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButton<String>(
                  items: this.getBusinessTypes(),
                  hint: Text('Select Business Type'),
                  onChanged: this.selectBusinessType,
                  isExpanded: true,
                  underline: SizedBox(),
                  value: this._selectedBusinessType,
                ),
                ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text(
                        _image != null ? 'Image selected' : 'Select image'),
                    onTap: () {
                      _getImage();
                    }),
                !authView.loading
                    ? ElevatedButton.icon(
                        onPressed: () async {
                          authView.customerShop(await _getMappedInputs());
                        },
                        icon: Icon(Icons.send),
                        label: Text('Submit'))
                    : SpinnerWidget(),
              ],
            ),
          ),
        ));
  }
}
