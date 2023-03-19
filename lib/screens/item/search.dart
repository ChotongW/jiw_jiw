import 'package:flutter/material.dart';

import '../../models/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/auth.dart';

List<dynamic> itemmock = [
  {"name": "banana", "price": "30", "quantity": "10", "isFav": false},
  {"name": "Apple", "price": "20", "quantity": "10", "isFav": false}
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
        value["itemID"] = key;
        listRes.add(value);
        // value.forEach((key, value) {
        //   // print(value);
        // });
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

  // @override

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
                  Icon(
                    itemmock[index]['isFav'] == null ||
                            itemmock[index]['isFav'] == false
                        ? Icons.favorite_border
                        : Icons.favorite,
                    color: itemmock[index]['isFav'] == null ||
                            itemmock[index]['isFav'] == false
                        ? null
                        : Colors.red,
                    size: 18,
                  )
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
                                              if (listData[index]['counter'] >
                                                  1) {
                                                listData[index]['counter']--;
                                              }
                                            });
                                          },
                                        ),
                                        Text(
                                          'Current value: ${listData[index]['counter']}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.add_circle,
                                            color: Colors.green,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              listData[index]['counter']++;
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
                                      setState(() {
                                        listData[index]['counter'] =
                                            listData[index]['quantity'];
                                      });

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Upadate Item'),
                                    onPressed: () async {
                                      User? result = await _auth.currentUser;
                                      if (result == null) {
                                        //null means unsuccessfull authentication
                                        await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Text(
                                                    'not found current user!'),
                                              );
                                            });

                                        await Navigator.pushReplacementNamed(
                                            context, '/auth');
                                      } else {
                                        bool res = await _db.updateItem(
                                            userId: result.uid.toString(),
                                            itemID: listData[index]['itemID'],
                                            quantity: listData[index]
                                                ['counter']);
                                        print(res);
                                        // if (res == true) {
                                        //   await showDialog(
                                        //       context: context,
                                        //       builder: (context) {
                                        //         return AlertDialog(
                                        //           content: Text(
                                        //               "Add item successfully"),
                                        //         );
                                        //       });
                                        // } else {
                                        //   await showDialog(
                                        //       context: context,
                                        //       builder: (context) {
                                        //         return AlertDialog(
                                        //           content: Text(
                                        //               "Item already exists"),
                                        //         );
                                        //       });
                                        //
                                        Navigator.of(context).pop();

                                        Navigator.pushReplacementNamed(
                                            context, '/${widget.category}');
                                        setState(() {
                                          for (var map in listData) {
                                            map.remove(
                                                "counter"); // remove the "counter" key-value pair from each map
                                          }
                                        });
                                      }
                                      // Handle Ok button press
                                    },
                                  ),
                                  TextButton(
                                      child: Text(
                                        itemmock[index]['isFav'] == null ||
                                                itemmock[index]['isFav'] ==
                                                    false
                                            ? 'Add to Favorites'
                                            : 'Unfavorite',
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          itemmock[index]['isFav'] =
                                              !itemmock[index]['isFav'];
                                          print(itemmock[index]['isFav']);
                                        });
                                        Navigator.of(context).pop();
                                        Navigator.pushReplacementNamed(
                                            context, '/${widget.category}');
                                      }),
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
