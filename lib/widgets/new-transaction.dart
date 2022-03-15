import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
  DateTime? _pickedDate = DateTime.now();

  void submitData() {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        dropdownValue == null ||
        _pickedDate == null) return;

    final String enteredTitle = titleController.text;
    final double enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) return;

    widget.addTransaction(
      titleController.text,
      dropdownValue,
      double.parse(amountController.text),
      _pickedDate,
    );

    titleController.clear();
    amountController.clear();
    _pickedDate = DateTime.now();

    Navigator.pop(context);
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2017),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _pickedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
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
                margin: EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _pickedDate == null
                            ? 'No date picked'
                            : DateFormat.yMd().format(_pickedDate!),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    TextButton(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: Icon(
                          Icons.calendar_today_rounded,
                          // size: 18,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: submitData,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 22,
                    ),
                    child: Text('Add Item'),
                  ),
                ),
              ),
            ],
          ),
        ),
        // ),
      ),
    );
  }
}
