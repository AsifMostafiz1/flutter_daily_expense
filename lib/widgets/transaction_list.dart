import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_daily_expense/models/transactios.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transaction;
  final Function deleteTransaction;

  TransactionList(this.transaction,this.deleteTransaction);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height/1.5,
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 50),
      child: widget.transaction.isEmpty
          ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'No Transaction Added Yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                Container(
                  //width: double.infinity,
                  height: 200,
                    child: Image.asset(
                  'assets/images/file.png',
                  fit: BoxFit.cover,
                ))
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius:30,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: FittedBox(child: Text('\$${widget.transaction[index].amount}')),
                          ),
                      ),
                      title: Text(
                        widget.transaction[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMMEEEEd().format(widget.transaction[index].date)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed:()=> widget.deleteTransaction(widget.transaction[index].id),
                      ),
                    ),
                  ),
                );
              },
              itemCount: widget.transaction.length,
            ),
    );
  }
}
