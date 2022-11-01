 import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  final String id;
  final String name;
  final double price;
  double quantity;
  final DateTime? expireDate;
  final String qr;
  final String description;

  Products({
    required this.id,
    required this.name,
    required this.price,
    required this.expireDate,
    required this.qr,
    required this.description,
    required this.quantity,
  });

  factory Products.fromSnapshot(DocumentSnapshot docs) {
    return Products(
      id: DateTime.parse((docs['id'] as Timestamp).toDate().toString())
          .toLocal()
          .toString(),
      name: docs['name'],
      price: double.parse(docs['price']),
      expireDate: docs['expiry_date'] == null
          ? null
          : (docs['expiry_date'] as Timestamp).toDate(),
      qr: docs['qr'],
      description: docs['description'],
      quantity: double.parse(docs['quantity']),

      // this.id, this.name, this.price, this.expireDate, this.qr, this.description)
    );
  }
}
