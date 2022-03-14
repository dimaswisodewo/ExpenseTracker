import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final TransactionType type;
  final double amount;
  final DateTime date;
  final NumberFormat formatCurrency = NumberFormat.currency(locale: 'id_ID');
  final Function deleteTransaction;

  TransactionItem({
    Key? key,
    required this.title,
    required this.type,
    required this.amount,
    required this.date,
    required this.deleteTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.only(
          left: 22,
          right: 22,
          top: 20,
          bottom: 20,
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                      padding: EdgeInsets.only(
                        top: 3,
                        bottom: 3,
                        left: 6,
                        right: 6,
                      ),
                      margin: EdgeInsets.only(bottom: 2),
                      child: Text(
                        DateFormat.E().format(date),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    Text(
                      DateFormat.yMMMd().format(date),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      DateFormat.Hm().format(date),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  ],
                )),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20),
                child: Text(title),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  type == TransactionType.Outcome
                      ? '-${formatCurrency.format(amount)}'
                      : '+${formatCurrency.format(amount)}',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    color: type == TransactionType.Outcome
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () {
                  deleteTransaction();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
