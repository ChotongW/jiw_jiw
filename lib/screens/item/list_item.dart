import 'package:flutter/material.dart';
import 'package:project_mobile_app/screens/item/search.dart';

import '../appbar/appbar.dart';

class itemList extends StatefulWidget {
  const itemList({super.key});

  @override
  State<itemList> createState() => _itemListState();
}

class _itemListState extends State<itemList> {
  final List<String> myProducts = [
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
  // final List<dynamic> myProducts = [
  //   {'drink': 'drink'},
  //   {
  //     'fresh meal': 'freshMeal',
  //   },
  //   {
  //     'snacks': 'snacks',
  //   },
  //   {
  //     'frozen & processed food': 'frozenFood',
  //   },
  //   {
  //     'pets': 'pets',
  //   },
  //   {
  //     'household goods': 'household',
  //   },
  //   {
  //     'shower': 'shower',
  //   },
  //   {
  //     'mom and kids': 'baby',
  //   },
  //   {
  //     'fresh product': 'fresh',
  //   },
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Category", actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // implement GridView.builder
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 500,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: myProducts.length,
            itemBuilder: (BuildContext ctx, index) {
              return Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: InkWell(
                  onTap: () async {
                    // await showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         content: Text(myProducts[index]
                    //             [myProducts[index].keys.elementAt(0)]),
                    //       );
                    //     });
                    // Navigator.pushNamed(context,
                    //     '/${myProducts[index][myProducts[index].keys.elementAt(0)]}');
                    print('/${myProducts[index]}');
                    Navigator.pushNamed(context, '/${myProducts[index]}');

                    // Navigator.pushNamed(context, 'Drink');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //           Search(category: myProducts[index])),
                    // );
                  },
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        size: 40,
                      ),
                      // Text(myProducts[index].keys.elementAt(0))
                      Text(myProducts[index])
                    ],
                  )),
                ),
              );
            }),
      ),
    );
  }
}
