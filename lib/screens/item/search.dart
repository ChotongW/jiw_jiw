// -----------------------------------------------------------------------------
// search.dart
//Thanadol Panya 630510623  (Feature should have: Favorite items)
// -----------------------------------------------------------------------------
//
// This file contains functions for search items
// it will get data from firebase and for current user
// it will search name and show items detail

import 'package:flutter/material.dart';

import '../../models/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/auth.dart';
import '../appbar/appbar.dart';

// -----------------------------------------------------------------------------
// search
//Thanadol Panya 630510623  (Feature should have: Favorite items)
// -----------------------------------------------------------------------------
//
// search class is will get data from firebase and for current user
// it will search name and show items detail
// in listviwe will return card to show
// in every card we can incress or decress quntity of item
// and in the card will clike to favorite items
// and it will set state favorite from unfavorited to favorite
// the color of icons will be changed to red

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

// get data and set initState
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
          appBar: MyAppBar(
            title: widget.category,
            actions: [],
          ),
          body: Center(
            child: Text('no data found'),
          ));
    }
    return Scaffold(
        appBar: MyAppBar(
          title: widget.category,
          actions: [],
        ),
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
                SizedBox(
                  width: 1000,
                ),
              ]),
              leading: Text(
                "${listData[index]['price'].toString()} ฿",
                style: TextStyle(
                  color: Colors.blue, // set text color to blue
                  fontSize: 16.0, // set font size to 18
                  fontWeight: FontWeight.w500, // set font weight to bold
                  fontStyle: FontStyle.normal, // set font style to italic
                ),
              ),
              subtitle: Text("itemID: ${listData[index]['itemID']}"),
              trailing: Wrap(children: [
                Text(
                  "QTY:${listData[index]['quantity'].toString()}",
                  style: TextStyle(
                    color: Colors.blue, // set text color to blue
                    fontSize: 14.0, // set font size to 18
                    fontWeight: FontWeight.w400, // set font weight to bold
                    fontStyle: FontStyle.normal, // set font style to italic
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  listData[index]['favorite'] == false
                      ? Icons.favorite_border
                      : Icons.favorite,
                  color:
                      listData[index]['favorite'] == false ? null : Colors.red,
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
                                          quantity: listData[index]['counter']);

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
                                      listData[index]['favorite'] == false
                                          ? 'Favorites'
                                          : 'Unfavorite',
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        listData[index]['favorite'] =
                                            !listData[index]['favorite'];
                                        // print(listData[index]['favorite']);
                                      });
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
                                        bool res = await _db.updateFav(
                                            userId: result.uid.toString(),
                                            itemID: listData[index]['itemID'],
                                            favorite: listData[index]
                                                ['favorite']);

                                        Navigator.of(context).pop();
                                        Navigator.pushReplacementNamed(
                                            context, '/${widget.category}');
                                      }
                                    }),
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
