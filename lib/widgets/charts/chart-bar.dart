import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double outcomeAmount;
  final double outcomePercentageOfTotal;
  final double incomeAmount;
  final double incomePercentageOfTotal;

  final NumberFormat formatter = NumberFormat.currency(locale: 'id_ID');

  ChartBar({
    required this.label,
    required this.outcomeAmount,
    required this.outcomePercentageOfTotal,
    required this.incomeAmount,
    required this.incomePercentageOfTotal,
  });

  @override
  Widget build(BuildContext context) {
    // return LayoutBuilder(builder: (ctx, constraints) {
    return Column(
      children: [
        FittedBox(
          child: Text('+' + formatter.format(incomeAmount),
              style: const TextStyle(
                fontSize: 11,
                color: Colors.green,
              )),
        ),
        const SizedBox(
          // height: constraints.maxHeight * 0.05,
          height: 10,
        ),
        Container(
          // height: constraints.maxHeight * 0.2,
          height: 35,
          width: 20,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  heightFactor: incomePercentageOfTotal,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: const BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        topRight: const Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          // height: constraints.maxHeight * 0.2,
          height: 35,
          width: 20,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: const Radius.circular(10),
                    bottomRight: const Radius.circular(10),
                  ),
                ),
              ),
              FractionallySizedBox(
                heightFactor: outcomePercentageOfTotal,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: const Radius.circular(10),
                      bottomRight: const Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          // height: constraints.maxHeight * 0.05,
          height: 10,
        ),
        FittedBox(
          child: Text('-' + formatter.format(outcomeAmount),
              style: const TextStyle(
                fontSize: 11,
                color: Colors.red,
              )),
        ),
        const SizedBox(
          // height: constraints.maxHeight * 0.05,
          height: 10,
        ),
        FittedBox(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
    // });
  }
}
