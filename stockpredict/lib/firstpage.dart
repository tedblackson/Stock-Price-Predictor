import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tflite/tflite.dart';
import 'package:http/http.dart' as http;

class StockInsightsPage extends StatefulWidget {
  @override
  _StockInsightsPageState createState() => _StockInsightsPageState();
}

// loadDataModelFiles() async {
//   String? output = await Tflite.loadModel(
//       model: 'assets/model.tflite',
//       labels: 'assets/labels.txt',
//       numThreads: 1,
//       isAsset: true,
//       useGpuDelegate: false);
//   print(output);
// }
class _StockInsightsPageState extends State<StockInsightsPage> {
  var logos = {
    'GOOGL': 'assets/images/AA.jpg',
    'AAPL' : 'assets/images/apple.png',
    'AMZN' : 'assets/images/amazon.png',
    'TSLA' : 'assets/images/tesla.jpg'
  };
  final String _baseUrl =
      'https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/v2/get-quotes';

  List<dynamic> _stocks = [];

  Future<void> _fetchStockData() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?region=US&symbols=GOOGL,AAPL,AMZN,TSLA'),
        headers: {
          "X-RapidAPI-Key":
              "dc1757ec8cmsh586c7464a85bf17p1b88adjsn724a94afb79c",
          "X-RapidAPI-Host": "yh-finance.p.rapidapi.com"
        },
      );

      final data = json.decode(response.body);
      setState(() {
        _stocks = data['quoteResponse']['result'];
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchStockData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: Color.fromARGB(255, 9, 23, 50),
          child: ListView(
            children: [
              Container(
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Image(
                    image: AssetImage('assets/images/loggo.png'),
                  ),
                ),
              ),
              ListView.builder(
                  itemCount: _stocks.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final stock = _stocks[index];
                    {
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 16, 40, 64),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        margin: EdgeInsets.only(top: 18),
                        padding: EdgeInsets.only(
                            top: 10, left: 20, right: 20, bottom: 10),
                        height: 100,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ListView(
                                children: [
                                  ListTile(
                                      // isThreeLine: true,
                                      trailing: Text(
                                        'Price: ${stock['regularMarketPrice']}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                        left: 1,
                                        bottom: 1,
                                      ),
                                      title: Text(
                                        stock['longName'],
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      leading: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              logos[stock['symbol']]!)),
                                      dense: true,
                                      subtitle: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              stock['symbol'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Change: ${stock['regularMarketChange']} (${stock['regularMarketChangePercent']}%)',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )

                                      // minVerticalPadding: 20,
                                      ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    ;
                  })
            ],
          )),
    );
  }
}