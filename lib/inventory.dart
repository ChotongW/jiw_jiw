// -----------------------------------------------------------------------------
// Inventory.dart
// -----------------------------------------------------------------------------
//
// This file contains functions for display inventory
// in inventory will have four features to use
// and every feature will navigate to their owns feature

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
        actions: [],
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
            onTap: () {
              Navigator.pushNamed(context, '/allitems');
            },
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.store_mall_directory,
                  size: 40,
                ),
                Text(
                  'All items',
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
              Navigator.pushNamed(context, '/delete');
            },
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
