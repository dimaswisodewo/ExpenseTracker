import 'dart:math';

import 'package:flutter/material.dart';
import './transaction-item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList({
    Key? key,
    required this.transactions,
    required this.deleteTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<Color> colorsData = [Colors.black, Colors.blue, Colors.green];
    int pickedColor = Random().nextInt(colorsData.length);

    return transactions.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                child: Image.asset(
                  'asset/images/waiting.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: const Text(
                  'You haven\'t done any transaction today',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return TransactionItem(
                key: ValueKey(transactions[index].id),
                title: transactions[index].title,
                type: transactions[index].type,
                amount: transactions[index].amount,
                date: transactions[index].date,
                deleteTransaction: () =>
                    deleteTransaction(transactions[index].id),
              );
            },
          );
    // : ListView(
    //     children: transactions.map((tx) {
    //       return TransactionItem(
    //         key: ValueKey(tx.id),
    //         title: tx.title,
    //         type: tx.type,
    //         amount: tx.amount,
    //         date: tx.date,
    //         deleteTransaction: deleteTransaction(tx.id),
    //       );
    //     }).toList(),
    //   );
  }
}
