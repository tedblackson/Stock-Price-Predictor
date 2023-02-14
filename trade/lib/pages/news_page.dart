import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final _apiKey = 'aNBXXtMB6mG5BFxNO6mCu2OzepwVfJZiL4Op0dXM';
  List<dynamic> _news = [];

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  Future<void> _fetchNews() async {
    final response = await http.get(Uri.parse('https://api.marketaux.com/v1/news/all?key=$_apiKey'));
    if (response.statusCode == 200) {
      setState(() {
        _news = json.decode(response.body)['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marketaux News'),
      ),
      body: _news.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _news.length,
              itemBuilder: (context, index) {
                final newsItem = _news[index];
                return ListTile(
                  title: Text(newsItem['title']),
                  subtitle: Text(newsItem['description']),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Navigate to the news details page
                  },
                );
              },
            ),
    );
  }
}
