import 'package:flutter/material.dart';
import 'package:stockpredict/firstpage.dart';
import 'package:stockpredict/main.dart';

class Entrance extends StatefulWidget {
  const Entrance({super.key});

  @override
  State<Entrance> createState() => _EntranceState();
}

class _EntranceState extends State<Entrance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: SafeArea(
                child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/ffpage.jpg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                        child: Container(
                            color: Color.fromARGB(255, 9, 23, 50),
                            width: double.infinity,
                            height: 100,
                            child: Container(
                              margin: EdgeInsets.only(left: 27),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: ElevatedButton(
                                  child: Text(
                                    "Let's Start",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  onPressed: () {Navigator.of(context).push(
                                     MaterialPageRoute(
                                      builder:(BuildContext context) => const Home()
                                  ), 
                                  );
                                  },
                                  
                                  style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, 24, 106, 27),
                                    minimumSize: Size(120, 50),
                                    
                                  ),
                                ),
                              ),
                            )))) /* add child content here */
                ));
  }
}

