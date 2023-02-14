import 'package:flutter/material.dart';
import 'package:spline_chart/spline_chart.dart';


class secondpage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplineChartDemo(),
    );
  }
}

class SplineChartDemo extends StatelessWidget {
  const SplineChartDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SplineChart(
            values: {0:10,15:30,60:40,44:50,80:50,100:90},
            //values: {0:10, 7.69 :52, 15.38 :74, 23.08 :1464, 30.77 :942, 38.46 :2433, 46.15 :2379, 53.85 :3820, 61.54 :2750, 69.23 :2739, 76.92 :3057, 84.62 :1598, 92.31 :1450,100:630},
            //values: {0.0: 583.0, 50.0: 972.0, 100.0: 910.0},
            verticalLineEnabled: false,
            verticalLinePosition: 90.0,
            verticalLineStrokeWidth: 2.0,
            verticalLineText: "Your score",
            drawCircles: true,
            circleRadius: 4,
            width: 320,
            height: 400,
          ),
        ],
      ),
    );
  }
}