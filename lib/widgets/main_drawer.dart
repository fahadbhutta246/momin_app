import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.blueAccent,
            height: 150,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
                'Keep It Real! :)',
              style: TextStyle(
                fontFamily: 'Fredrika',
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text('Available Products'),
            onTap: (){
              Navigator.of(context).pushNamed('/main');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.point_of_sale_sharp),
            title: Text('Total Sales'),
            onTap: (){
              Navigator.of(context).pushNamed('/sale');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.contact_phone),
            title: Text('Hamza\'s Contact'),
            onTap: (){
              Navigator.of(context).pushNamed('/contact');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.developer_board),
            title: Text('About The Developer'),
            onTap: (){
              Navigator.of(context).pushNamed('/mine');
            },
          )
        ],
      ),
    );
  }
}
