import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:momin_app/screens/auth.dart';
import 'package:permission_handler/permission_handler.dart';
import '../modals/products.dart';

class AddForm extends StatefulWidget {
  final Function? addProduct;

  const AddForm({
    super.key,
    this.addProduct,
  });
}
//
// @override
// class



  @override
class _AddFormState extends State<AddForm> {

  TextEditingController qrController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _hasExpireDate = false;
  String? barResult;

  var _editValues = Products(
      id: DateTime.now().toString(),
      name: '',
      quantity: 0,
      price: 0,
      qr: '',
      expireDate: DateTime.now(),
      description: '');
  late DateTime _selectedDate;

  void _dateTimePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
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
      return
        setState(() {
          barResult = result;
        });
    }
    else {
      barResult = (await Permission.camera.status) as String?;
    }
  }
  void _addToList() {
    var isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();

    FirebaseFirestore.instance.collection('Users');
    Products(
        id: _editValues.id,
        name: _editValues.name,
        qr: _editValues.qr,
        price: _editValues.price,
        expireDate: _selectedDate,
        description: _editValues.description,
        quantity: _editValues.quantity);



  @override
  Widget build(BuildContext context) {
    //print(_selectedDate);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
          color: Colors.orangeAccent,
            child:
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length != 3) {
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
                      initialValue: barResult,
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
                    TextFormField( controller: qrController,
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

                    FloatingActionButton(
                      onPressed: _addToList,
                      splashColor: Colors.red[800],
                      child: const Text(
                          'Add',
                        style: TextStyle( color: Colors.black,
                      )
                      )

                    )
                  ],
                  )
                )
              ),

          ),
        );

  }

}

}






