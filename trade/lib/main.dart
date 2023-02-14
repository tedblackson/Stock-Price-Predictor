import 'package:flutter/material.dart';
import 'package:trade/pages/news_page.dart';
import 'package:trade/pages/real_time_price_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: StockInsightsPage() ,
    );
  }
}

