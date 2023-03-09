import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_mobile_app/screens/appbar/appbar.dart';

class Stock extends StatefulWidget {
  const Stock({super.key});

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Inventory",
      ),
      body: GridView.count(crossAxisCount: 2, children: [
        Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/catagory');
            },
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  size: 40,
                ),
                Text(
                  'search & catagory',
                  style: TextStyle(fontSize: 15),
                )
              ],
            )),
          ),
        ),
        Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/addItem');
            },
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.create,
                  size: 40,
                ),
                Text(
                  'Create items list',
                  style: TextStyle(fontSize: 15),
                )
              ],
            )),
          ),
        ),
        Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: InkWell(
            onTap: () {},
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete,
                  size: 40,
                ),
                Text(
                  'Delete items',
                  style: TextStyle(fontSize: 15),
                )
              ],
            )),
          ),
        )
      ]),
    );
  }
}
