import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spline_chart/spline_chart.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final sketch = ValueNotifier<String>('n');

class secondpage extends StatefulWidget {
  const secondpage({super.key});

  @override
  State<secondpage> createState() => _secondpageState();
}

class _secondpageState extends State<secondpage> {
  DateTime endDate = DateTime.now();
  late final duration;
  Map plot = {
    'TSLA': {
      10.0: 100.0,
      105.0: 30.0,
      50.0: 30.0,
      13.0: 87.0,
      80.0: 50.0,
      100.0: 90.0
    },
    'APPL': {
      0.0: 10.0,
      15.0: 30.0,
      60.0: 40.0,
      44.0: 50.0,
      80.0: 50.0,
      100.0: 90.0
    },
    'AMZN': {0.0: 583.0, 50.0: 972.0, 100.0: 910.0},
    'MSFT': {0.0: 583.0, 35.0: 700.0, 70.0: 550.0, 90.0: 540.0, 100.0: 640.0}
  };

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

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    dateinput2.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
                                ? plot[value]
                                : {0.0: 583.0, 50.0: 972.0, 100.0: 910.0},
                            verticalLineEnabled: false,
                            verticalLinePosition: 90.0,
                            verticalLineStrokeWidth: 2.0,
                            verticalLineText: "Your score",
                            drawCircles: true,
                            circleRadius: 4,
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
                          controller: dateinput,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Start-Date',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Colors.blue), //<-- SEE HERE
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime
                                    .now(), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                dateinput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
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
                                  width: 3, color: Colors.blue), //<-- SEE HERE
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime
                                    .now(), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              endDate = pickedDate;
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                dateinput2.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Volume',
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3, color: Colors.blue), //<-- SEE HERE
                            ),
                          ),
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
                                duration = endDate.difference(DateTime.now());
                                print('Duration');
                                print(duration.inDays);

                                print(selectedValue);
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
                                    setState(() {
                                      sketch.value = selectedValue!;

                                      final response =
                                          postValue("AAPL", duration);

                                      final jsonData =
                                          jsonDecode(response.toString());
                                      print('prediction');
                                      print(jsonData["prediction"]);
                                      

                                      print('response');
                                      final prediction = jsonDecode(
                                          response.toString())['prediction'];
                                      print(prediction);
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
          ),
        ),
      ),
    );
  }

  Future<http.Response> postValue(ticker, duration) {
    return http.post(Uri.parse('http://127.0.0.1:8000/predict'),
        body: {"ticker": ticker, "duration": duration});
  }
}
