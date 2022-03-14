import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double outcomeAmount;
  final double outcomePercentageOfTotal;
  final double incomeAmount;
  final double incomePercentageOfTotal;

  const ChartBar({
    required this.label,
    required this.outcomeAmount,
    required this.outcomePercentageOfTotal,
    required this.incomeAmount,
    required this.incomePercentageOfTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          child: Text('+$incomeAmount',
              style: TextStyle(
                fontSize: 11,
                color: Colors.green,
              )),
        ),
        SizedBox(height: 10),
        Container(
          height: 50,
          width: 20,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: incomePercentageOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 50,
          width: 20,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
              FractionallySizedBox(
                heightFactor: outcomePercentageOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        FittedBox(
          child: Text('-$outcomeAmount',
              style: TextStyle(
                fontSize: 11,
                color: Colors.red,
              )),
        ),
        SizedBox(height: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
