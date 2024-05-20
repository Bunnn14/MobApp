import 'package:flutter/material.dart';
import 'popwindow.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/back.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: ListView(
              children: [
                _buildTransactionRow(context, 'Payment Received', 'From John Doe', 'March 15, 2024', '+\$500.00'),
                _buildTransactionRow(context, 'Utility Bill Payment', 'Electricity bill', 'March 12, 2024', '-\$80.00'),
                _buildTransactionRow(context, 'Online Purchase', 'Amazon', 'March 10, 2024', '-\$120.00'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionRow(BuildContext context, String transaction, String description, String date, String amount) {
    return GestureDetector(
      onTap: () {
        // Show pop-up window
        showDialog(
          context: context,
          builder: (BuildContext context) {
           return PopWindow(transaction, description, date, amount); // Passing description to the pop-up window
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200], // Gray background color
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18, 
              ),
            ),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            Text(date),
            SizedBox(height: 8),
            Text(
              'Amount: $amount',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: amount.startsWith('+') ? Colors.green : Colors.red, 
                fontFamily: 'Golos UI' // Green for positive transactions, red for negative transactions
              ),
            ),
          ],
        ),
      ),
    );
  }
}
