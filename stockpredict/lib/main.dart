import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stockpredict/Start.dart';
import 'package:stockpredict/firstpage.dart';
import 'package:stockpredict/secondpage.dart';
import 'package:stockpredict/news.dart';

void main() {
  runApp(MaterialApp(
    home: Entrance()
  )
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  @override
  static List<Widget> pages = <Widget>[
    StockInsightsPage(),
    secondpage(),
    NewsScreen(),
    Container(color: Colors.amber)
  ];
  int _curidx = 0;
  void _onItemTapped(int index) {
    setState(() {
      _curidx = index;
    });
  }

  Widget build(BuildContext context) {
    return  Scaffold(
          backgroundColor: Color.fromARGB(255, 9, 23, 50),
          body: pages[_curidx],
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BottomNavigationBar(
            
              currentIndex: _curidx,
              selectedItemColor: Colors.green,
              selectedIconTheme: IconThemeData(
                color: Colors.green,
              ),
              backgroundColor: Color.fromARGB(255, 16, 40, 64),
              onTap: _onItemTapped,
              items: <BottomNavigationBarItem>[
                const BottomNavigationBarItem(
                  activeIcon: Icon(Icons.home,
                    color: Colors.green,),
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  label: '',
                ),
                const BottomNavigationBarItem(
                  activeIcon: Icon(Icons.leaderboard,
                    color: Colors.green,),
                  icon: Icon(
                    Icons.leaderboard,
                    color: Colors.white,
                  ),
                  label: '',
                ),
                const BottomNavigationBarItem(
                  activeIcon: Icon(Icons.notifications,
                    color: Colors.green,),
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  label: '',
                ),
          // …
              ],
            ),
          ),
        );
  }
}

