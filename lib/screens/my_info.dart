import 'package:flutter/material.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({Key? key}) : super(key: key);

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
          appBar: AppBar(title: const Text('DEVELOPER\'s INFORMATION'),),
          body: Column(
            children: [

              const Text('My Name Is Fahad'),
              Container(
                height: 120.0,
                width: 120.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assests/images/fadii.png'),
                    fit: BoxFit.fill,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              Container(

                  child: TextButton(child: const Text('Fahad\'s Contact'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/cont');
                    },)
              ),
            ],

          )
      ),
    );
  }
}
