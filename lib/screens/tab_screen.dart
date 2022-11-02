import 'package:flutter/material.dart';
import 'package:momin_app/screens/good_quotes.dart';
import 'package:momin_app/screens/steps_counter.dart';
import '../widgets/barcode_qrcode.dart';
import '../widgets/main_drawer.dart';
import 'items_availabe.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: const Text(
            'Momin App',
            textAlign: TextAlign.center,
          ),

          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.shopping_cart),
                text: 'Items Available',
              ),
              Tab(
                  icon: Icon(Icons.qr_code_2_outlined),
                  text: 'Product QR Scan'),
              Tab(
                icon: Icon(Icons.production_quantity_limits),
                text: 'Suggest Your Product',
              ),
              Tab(icon: Icon(Icons.point_of_sale), text: 'Sales'),
              Tab(icon: Icon(Icons.food_bank), text: 'Users'),
              Tab(icon: Icon(Icons.format_quote), text: 'Good Words'),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.library_add),
              onPressed: () {
                Navigator.of(context).pushNamed('/add');
              },
            )
          ],
        ),
        body: const TabBarView(
          children: [
            ItemsAvailable(),
            BarCodeScanner(),
            Center(
              child: Icon(Icons.production_quantity_limits),
            ),
            Steps_Counter(),
            Center(
              child: Icon(Icons.food_bank),
            ),
            Good_Quotes(),
          ],
        ),
      ),
    );
  }
}
