import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../modals/products.dart';

class AddForm extends StatefulWidget {
  final Function? addProduct;

  const AddForm({
    super.key,
    this.addProduct,
  });

  @override
  State<StatefulWidget> createState() => _AddFormState();

// @override
// _AddFormState createState() => _AddFormState();
}

@override
class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  var _hasExpireDate = false;
  String? barResult;

  var name = TextEditingController();
  var price = TextEditingController();
  var quantity = TextEditingController();
  var description = TextEditingController();
  var qr = TextEditingController();

  Products _editValues = Products(
      id: DateTime.now().toString(),
      name: '',
      quantity: 0,
      price: 0,
      qr: '',
      expireDate: DateTime.now(),
      description: '');
  DateTime? _selectedDate;

  void _dateTimePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2099),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  Future barCodeScanner() async {
    String result;
    var status = await Permission.camera.status;
    try {
      result = await FlutterBarcodeScanner.scanBarcode(
          "#FFBF00", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      result = "Failed to get platform version";
    }
    if (status.isGranted) {
      return setState(() {
        qr.text = result;
      });
    } else {
      qr.text = ((await Permission.camera.status) as String?)!;
    }
  }

  void _addToList() {
    var isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();

    Products(
        id: _editValues.id,
        name: _editValues.name,
        qr: _editValues.qr,
        price: _editValues.price,
        expireDate: _selectedDate,
        description: _editValues.description,
        quantity: _editValues.quantity);
  }

  @override
  Widget build(BuildContext context) {
    //print(_selectedDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('ENTER YOUR PRODUCT HERE'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter valid name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: 'product name',
                        labelStyle: TextStyle(fontFamily: 'Architect')),
                    onSaved: (value) {
                      _editValues = Products(
                        id: _editValues.id,
                        name: value!,
                        description: _editValues.description,
                        expireDate: _editValues.expireDate,
                        qr: _editValues.qr,
                        price: _editValues.price,
                        quantity: _editValues.quantity,
                      );
                    },
                  ),
                  TextFormField(
                    controller: price,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter valid price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'enter valid price';
                      }
                      if (double.tryParse(value)! <= 0) {
                        return 'enter valid price';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'price',
                        labelStyle: TextStyle(fontFamily: 'Architect')),
                    onSaved: (value) {
                      _editValues = Products(
                        id: _editValues.id,
                        name: _editValues.name,
                        description: _editValues.description,
                        expireDate: _editValues.expireDate,
                        qr: _editValues.qr,
                        price: double.parse(value!),
                        quantity: _editValues.quantity,
                      );
                    },
                  ),
                  TextFormField(
                    controller: quantity,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter valid quantity';
                      }
                      if (double.tryParse(value) == null) {
                        return 'enter valid quantity';
                      }
                      if (double.tryParse(value)! <= 0) {
                        return 'enter valid quantity';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        labelText: 'quantity',
                        labelStyle: TextStyle(fontFamily: 'Architect')),
                    onSaved: (value) {
                      _editValues = Products(
                        id: _editValues.id,
                        name: _editValues.name,
                        description: _editValues.description,
                        expireDate: _editValues.expireDate,
                        qr: _editValues.qr,
                        price: _editValues.price,
                        quantity: double.parse(value!),
                      );
                    },
                  ),
                  TextFormField(
                    controller: description,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter valid description';
                      }
                      if (value.length < 5) {
                        return 'enter valid description';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    decoration: const InputDecoration(
                        labelText: 'description',
                        labelStyle: TextStyle(fontFamily: 'Architect')),
                    onSaved: (value) {
                      _editValues = Products(
                        id: _editValues.id,
                        name: _editValues.name,
                        description: value!,
                        expireDate: _editValues.expireDate,
                        price: _editValues.price,
                        quantity: _editValues.quantity,
                        qr: '',
                      );
                    },
                  ),
                  TextFormField(
                    controller: qr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter valid barcode';
                      }
                      if (double.tryParse(value)! < 0) {
                        return 'enter valid barcode';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'QR Code Of The Product',
                        labelStyle: TextStyle(fontFamily: 'Architect')),
                    onSaved: (value) {
                      _editValues = Products(
                        id: _editValues.id,
                        name: _editValues.name,
                        description: _editValues.description,
                        expireDate: _editValues.expireDate,
                        qr: value!,
                        price: _editValues.price,
                        quantity: _editValues.quantity,
                      );
                    },
                  ),
                  MaterialButton(
                    onPressed: barCodeScanner,
                    child: const Text("Scan Product Here"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: _hasExpireDate
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Switch(
                            value: _hasExpireDate,
                            onChanged: (value) {
                              setState(() {
                                _hasExpireDate = !_hasExpireDate;
                              });
                            },
                            activeColor: Colors.pink,
                          ),
                          const Text(
                            'has expire date',
                            style: TextStyle(fontFamily: 'Architect'),
                          )
                        ],
                      ),
                      _hasExpireDate
                          ? TextButton(
                              onPressed: _dateTimePicker,
                              child: const Text(
                                'select date',
                                style: TextStyle(fontFamily: 'Architect'),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                    onPressed: () {
                      _addToList();

                      final product = <String, dynamic>{
                        "id": DateTime.now(),
                        "name": name.text,
                        "price": price.text,
                        "quantity": quantity.text,
                        "description": description.text,
                        "qr": qr.text,
                        "expiry_date": _selectedDate,
                      };

                      debugPrint("${product.toString()} in");

                      FirebaseFirestore.instance
                          .collection("products")
                          .doc(name.text)
                          .set(product)
                          .onError((e, _) =>
                              debugPrint("Error writing document: $e"));
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
