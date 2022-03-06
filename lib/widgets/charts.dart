import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_daily_expense/models/transactios.dart';
import 'package:flutter_daily_expense/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

class Charts extends StatelessWidget {

  final List<Transaction> recentTransaction;
  Charts(this.recentTransaction);
  //var totalAmount = 0.0;



  List<Map<String,Object>> get groupedTransactionValue{
      return List.generate(7, (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));
        var totalAmount=0.0;

        for(var i = 0; i<recentTransaction.length; i++){
          if(recentTransaction[i].date.day ==weekDay.day &&
              recentTransaction[i].date.month ==weekDay.month &&
                recentTransaction[i].date.year ==weekDay.year){
            totalAmount+= recentTransaction[i].amount;
          }
        }
       // print("Asif");
        //print(groupedTransactionValue.toString());
        return {'day': DateFormat.E().format(weekDay),'amount':totalAmount};
      }).reversed.toList();
  }
// double get totalSpending{
  //   var totalAmount =0.0;
  //   for(var i = 0;i<recentTransaction.length;i++){
  //     totalAmount+=recentTransaction[i].amount;
  //   }
  //   return totalAmount;
  // }
  double get totalSpending{
    return groupedTransactionValue.fold(0.0, (sum, element){
      return sum+element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(groupedTransactionValue);

    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValue.map((data){
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  data['day'],
                  data['amount'],
                    totalSpending==0.0? 0.0: (data['amount'] as double)/totalSpending
                ),
              );
            }).toList()
          ),
        ),
    );
  }
}
