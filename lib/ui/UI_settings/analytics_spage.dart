import 'package:flutter/material.dart';
import '../text_styles.dart';
import '../../services/analytics_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnalyticsPage extends StatefulWidget {
  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  final AnalyticsService analyticsService = AnalyticsService();
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSwitchState();
  }

  void _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isEnabled = prefs.getBool('isEnabled') ?? false;
    });
  }

  void _saveSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isEnabled', _isEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Expanded(
        child: AppBar(
          title: Text('Analytics', style: settingsHeader),
        ),
      ),
      Positioned(
        top: 60,
        left: 15,
        child: Text('Sales Reporting', style: TextStyle(fontFamily: "Hind Kochi", fontSize: 18, fontWeight: FontWeight.bold )),),
      Positioned(
          top: 90,
          left: 15,
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Warning'),
                      icon: Icon(
                        Icons.warning_amber,
                        color: Colors.red,
                        size: 30,
                      ),
                      content: Text(
                          'This Action Cannot Be Undone. Are You Sure You Want To Delete The Current Sales Report?\nCurrent Sales will not be recorded until a new Sales Report is created.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            analyticsService.deleteSalesReport();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text("Delete Current Sales Report",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.00976562,
                    fontFamily: 'Hind Kochi',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  )),
            ),
          )),
      Positioned(
          top: 135,
          left: 15,
          child: Container(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Warning'),
                      icon: Icon(
                        Icons.warning_amber,
                        color: Colors.red,
                        size: 30,
                      ),
                      content: Text(
                          'This Action Cannot Be Undone. Are You Sure You Want To Clear All Sales Reports?\nCurrent Sales will not be recorded until a new Sales Report is created.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            analyticsService.deleteAllSalesReport();
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text("Delete All Sales Reports",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.00976562,
                    fontFamily: 'Hind Kochi',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  )),
            ),
          )),
      Positioned(
          top: 90,
          left: 260,
          child: Container(
            child: ElevatedButton(
              onPressed: () async {
                if (analyticsService.currentdoc != null) {
                  analyticsService.currentdoc = null;
                }
                String message = await analyticsService.createSalesReport();
                if (message.contains("Sales Report Created Successfully")) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Success'),
                        content: Text(message),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text(message),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: Text("Create New Sales Report",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.00976562,
                    fontFamily: 'Hind Kochi',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  )),
            ),
          )),
      Positioned(
        top: MediaQuery.of(context).size.height * 0.8,
        left: MediaQuery.of(context).size.width * 0.01302083,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            children: [
              Divider(
                color: Colors.black, // Adjust the color as needed
                thickness: 1.0, // Adjust the thickness as needed
              ),
              Positioned(
                top: 20,
                child: Row(
                  children: [
                    Text('Auto Create Sales Report on Startup'),
                    Switch(
                      value: _isEnabled,
                      onChanged: (bool value) {
                        setState(() {
                          _isEnabled = value;
                        });
                        _saveSwitchState();
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1.0,
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: MediaQuery.of(context).size.height * 0.9,
        left: MediaQuery.of(context).size.width * 0.01302083,
        child: Text("Current Sales Report ID: ${analyticsService.currentdoc}",
            style: TextStyle(
              color: Colors.black,
              fontSize: MediaQuery.of(context).size.width * 0.00976562,
              fontFamily: 'Hind Kochi',
              fontWeight: FontWeight.w500,
              height: 0,
            )),
      ),
      Positioned(
        left: MediaQuery.of(context).size.width * 0.4,
        top: 0,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5)
            ),
          ),
        ),
    ]);
  }
}
