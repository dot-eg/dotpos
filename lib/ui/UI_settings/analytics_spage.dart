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
  bool _notifcationsEnabled = false;
  TextEditingController quantityController = TextEditingController();
  final FocusNode _quantityFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadSwitchState();
    _quantityFocusNode.addListener(_saveQuantity);
  }

  @override
  void dispose(){
    _quantityFocusNode.removeListener(_saveQuantity);
    _quantityFocusNode.dispose();
    super.dispose();
  }

  void _saveQuantity() async {
    if (!_quantityFocusNode.hasFocus) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('quantity', quantityController.text);
    }
  }

  void _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String quantity = (prefs.getString('quantity') ?? "0");
    setState(() {
      _isEnabled = prefs.getBool('isEnabled') ?? false;
      _notifcationsEnabled = prefs.getBool('notifcationsEnabled') ?? false;
      quantityController.text = quantity;
    });
  }

  void _saveSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isEnabled', _isEnabled);
    prefs.setBool('notifcationsEnabled', _notifcationsEnabled);
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
        child: Text('Sales Reporting',
            style: TextStyle(
                fontFamily: "Hind Kochi",
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
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
                color: Colors.black,
                thickness: 1.0,
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
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
            child: Stack(children: [
              Positioned(
                top: 6,
                left: 10,
                child: Text(
                  "Inventory",
                  style: settingsHeader.copyWith(color: Colors.white),
                ),
              ),
              Positioned(
                top: 50,
                left: 10,
                child: Text('Notifications',
                    style: TextStyle(
                        fontFamily: "Hind Kochi",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              Positioned(
                top: 80,
                left: 10,
                child: Row(
                  children: [
                    Text(
                      "Enable Low Quantity Notifications",
                      style: TextStyle(color: Colors.white),
                    ),
                    Switch(
                      value: _notifcationsEnabled,
                      onChanged: (bool value) {
                        setState(() {
                          _notifcationsEnabled = value;
                        });
                        _saveSwitchState();
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: 130,
                  left: 10,
                  child: Row(
                    children: [
                      Text(
                        "Low Quantity Threshold",
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(padding: EdgeInsets.all(8)),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: TextField(
                          focusNode: _quantityFocusNode,
                          controller: quantityController,
                          decoration: InputDecoration(
                            hintText: "#",
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ))
            ])),
      ),
    ]);
  }
}
