import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/database.dart';
import '../models/item.dart';
import '../screens/appbar/appbar.dart';
import 'auth.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController _textController = TextEditingController();
  final AuthService _auth = AuthService();
  final DatabaseService _db = DatabaseService();
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

  Item item = Item(name: '', category: '', price: 0, quantity: 0);

  @override
  void initState() {
    super.initState();
    // Initialize any state that the widget needs
    item.category = itemSelect;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'add item',
      ),
      body: Container(
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
                      hintText: 'Item name',
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Item price',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (String? price) {
                      item.price = int.parse(price!);
                    }),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Item quantity',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (String? quantity) {
                      item.quantity = int.parse(quantity!);
                    }),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Confirm'),
                    onPressed: () async {
                      _key.currentState!.save();
                      try {
                        User? result = await _auth.currentUser;

                        if (result == null) {
                          //null means unsuccessfull authentication
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('not found current user!'),
                                );
                              });
                          await Navigator.pushReplacementNamed(
                              context, '/auth');
                        } else {
                          // print(item.category);
                          bool res = await _db.writeItem(
                            userId: result.uid.toString(),
                            // category: item.category,
                            data: {
                              'name': item.name,
                              'price': item.price,
                              'quantity': item.quantity,
                              'category': item.category,
                              'favorite': item.isFav
                            },
                          );
                          if (res == true) {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text("Add item successfully"),
                                  );
                                });
                          } else {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text("Item already exists"),
                                  );
                                });
                          }

                          // Navigator.pushReplacementNamed(context, '/auth');
                        }
                      } catch (e) {
                        print(e.toString());
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(e.toString()),
                              );
                            });
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width * 0.15,
                  onPressed: () {
                    // Navigate to a new page
                    // Navigator.pop(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginScreen()),
                    // );
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Text(
                      'Cancel',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
