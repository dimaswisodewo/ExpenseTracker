import 'package:flutter/material.dart';
import './transaction-item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({
    Key? key,
    required this.transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Container(
            width: double.infinity,
            child: Text(
              'You haven\'t done any transaction today',
              textAlign: TextAlign.center,
            ),
          )
        : Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return TransactionItem(
                  title: transactions[index].title,
                  type: transactions[index].type,
                  amount: transactions[index].amount,
                  date: transactions[index].date,
                );
              },
            ),
          );
  }
}
