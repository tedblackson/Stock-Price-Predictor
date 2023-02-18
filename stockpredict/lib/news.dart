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
                      leading: Image.network(
                        
                        newsItem['media'] != '' ? newsItem['media'] : 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.forbes.com%2Fsites%2Fforbesfinancecouncil%2F2021%2F10%2F29%2Fwhy-the-stock-market-is-still-so-attractive%2F&psig=AOvVaw100qpBcsfKdgOA7WRnvdCx&ust=1676783755312000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCKCe77Konv0CFQAAAAAdAAAAABAE',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        newsItem['title'],
                        style: TextStyle(fontSize: 25.0, color: Colors.blueAccent),
                      ),
                      subtitle: Text(
                        newsItem['summary'],
                         textAlign: TextAlign.justify,
                        softWrap: true,
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
        headers: {'x-api-key': "OsAHTEEl2hwT-ql_V5DSbyHRCiWjNtDZq3BTON_RU08"});
    print('this is the news response code');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _news = jsonData['articles'];
      });
    }
  }
}
