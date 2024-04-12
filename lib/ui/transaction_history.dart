import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import 'text_styles.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<List<Map<String, dynamic>>> transactionsFuture;
  String? selectedDate;
  String? selectedCustomerId;

  @override
  void initState() {
    super.initState();
    transactionsFuture = retrieveAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History', style: settingsHeader),
        actions: [
            Padding(
              padding: EdgeInsets.only(top: 0, left: 100),
              child: TextButton(
                onPressed: () async {
                  final DateTime now = DateTime.now();
                  final DateTime firstDate = DateTime(now.year-1, now.month , now.day);
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: firstDate,
                    lastDate: now,
                  );
                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      transactionsFuture = retrieveAllTransactions(date: selectedDate, customerId: selectedCustomerId);
                    });
                  }
                },
                child: Text(selectedDate ?? 'Select Date'),
              ),
            ),
            Padding(
            padding: EdgeInsets.only(top: 0, right: 100),
            child: DropdownButton<String>(
              hint: Text('Select Customer ID'),
              value: selectedCustomerId,
              onChanged: (String? newValue) {
              setState(() {
                selectedCustomerId = newValue;
                transactionsFuture = retrieveAllTransactions(date: selectedDate, customerId: selectedCustomerId);
              });
              },
              items: customerIds
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
              }).toList(),
            ),
            ),
        ],
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