import 'package:flutter/material.dart';

class itemList extends StatefulWidget {
  const itemList({super.key});

  @override
  State<itemList> createState() => _itemListState();
}

class _itemListState extends State<itemList> {
  @override
  final List<String> myProducts = [
    'Drink',
    'Fresh meal',
    'Snacks',
    'Frozen & Processed Food',
    'Pets',
    'Household Goods',
    'Shower',
    'Mom and kids',
    'Fresh Product',
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category '),
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
                    //         content: Text(myProducts[index].toString()),
                    //       );
                    //     });
                    Navigator.pushNamed(context, '/search');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Search()),
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
