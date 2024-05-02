import 'package:flutter/material.dart';
import '../text_styles.dart';

class AnalyticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: AppBar(
              title: Text('Analytics', style: settingsHeader),
            ),
          ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.08829465,
          left: MediaQuery.of(context).size.width * 0.01302083,
          child: Container(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Delete Current Sales Report", style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.00976562, fontFamily: 'Hind Kochi', fontWeight: FontWeight.w500, height: 0,)),
              ),
          )
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.15,
          left: MediaQuery.of(context).size.width * 0.01302083,
          child: Container(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Delete All Sales Reports", style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.00976562, fontFamily: 'Hind Kochi', fontWeight: FontWeight.w500, height: 0,)),
              ),
          )
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.21,
          left: MediaQuery.of(context).size.width * 0.01302083,
          child: Container(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Clear Product Sales Data", style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.00976562, fontFamily: 'Hind Kochi', fontWeight: FontWeight.w500, height: 0,)),
              ),
          )
        )
      ]
    );
  }
}