// -----------------------------------------------------------------------------
// delete.dart
// -----------------------------------------------------------------------------
//
// This file contains functions for delete items in firebase
// it will get data from firebase and if it not same id items will not the same
// And it will display all items with out filters and in every items can
// incress or decress quantity and put favorite items on it

import 'package:flutter/material.dart';
import 'package:project_mobile_app/models/item.dart';
import 'package:project_mobile_app/screens/item/searchForDel.dart';
import '../appbar/appbar.dart';

class delete extends StatefulWidget {
  const delete({super.key});

  @override
  State<delete> createState() => _deleteState();
}

class _deleteState extends State<delete> {
  final _key = GlobalKey<FormState>();
  late String itemSelect = 'drink';
  List catagory = [
    'drink',
    'fresh meal',
    'snacks',
    'frozen & processed food',
    'pets',
    'household goods',
    'shower',
    'mom and kids',
    'fresh product',
  ];
  @override
  void initState() {
    super.initState();
    // Initialize any state that the widget needs
    item.category = itemSelect;
  }

  Item item = Item(name: '', category: '', price: 0, quantity: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: 'Delete items',
          actions: [],
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: 'item name',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                        keyboardType: TextInputType.name,
                        onSaved: (String? name) {
                          item.name = name!;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    DropdownButton(
                      value: itemSelect,
                      items: catagory
                          .map((itemSelect) => DropdownMenuItem(
                              value: itemSelect, child: Text(itemSelect)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          itemSelect = value.toString();
                          item.category = itemSelect;
                        });
                        // print(itemSelect);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: SearchForDel(
                category: item.category,
              ),
            ),
          ],
        ));
  }
}
