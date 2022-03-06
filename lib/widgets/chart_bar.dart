import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String label;
  final double totalAmount;
  final double percentageOfAmount;

  ChartBar(this.label,this.totalAmount,this.percentageOfAmount);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
            child: FittedBox(
                child: Text(
                    '\$${totalAmount.toStringAsFixed(0)}'))),
        SizedBox(height: 4,),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 1),
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentageOfAmount,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 4,),
        Text(label)
      ],
    );
  }
}
