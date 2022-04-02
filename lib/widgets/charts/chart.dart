import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/transaction.dart';
import './chart-bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  // Grouping transactions this week by it's day
  List<Map<String, dynamic>> get _groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalOutcome = 0;
      double totalIncome = 0;

      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          if (recentTransactions[i].type == TransactionType.Income)
            totalIncome += recentTransactions[i].amount;
          else if (recentTransactions[i].type == TransactionType.Outcome)
            totalOutcome += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'outcome': totalOutcome,
        'income': totalIncome,
      };
    }).reversed.toList();
  }

  double get _totalOutcome {
    return _groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element['outcome'];
    });
  }

  double get _totalIncome {
    return _groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element['income'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 5),
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        height: 800,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Recent Transactions'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _groupedTransactionValues.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: data['day'],
                    outcomeAmount: data['outcome'],
                    outcomePercentageOfTotal: _totalOutcome == 0.0
                        ? 0.0
                        : data['outcome'] /
                            _totalOutcome, // Prevent divide by zero
                    incomeAmount: data['income'],
                    incomePercentageOfTotal: _totalIncome == 0.0
                        ? 0.0
                        : data['income'] /
                            _totalIncome, // Prevent divide by zero
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
