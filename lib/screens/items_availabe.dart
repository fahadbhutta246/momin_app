import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../modals/products.dart';

class ItemsAvailable extends StatefulWidget {
  const ItemsAvailable({Key? key}) : super(key: key);

  @override
  State<ItemsAvailable> createState() => _ItemsAvailableState();
}

class _ItemsAvailableState extends State<ItemsAvailable> {
  final db = FirebaseFirestore.instance;

  List<Products> productList = [];

  void getProducts() async {
    var productsFromFirebase = await db.collection("products").get();
    print('fahad $productsFromFirebase');

    print(productsFromFirebase);
    if (productsFromFirebase.docs.isNotEmpty) {
      productList.clear();
      for (var doc in productsFromFirebase.docs) {
        productList.add(Products.fromSnapshot(
            doc)); //without '.data()' because you have it in your model.
      }
    } //prints the length of your products list.
  }

  Future<void> refreshList() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      getProducts();
      print(productList);
    });
  }

  @override
  void initState() {
    refreshList();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    print(productList);

    return RefreshIndicator(
      onRefresh: refreshList,
      child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index) {
            // return ListTile(
            //   title: Text("${snapshot.data?.docs[index]['name']}"),
            // );
            return _buildProductsList(productList[index]);
          }),
    );
  }

  Widget _buildProductsList(Products items) {
    return Card(
      child: ExpansionTile(
          title: Text(
            items.name,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
          ),
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                "Price: ${items.price} - Quantity: ${items.quantity}",
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              leading: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  FirebaseFirestore.instance.collection('Sales');
                },
              ),
            ),
          ]),
    );
  }
}
