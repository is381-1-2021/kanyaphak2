import 'package:flutter/material.dart';

class DailyActivities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Activities'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFF8B82D0),
            ),
          ),
          SafeArea(
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFF5F478C),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/DailyActivities.png'),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 1,
                    children: List.generate(7, (index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/${index + 1}');
                        },
                        child: Container(
                          height: 50.0,
                          margin: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: Color(0xFF9ADCF1),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(
                            child: Text(
                              'Day ${index + 1}',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
