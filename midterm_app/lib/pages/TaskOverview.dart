import 'dart:typed_data';

import 'package:flutter/material.dart';

class TaskOverview extends StatefulWidget {
  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<TaskOverview> {
  String? _message = '';

  final List<String> entries = <String>[
    'Go to hospital \n\n DETAIL : \nGo to vaccinated.',
    'Watering a plant \n\n DETAIL : \nWatering just cactus and banana.',
    'Read final exam \n\n DETAIL : \nOne night miracle.',
  ];
  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TO DO LIST'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline_sharp),
            tooltip: 'Add Task',
            onPressed: () async {
              var response = await Navigator.pushNamed(context, '/6');
              setState(() {
                _message = response.toString();
              });
              if (_message != '') {
                entries.add(_message!);
                print(_message!.runtimeType);
              }
            },
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(8.0),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return ProductTile(
            item: ProductItem(
              name: entries[index],
              price: '\$25',
              colorShade: colorCodes[index % 3],
            ),
          );
        },
        separatorBuilder: (context, int) => Divider(),
      ),
    );
  }
}

class ProductItem {
  final String name;
  final String price;
  final int colorShade;

  const ProductItem(
      {Key? key,
      required this.name,
      required this.price,
      required this.colorShade});
}

class ProductTile extends StatelessWidget {
  final ProductItem item;
  const ProductTile({
    Key? key,
    required this.item,
  }) : super(key: key);
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(item: item),
          ),
        );
      },
      child: Container(
        height: 100.0,
        color: Colors.amber[item.colorShade],
        child: Center(
          child: Text('${item.name}'),
        ),
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final ProductItem item;
  const ProductDetail({
    Key? key,
    required this.item,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Detail'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
              'THIS PAGE IS IN DEVELELOPING \nFOR MORE TASK SCHEDULE FEATURES.\n\n\nCOMING SOON....'),
        ],
      ),
    );
  }
}
