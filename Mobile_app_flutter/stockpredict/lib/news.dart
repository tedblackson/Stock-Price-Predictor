import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsScreen extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsScreen> {
  List<dynamic> _news = [];

  @override
  void initState() {
    super.initState();
    _fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 13, 30),
      appBar: AppBar(
        title: Text('Finance News'),
        backgroundColor: Color.fromARGB(255, 5, 13, 30),
      ),
      body: _news.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _news.length,
              itemBuilder: (context, index) {
                final newsItem = _news[index];
                return Card(
                    color: Color.fromARGB(255, 16, 40, 64),
                    child: ListTile(
                      // leading: Image.network(
                      //   newsItem['media'] ?? 'assets/images/amazon.jpg',
                      //   width: 100,
                      //   height: 100,
                      //   fit: BoxFit.cover,
                      // ),
                      title: Text(
                        newsItem['title'],
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                      subtitle: Text(
                        newsItem['summary'],
                        style: TextStyle(color: Colors.white),
                      ),
                    ));
              },
            ),
    );
  }

  void _fetchNews() async {
    String host = "api.newscatcherapi.com";
    String path = "/v2/latest_headlines";
    Map<String, String> parameters = {'countries': 'US', 'topic': 'finance'};
    final response = await http.get(Uri.https(host, path, parameters),
        headers: {'x-api-key': "q4CGaI2zBCk-Mx4OkMrBsZl-4S7rXq8gXPXBbSCbzyg"});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _news = jsonData['articles'];
      });
    }
  }
}
