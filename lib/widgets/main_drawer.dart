import 'package:flutter/material.dart';

import '../screens/auth.dart';

class MainDrawer extends StatelessWidget {
  MainDrawer({super.key});

  var authHandler = Auth();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.blueAccent,
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: const Text(
              'Keep It Real! :)',
              style: TextStyle(
                fontFamily: 'Fredrik',
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shopping_basket),
            title: const Text('Available Products'),
            onTap: () {
              Navigator.of(context).pushNamed('/main');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.point_of_sale_sharp),
            title: const Text('Total Sales'),
            onTap: () {
              Navigator.of(context).pushNamed('/sale');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.contact_phone),
            title: const Text('Hamza\'s Contact'),
            onTap: () {
              Navigator.of(context).pushNamed('/contact');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.developer_board),
            title: const Text('About The Developer'),
            onTap: () {
              Navigator.of(context).pushNamed('/mine');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.developer_board),
            title: const Text('Sign Out'),
            onTap: () async {
              String result = await authHandler.signOut();
              if (result == "true") {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (_) => false);
              } else {
                final snackBar = SnackBar(
                  content: Text(result),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
          )
        ],
      ),
    );
  }
}
