import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('search'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            height: 60,
            width: 130,
            decoration: BoxDecoration(
                color: Color(0xffFFDDFF),
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(10)),
            child: Text('Search Item', style: TextStyle(fontSize: 15.6)),
          ),
          Container(
            decoration: BoxDecoration(
                color: Color(0xffDBEAFB),
                borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.search),
                Text(
                  'Search',
                  style: TextStyle(color: Color(0xffB3A7B7)),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xffF085CB),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "images/img1.jpg",
                  width: 50,
                  height: 50,
                ),
                Text(
                  "Fruit",
                  style: TextStyle(fontSize: 23),
                )
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(5)),
                  Row(
                    children: [Text('Item Name')],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(5)),
                  Row(
                    children: [Text('Price/unit')],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ],
              ))
            ],
          )
        ],
      )),
    );
  }
}
