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
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  'You haven\'t done any transaction today',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
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
                  deleteTransaction: () =>
                      deleteTransaction(transactions[index].id),
                );
              },
            ),
          );
  }
}
