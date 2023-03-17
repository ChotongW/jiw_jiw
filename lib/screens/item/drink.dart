import 'package:flutter/material.dart';

import '../appbar/appbar.dart';

class Drink extends StatefulWidget {
  const Drink({super.key});

  @override
  State<Drink> createState() => _DrinkState();
}

class _DrinkState extends State<Drink> {
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
      appBar: MyAppBar(
        title: "Drink",
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
                    Navigator.pushNamed(context, myProducts[index]);
                    // Navigator.pushNamed(context, 'Drink');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Search()),
                    // );
                  },
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(myProducts[index])],
                  )),
                ),
              );
            }),
      ),
    );
  }
}
