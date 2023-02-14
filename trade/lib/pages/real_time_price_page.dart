import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StockInsightsPage extends StatefulWidget {
  @override
  _StockInsightsPageState createState() => _StockInsightsPageState();
}

class _StockInsightsPageState extends State<StockInsightsPage> {
  final String _baseUrl = 'https://apidojo-yahoo-finance-v1.p.rapidapi.com/market/v2/get-quotes';

  List<dynamic> _stocks = [];

  Future<void> _fetchStockData() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl?region=US&symbols=GOOGL,AAPL,AMZN,TSLA'),
          headers: {
        "X-RapidAPI-Key": "dc1757ec8cmsh586c7464a85bf17p1b88adjsn724a94afb79c",
        "X-RapidAPI-Host": "yh-finance.p.rapidapi.com"
      },);

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Insights'),
      ),
      body: _stocks.isNotEmpty
          ? ListView.builder(
              itemCount: _stocks.length,
              itemBuilder: (BuildContext context, int index) {
                final stock = _stocks[index];
                return ListTile(
                  title: Text(stock['longName']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(stock['symbol']),
                      Text('Price: ${stock['regularMarketPrice']}'),
                      Text('Change: ${stock['regularMarketChange']} (${stock['regularMarketChangePercent']}%)'),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
