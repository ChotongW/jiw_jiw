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
        listData = listRes;
      });
    }

    // dynamic res = await _db.itemsbyCategory()
  }

  @override
  void initState() {
    super.initState();
    // Initialize state variables here
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (listData == null) {
      // Show a CircularProgressIndicator if the data is still being fetched
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
        ),
        body: ListView.builder(
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
                  title: Text(listData[index]['name']),
                  subtitle: Text(listData[index]['quantity'].toString()),
                  trailing: Text(listData[index]['price'].toString()),
                  onTap: () {},
                ),
              );
            }
          },
        ));
  }
}
