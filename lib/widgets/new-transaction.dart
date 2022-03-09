import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({required this.addTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  TransactionType? dropdownValue = TransactionType.Outcome;

  void submitData() {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        dropdownValue == null) return;

    final String enteredTitle = titleController.text;
    final double enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) return;

    widget.addTransaction(
      titleController.text,
      dropdownValue,
      double.parse(amountController.text),
    );

    titleController.clear();
    amountController.clear();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.only(bottom: 10),
      // child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          left: 22,
          right: 22,
          top: 20,
          bottom: 20,
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              maxLength: 60,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData,
            ),
            TextField(
              maxLength: 12,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,
            ),
            DropdownButton(
              value: dropdownValue,
              isExpanded: true,
              items: TransactionType.values.map((element) {
                return DropdownMenuItem(
                  child: Text(element
                      .toString()
                      .replaceFirst(RegExp(r'TransactionType.'), '')),
                  value: element,
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  dropdownValue = TransactionType.values.firstWhere(
                      (element) => newValue.toString() == element.toString());
                });
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: submitData,
                child: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 22,
                    right: 22,
                  ),
                  child: Text('Add Item'),
                ),
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
