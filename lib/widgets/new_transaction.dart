import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransaction;
  NewTransaction(this.newTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectDate;

  void submitData(){
    final title = _titleController.text;
    final amount  = double.parse(_amountController.text);
    if(_amountController.text.isEmpty){
      return;
    }

    if(title.isEmpty || amount<=0 || _selectDate==null){
      return;
    }
    widget.newTransaction(title,amount,_selectDate);

    Navigator.of(context).pop();
  }

  void _datePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime.now())
        .then((pickedDate){
          if(pickedDate==null){
            return;
          }

          setState(() {
            _selectDate = pickedDate;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:15.0,right: 15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                  decoration: InputDecoration(hintText: 'title'),
                  controller: _titleController,
                  onSubmitted: (_)=> submitData(),
                ),

            TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Amount',),
                  controller: _amountController,
                  onSubmitted: (_)=>submitData(),
                ),


              Container(
                padding: EdgeInsets.only(top:30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(_selectDate==null?"No Date Chosen!!": "Picked Date: "+DateFormat.yMMMMd().format(_selectDate)),
                    FlatButton(onPressed: ()=> _datePicker(),
                        child: Text('Choose Date',style: TextStyle(fontWeight: FontWeight.bold),),
                        textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30,),


              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: submitData,
                child: Text('Add Transaction'),
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
        ),
      ),
    );
  }
}
