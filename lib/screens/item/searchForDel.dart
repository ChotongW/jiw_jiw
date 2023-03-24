// -----------------------------------------------------------------------------
// searchForDel.dart
// -----------------------------------------------------------------------------
//
// This file contains functions for search items in delete
// it will get data from firebase and if for current user
// it will search name and show items detail

import 'package:flutter/material.dart';

import '../../models/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/auth.dart';

List<dynamic> itemmock = [
  {"name": "banana", "price": "30", "quantity": "10"},
  {"name": "Apple", "price": "20", "quantity": "10"}
];

// -----------------------------------------------------------------------------
// searchForDel
// -----------------------------------------------------------------------------
//
// search class is will get data from firebase and for current user
// it will search name and show items detail
// in listviwe will return card to show
// in every card we can incress or decress quntity of item

class SearchForDel extends StatefulWidget {
  const SearchForDel({super.key, required this.category});
  final String category;
  @override
  State<SearchForDel> createState() => _SearchForDelState();
}

class _SearchForDelState extends State<SearchForDel> {
  final DatabaseService _db = DatabaseService();
  final AuthService _auth = AuthService();
  int _counter = 1;
  List<dynamic> listData = [];

  Future<void> getData() async {
    List<dynamic>? listRes = [];
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
      await Navigator.pushReplacementNamed(context, '/auth');
    } else {
      // print(item.category);
      Map? data = await _db.itemsbyCategory(
        userId: result.uid.toString(),
        category: widget.category,
      );
      // print(data.runtimeType);
      data?.forEach((key, value) {
        // print(key);
        value["itemID"] = key;
        listRes.add(value);
      });
      for (var map in listRes) {
        map["counter"] =
            map['quantity']; // initialize the counter to 0 for each map
      }
      // print(listRes);
      setState(() {
        // print(listRes);
        listData = listRes;
        // print(listData);
      });
    }

    // dynamic res = await _db.itemsbyCategory()
  }

  void initState() {
    super.initState();
    // Initialize state variables here
    getData();
  }

  @override
  void didUpdateWidget(SearchForDel oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Load data based on new dropdown value
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (listData.isEmpty) {
      // Show a CircularProgressIndicator if the data is still being fetched
      return Scaffold(
          body: Center(
        child: Text('no data found'),
      ));
    }
    return Scaffold(
        body: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      // itemCount: listData == null ? 1 : listData.length,
      itemCount: listData.length,
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
          title: Wrap(children: [
            Text(listData[index]['name']),
            SizedBox(
              width: 10,
            ),
            Text(listData[index]['price'].toString()),
            SizedBox(
              width: 1000,
            ),
          ]),
          subtitle: Text("itemID: ${listData[index]['itemID']}"),
          trailing: Wrap(children: [
            Text(listData[index]['quantity'].toString()),
            SizedBox(
              width: 10,
            ),
          ]),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // Create the AlertDialog widget
                return StatefulBuilder(
                    builder: ((context, setState) => AlertDialog(
                          title: Text(listData[index]['name']),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  // IconButton(
                                  //   icon: Icon(
                                  //     Icons.remove_circle,
                                  //     color: Colors.red,
                                  //   ),
                                  //   onPressed: () {
                                  //     setState(() {
                                  //       if (_counter > 1) {
                                  //         _counter--;
                                  //       }
                                  //     });
                                  //   },
                                  // ),
                                  Text(
                                    'Current stocks: ${listData[index]['counter']}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  // IconButton(
                                  //   icon: Icon(
                                  //     Icons.add_circle,
                                  //     color: Colors.green,
                                  //   ),
                                  //   onPressed: () {
                                  //     setState(() {
                                  //       _counter++;
                                  //     });
                                  //   },
                                  // ),
                                ],
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancle'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Delete item'),
                              onPressed: () async {
                                // Handle Ok button press
                                User? result = await _auth.currentUser;
                                if (result == null) {
                                  //null means unsuccessfull authentication
                                  await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content:
                                              Text('not found current user!'),
                                        );
                                      });

                                  await Navigator.pushReplacementNamed(
                                      context, '/auth');
                                } else {
                                  bool res = await _db.deleteItem(
                                    userId: result.uid.toString(),
                                    itemID: listData[index]['itemID'],
                                  );
                                  print(res);
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacementNamed(
                                      context, '/delete');
                                  setState(() {
                                    for (var map in listData) {
                                      map.remove(
                                          "counter"); // remove the "counter" key-value pair from each map
                                    }
                                  });
                                }
                              },
                            ),
                          ],
                        )));
              },
            );
          },
        ));
      },
    ));
  }
}
