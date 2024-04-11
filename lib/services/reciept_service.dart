import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'cart_service.dart';

void generateReceipt(BuildContext context, String transactionId, String customerName, String customerEmail, String customerPhone, CartModel cart) {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Column(
          children: [
            pw.Text('Receipt', style: pw.TextStyle(fontSize: 40)),
            pw.SizedBox(height: 20),
            pw.Text('Transaction ID: $transactionId'),
            pw.Text('Customer Name: $customerName'),
            pw.Text('Customer Email: $customerEmail'),
            pw.Text('Customer Phone: $customerPhone'),
            pw.SizedBox(height: 20),
            pw.Text('Items:'),
            ...cart.items.entries.map((item) => pw.Text('${item.key}: ${item.value} x ${cart.getPrice(item.key)}')),
            pw.SizedBox(height: 20),
            pw.Text('Total Amount: ${cart.getTotal()}'),
          ],
        ),
      ),
    ),
  );

  Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}