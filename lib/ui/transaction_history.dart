import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/firestore_service.dart';
import 'text_styles.dart';

class HistoryPage extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> transactionsFuture = retrieveAllTransactions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History', style: settingsHeader),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
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
                child: ListView.separated(
                  itemCount: transactions.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> transaction = transactions[index];
                    Timestamp timestamp = transaction['Datetime'];
                    DateTime datetime = timestamp.toDate();
                    String formattedDate = DateFormat('dd-MM-yyyy – h:mm a').format(datetime);
                    return InkWell(
                      onTap: () {
                        // Add your onTap logic here
                      },
                      child: ListTile(
                        title: Text('Transaction ${index + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Customer ID: ${transaction['Customer_ID']}\n'
                                      'Amount: ${transaction['Amount']}\n'
                                      'Date: $formattedDate\n'
                                      'Products: ${transaction['Items']}'),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                ),
              );
            }
          }
        },
      ),
    );
  }
}