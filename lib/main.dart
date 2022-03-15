// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import './widgets/transaction-list.dart';
import './widgets/new-transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Make the app cannot run in Landscape
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.teal,
        // textTheme: ThemeData.light().textTheme.copyWith(
        //       button: TextStyle(color: Colors.white),
        //     ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final NumberFormat formatter = NumberFormat.currency(locale: 'id_ID');

  List<Transaction> _userTransactions = [];
  bool _showChart = false;
  int _chartHeight = 0;

  // Get recent transactions in the last week
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  // On tap floating Add Icon Button
  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: NewTransaction(addTransaction: addTransaction),
        );
      },
    );
  }

  // On tap Add transaction Elevated Button
  void addTransaction(
      String title, TransactionType type, double amount, DateTime date) {
    Transaction newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      type: type,
      amount: amount,
      date: date,
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void deleteTransaction(String transactionId) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == transactionId);
    });
  }

  String getOutcome() {
    double outcome = 0;
    for (int i = 0; i < _userTransactions.length; i++) {
      if (_userTransactions[i].type == TransactionType.Outcome) {
        outcome += _userTransactions[i].amount;
      }
    }

    return formatter.format(outcome);
  }

  String getIncome() {
    double income = 0;
    for (int i = 0; i < _userTransactions.length; i++) {
      if (_userTransactions[i].type == TransactionType.Income) {
        income += _userTransactions[i].amount;
      }
    }

    return formatter.format(income);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Expense Tracker'),
      actions: [
        IconButton(
          onPressed: () => startAddNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      // backgroundColor: Color(0xFFF7F4F7),
      body: Column(
        children: [
          Container(
            height: 60,
            color: Colors.white,
            padding: EdgeInsets.only(
              top: 20,
              bottom: 16,
              right: 22,
              left: 22,
            ),
            // margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      getOutcome(),
                      style: TextStyle(
                        color: Colors.red,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      getIncome(),
                      style: TextStyle(
                        color: Colors.green,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text('Show Chart',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    )),
                Switch(
                    value: _showChart,
                    onChanged: (newValue) {
                      if (newValue)
                        _chartHeight = 250;
                      else
                        _chartHeight = 0;

                      setState(() {
                        _showChart = newValue;
                      });
                    })
              ],
            ),
          ),
          _showChart == true
              ? Container(
                  height: 250,
                  margin: EdgeInsets.symmetric(horizontal: 3),
                  child: Chart(_recentTransactions),
                )
              : Container(
                  height: 0,
                ),
          Container(
            height: (MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                appBar.preferredSize.height -
                60 -
                _chartHeight -
                60),
            child: TransactionList(
              transactions: _userTransactions,
              deleteTransaction: deleteTransaction,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
