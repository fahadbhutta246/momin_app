import 'package:flutter/material.dart';

class Products{
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
}