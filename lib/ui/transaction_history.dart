import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class HistoryPage extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> transactionsFuture = retrieveAllTransactions();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: transactionsFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Map<String, dynamic>> transactions = snapshot.data!;
          if (transactions.isEmpty) {
            return Center(child: Text('No history yet'));
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.3,
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> transaction = transactions[index];
                  return ListTile(
                    title: Text('Transaction ${index + 1}', style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text('Customer ID: ${transaction['Customer_ID']}\n'
                                  'Amount: ${transaction['Amount']}\n'
                                  'Date: ${transaction['Datetime']}\n'
                                  'Products: ${transaction['Items']}'),
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}