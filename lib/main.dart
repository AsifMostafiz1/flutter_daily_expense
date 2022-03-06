import 'package:flutter/material.dart';
import './widgets/charts.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transactios.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Daily Note",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',

          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
              button: TextStyle(
                  color: Colors.white
              )
          ),

        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions =[
        Transaction(DateTime.now().toString(),"Mobile Phone",500.00, DateTime.now()),
        Transaction(DateTime.now().toString(),"Mobile Phone",500.00, DateTime.now()),
        Transaction(DateTime.now().toString(),"Mobile Phone",500.00, DateTime.now()),
        Transaction(DateTime.now().toString(),"Mobile Phone",500.00, DateTime.now()),
        Transaction(DateTime.now().toString(),"Mobile Phone",500.00, DateTime.now()),
        Transaction(DateTime.now().toString(),"Mobile Phone",500.00, DateTime.now()),
        Transaction(DateTime.now().toString(),"Mobile Phone",500.00, DateTime.now()),
        Transaction(DateTime.now().toString(),"Mobile Phone",500.00, DateTime.now()),

  ];

  List<Transaction> get _recentTransactions{
    return _transactions.where((tx){
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount,DateTime date){
    var newTx = Transaction(DateTime.now().toString(), title, amount,date);

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      return _transactions.removeWhere((tx)=> tx.id==id);
    });

  }

  void _addNewBottomSheets(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder:(_){
        return GestureDetector(
            onTap: (){},
            behavior:HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction)
        );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Note'),
        actions: [
          IconButton(icon: Icon(Icons.add),
              onPressed:() => _addNewBottomSheets(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(height: 15,),
              Text("Last 7 day's transaction chart"),
              Charts(_recentTransactions),
              TransactionList(_transactions,_deleteTransaction),
            ],
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:() => _addNewBottomSheets(context),
      ),
    );
  }
}
