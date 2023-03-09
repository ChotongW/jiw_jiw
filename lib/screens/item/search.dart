import 'package:flutter/material.dart';

List<dynamic> itemmock = [
  {"name": "banana", "price": "30", "quantity": "10"},
  {"name": "Apple", "price": "20", "quantity": "10"}
];

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SearchItem'),
        ),
        body: ListView.builder(
          itemCount: itemmock.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(itemmock[index]['name']),
                subtitle: Text(itemmock[index]['quantity']),
                trailing: Text(itemmock[index]['price']),
                onTap: () {},
              ),
            );
          },
        ));
  }
}
