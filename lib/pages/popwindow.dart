import 'package:flutter/material.dart';

class PopWindow extends StatelessWidget {
  final String transaction;
  final String description;
  final String date;
  final String amount;

  PopWindow(this.transaction, this.description, this.date, this.amount);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Activity History'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Transaction: $transaction'),
          SizedBox(height: 8),
          Text('Description: $description'),
          SizedBox(height: 8),
          Text('Date: $date'),
          SizedBox(height: 8),
          Text('Amount: $amount'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
