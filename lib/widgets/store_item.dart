import 'package:flutter/material.dart';

class StoreItem extends StatelessWidget {
  final String id;
  final String name;
  final double price;
  final double quantity;
  final String qr;

  const StoreItem({super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.qr,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: (){
              Navigator.of(context).pushNamed('/items',arguments: id);
            },
            splashColor: Colors.black45,
            child: Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                Container(
                  width: 170,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                  ),
                    child: Hero(
                        tag: id,
                        child: const FadeInImage(
                          placeholder: AssetImage('assets/images/box.png'),
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/box.png'),
                        ),
                    ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      color: Colors.black.withOpacity(0.3),
                      child: Text(
                          name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Architect',
                            color: Colors.white
                          ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        color: Colors.black.withOpacity(0.3),
                        child: Text(
                            quantity.toInt().toString(),
                          textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Architect',
                              color: Colors.white
                            ),
                        ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          child: InkWell(
            onTap: (){

            },
            child: const Icon(
                Icons.add_shopping_cart,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
