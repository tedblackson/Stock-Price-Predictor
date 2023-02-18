import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spline_chart/spline_chart.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:get/get.dart';

final sketch = ValueNotifier<String>('n');

class secondpage extends StatefulWidget {
  const secondpage({Key? key});

  @override
  State<secondpage> createState() => _secondpageState();
}

class _secondpageState extends State<secondpage> {
  DateTime endDate = DateTime.now();
  List prediction = [];
  late int duration;
  late Map data = {};
  late Map<double, double> doubleData= {};
  TextEditingController dateinput = TextEditingController();
  TextEditingController dateinput2 = TextEditingController();
  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text(
            "Tesla,INC",
            style: TextStyle(color: Colors.white),
          ),
          value: "TSLA"),
      DropdownMenuItem(
          child: Text("Apple INC", style: TextStyle(color: Colors.white)),
          value: "AAPL"),
      DropdownMenuItem(
          child: Text("Amazon.com,INC", style: TextStyle(color: Colors.white)),
          value: "AMZN"),
      DropdownMenuItem(
          child: Text("Microsoft INC", style: TextStyle(color: Colors.white)),
          value: "MSFT"),
    ];
    return menuItems;
  }

  void _fetchPrediction(ticker, duration) async {

    String host = "10.0.2.2:8000";
    String path = "predict";
    Map<String, dynamic> parameters = {'ticker': ticker, 'duration': duration};
    final response = await http.get(
      Uri.parse(
          "http://10.0.2.2:8000/predict/?ticker=$ticker&duration=$duration"),
    );

   
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      prediction = jsonData['prediction'];
      data = prediction.asMap();
      setState(() {
        doubleData = data.map((key, value) => MapEntry(key.toDouble(), value.toDouble()));
        
      });
      
   
    }
  }

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    dateinput2.text = "";
    super.initState();
    _fetchPrediction('AAPL', Duration(days: 60));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'prediction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        color: Color.fromARGB(255, 9, 23, 50),
        child: Align(
            alignment: Alignment.topCenter,
            child: ListView(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    height: 300,
                    child: ValueListenableBuilder(
                        valueListenable: sketch,
                        builder: ((context, value, widget) => SplineChart(
                              values: value != 'n'
                                  ? doubleData

                                  : {0: 583.0, 1: 972.0, 1: 910.0},
                              verticalLineEnabled: false,
                              verticalLinePosition: 90.0,
                              verticalLineStrokeWidth: 2.0,
                              verticalLineText: "Your score",
                              drawCircles: true,
                              circleRadius: 1,
                              width: 450,
                              height: 400,
                            ))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  height: 400,
                  child: Form(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          child: TextField(
                            controller: dateinput2,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'End-Date',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: Colors.blue), //<-- SEE HERE
                              ),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime
                                      .now(), //DateTime.now() - not to allow to choose before today.
                                  lastDate:
                                      DateTime.now().add(Duration(days: 80)));

                              if (pickedDate != null) {
                                endDate = pickedDate;
                               //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                            //formatted date output using intl package =>  2021-03-16
                                //you can implement different kind of Date Format here according to your requirement

                                setState(() {
                                  dateinput2.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } 
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: 'Stock Ticker',
                                labelStyle: TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(255, 16, 40, 64),
                              ),
                              validator: (value) =>
                                  value == null ? "Select a country" : null,
                              dropdownColor: Color.fromARGB(255, 35, 27, 76),
                              value: selectedValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                  duration =
                                      endDate.difference(DateTime.now()).inDays;
                                  

                                });
                              },
                              items: dropdownItems),
                        ),
                        Container(
                            height: 40,
                            margin: EdgeInsets.all(20),
                            child: SizedBox(
                                width: double.infinity, // <-- match_parent
                                height: double.infinity, // <-- match-parent
                                child: ElevatedButton(
                                    onPressed: () {
                                                                          
                                      _fetchPrediction(selectedValue, duration);
                                      setState(() {
                                        sketch.value = selectedValue!;

                                      });
                                    },
                                    child: Text(
                                      'Predict',
                                    ))))
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
