import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TimerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 100.0,
      lineWidth: 10.0,
      percent: 0.8,
      header: new Text("Icon header"),
      center: new Icon(
        Icons.person_pin,
        size: 50.0,
        color: Colors.blue,
      ),
      backgroundColor: Colors.grey,
      progressColor: Colors.blue,
    );
  }
}
