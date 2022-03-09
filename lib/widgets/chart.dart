import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      elevation: 10,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 30,
          bottom: 30,
        ),
        child: Text('CHART'),
      ),
    );
  }
}
