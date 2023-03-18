import 'package:flutter/material.dart';

import '../../models/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/auth.dart';

List<dynamic> itemmock = [
  {"name": "banana", "price": "30", "quantity": "10"},
  {"name": "Apple", "price": "20", "quantity": "10"}
];

class Search extends StatefulWidget {
  const Search({super.key, required this.category});
  final String category;
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final DatabaseService _db = DatabaseService();
  final AuthService _auth = AuthService();
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
        listRes.add(value);
        value.forEach((key, value) {
          // print(value);
        });
      });
      // print(listRes);
      setState(() {
        // print(listRes);
        listData = listRes;
        // print(listData);
      });
    }

    // dynamic res = await _db.itemsbyCategory()
  }

  // @override
  int _counter = 1;

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //     print(_counter);
  //   });
  // }

  // void _decrementCounter() {
  //   setState(() {
  //     if (_counter > 1) {
  //       _counter--;
  //     }
  //   });
  // }

  void initState() {
    super.initState();
    // Initialize state variables here
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (listData.isEmpty) {
      // Show a CircularProgressIndicator if the data is still being fetched
      return Scaffold(
          appBar: AppBar(
            title: Text(widget.category),
          ),
          body: Center(
            child: Text('no data found'),
          ));
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          // itemCount: listData == null ? 1 : listData.length,
          itemCount: listData.length,
          itemBuilder: (context, index) {
            if (listData.isEmpty) {
              return Card(
                child: ListTile(
                  title: Text('no data found'),
                  subtitle: Text('no data found'),
                  trailing: Text('no data found'),
                  onTap: () {},
                ),
              );
            } else {
              return Card(
                  child: ListTile(
                title: Wrap(children: [
                  Text(listData[index]['name']),
                  SizedBox(
                    width: 10,
                  ),
                  Text(listData[index]['quantity'].toString()),
                  SizedBox(
                    width: 1000,
                  ),
                ]),
                //subtitle: Text(listData[index]['quantity'].toString()),
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
                                        IconButton(
                                          icon: Icon(
                                            Icons.remove_circle,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (_counter > 1) {
                                                _counter--;
                                              }
                                            });
                                          },
                                        ),
                                        Text(
                                          'Current value: $_counter',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add_circle,
                                            color: Colors.green,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _counter++;
                                            });
                                          },
                                        ),
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
                                    child: Text('Upadate Item'),
                                    onPressed: () {
                                      // Handle Ok button press
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              )));
                    },
                  );
                },
              ));
            }
          },
        ));
  }
}
