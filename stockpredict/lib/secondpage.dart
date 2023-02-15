import 'package:flutter/material.dart';
import 'package:spline_chart/spline_chart.dart';
import 'package:intl/intl.dart';




class secondpage extends StatefulWidget {
  const secondpage({super.key});

  @override
  State<secondpage> createState() => _secondpageState();
}

class _secondpageState extends State<secondpage> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController dateinput2 = TextEditingController();
  String? selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> get dropdownItems{
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Tesla,INC",style: TextStyle(color:Colors.white),),value: "TSLA"),
    DropdownMenuItem(child: Text("Apple INC",style: TextStyle(color:Colors.white)),value: "AAPL"),
    DropdownMenuItem(child: Text("Amazon.com,INC",style: TextStyle(color:Colors.white)),value: "AMZN"),
    DropdownMenuItem(child: Text("Microsoft INC",style: TextStyle(color:Colors.white)),value: "MSFT"),
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
      home:  Container(
      color: Color.fromARGB(255, 9, 23, 50),
      child:Align(alignment: Alignment.topCenter,
      child: ListView(
        
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
            margin: EdgeInsets.only(top: 50),
            height: 300,
          child: 
            SplineChart(
            values: {0:10,15:30,60:40,44:50,80:50,100:90},
            //values: {0:10, 7.69 :52, 15.38 :74, 23.08 :1464, 30.77 :942, 38.46 :2433, 46.15 :2379, 53.85 :3820, 61.54 :2750, 69.23 :2739, 76.92 :3057, 84.62 :1598, 92.31 :1450,100:630},
            //values: {0.0: 583.0, 50.0: 972.0, 100.0: 910.0},
            verticalLineEnabled: false,
            verticalLinePosition: 90.0,
            verticalLineStrokeWidth: 2.0,
            verticalLineText: "Your score",
            drawCircles: true,
            circleRadius: 4,
            width: 450,
            height: 400,
          ),

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
                      labelStyle: TextStyle(
                        color: Colors.white
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                             width: 3, color: Colors.blue), //<-- SEE HERE
          ),
  ),
                    readOnly: true,
                    onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         dateinput.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
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
                      labelStyle: TextStyle(
                        color: Colors.white
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                             width: 3, color: Colors.blue), //<-- SEE HERE
          ),
  ),
                    readOnly: true,
                    onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         dateinput2.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
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
                      labelStyle: TextStyle(
                        color: Colors.white
                      ),
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
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 16, 40, 64),
                ),
                validator: (value) => value == null ? "Select a country" : null,
                dropdownColor: Color.fromARGB(255, 35, 27, 76),
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
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
  child: ElevatedButton(onPressed: (){}, child: Text('Predict',))
)
                  )
            
                ],
              ),
            ),
          )
          
        ],
      ),),
       

    ),
    );
  }
}
// class SplineChartDemo extends StatefulWidget {
//    SplineChartDemo({super.key});
   
//   @override
//   State SplineChartDemo> createState() =>  SplineChartDemoState();
// }

// class  SplineChartDemoState extends State SplineChartDemo> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Color.fromARGB(255, 9, 23, 50),
//       child:Align(alignment: Alignment.topCenter,
//       child: ListView(
        
//         children: [
//           Align(
//             alignment: Alignment.topCenter,
//             child: Container(
//             margin: EdgeInsets.only(top: 50),
//             height: 300,
//           child: 
//             SplineChart(
//             values: {0:10,15:30,60:40,44:50,80:50,100:90},
//             //values: {0:10, 7.69 :52, 15.38 :74, 23.08 :1464, 30.77 :942, 38.46 :2433, 46.15 :2379, 53.85 :3820, 61.54 :2750, 69.23 :2739, 76.92 :3057, 84.62 :1598, 92.31 :1450,100:630},
//             //values: {0.0: 583.0, 50.0: 972.0, 100.0: 910.0},
//             verticalLineEnabled: false,
//             verticalLinePosition: 90.0,
//             verticalLineStrokeWidth: 2.0,
//             verticalLineText: "Your score",
//             drawCircles: true,
//             circleRadius: 4,
//             width: 450,
//             height: 400,
//           ),

//           ),
//           ),
//           Container(
//             margin: EdgeInsets.all(20),
//             height: 400,
            
//             child: Form(
//               child: ListView(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.all(20),
//                     child: TextField(
//                       controller: dateinput,
//                      style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: 'Start-Date',
//                       labelStyle: TextStyle(
//                         color: Colors.white
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                              width: 3, color: Colors.blue), //<-- SEE HERE
//           ),
//   ),

//             ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(20),
//                     child: TextField(
//                      style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: 'End-Date',
//                       labelStyle: TextStyle(
//                         color: Colors.white
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                              width: 3, color: Colors.blue), //<-- SEE HERE
//           ),
//   ),

//             ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(20),
//                     child: TextField(
//                      style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: 'Volume',
//                       labelStyle: TextStyle(
//                         color: Colors.white
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                              width: 3, color: Colors.blue), //<-- SEE HERE
//           ),
//   ),

//             ),
//                   ),
            
//                 ],
//               ),
//             ),
//           )
          
//         ],
//       ),),
       

//     );
//   }
// }
// class SplineChartDemo extends StatelessWidget {
//    SplineChartDemo({Key? key}) : super(key: key);
//   TextEditingController dateinput = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Color.fromARGB(255, 9, 23, 50),
//       child:Align(alignment: Alignment.topCenter,
//       child: ListView(
        
//         children: [
//           Align(
//             alignment: Alignment.topCenter,
//             child: Container(
//             margin: EdgeInsets.only(top: 50),
//             height: 300,
//           child: 
//             SplineChart(
//             values: {0:10,15:30,60:40,44:50,80:50,100:90},
//             //values: {0:10, 7.69 :52, 15.38 :74, 23.08 :1464, 30.77 :942, 38.46 :2433, 46.15 :2379, 53.85 :3820, 61.54 :2750, 69.23 :2739, 76.92 :3057, 84.62 :1598, 92.31 :1450,100:630},
//             //values: {0.0: 583.0, 50.0: 972.0, 100.0: 910.0},
//             verticalLineEnabled: false,
//             verticalLinePosition: 90.0,
//             verticalLineStrokeWidth: 2.0,
//             verticalLineText: "Your score",
//             drawCircles: true,
//             circleRadius: 4,
//             width: 450,
//             height: 400,
//           ),

//           ),
//           ),
//           Container(
//             margin: EdgeInsets.all(20),
//             height: 400,
            
//             child: Form(
//               child: ListView(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.all(20),
//                     child: TextField(
//                       controller: dateinput,
//                      style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: 'Start-Date',
//                       labelStyle: TextStyle(
//                         color: Colors.white
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                              width: 3, color: Colors.blue), //<-- SEE HERE
//           ),
//   ),

//             ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(20),
//                     child: TextField(
//                      style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: 'End-Date',
//                       labelStyle: TextStyle(
//                         color: Colors.white
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                              width: 3, color: Colors.blue), //<-- SEE HERE
//           ),
//   ),

//             ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.all(20),
//                     child: TextField(
//                      style: TextStyle(color: Colors.white),
//                     decoration: InputDecoration(
//                       labelText: 'Volume',
//                       labelStyle: TextStyle(
//                         color: Colors.white
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                              width: 3, color: Colors.blue), //<-- SEE HERE
//           ),
//   ),

//             ),
//                   ),
            
//                 ],
//               ),
//             ),
//           )
          
//         ],
//       ),),
       

//     );
//   }
// }
  

// // class secondpage extends StatelessWidget {



// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home:  SplineChartDemo(),
// //     );
// //   }
// // }

// // class SplineChartDemo extends StatelessWidget {
// //    SplineChartDemo({Key? key}) : super(key: key);
// //   TextEditingController dateinput = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       color: Color.fromARGB(255, 9, 23, 50),
// //       child:Align(alignment: Alignment.topCenter,
// //       child: ListView(
        
// //         children: [
// //           Align(
// //             alignment: Alignment.topCenter,
// //             child: Container(
// //             margin: EdgeInsets.only(top: 50),
// //             height: 300,
// //           child: 
// //             SplineChart(
// //             values: {0:10,15:30,60:40,44:50,80:50,100:90},
// //             //values: {0:10, 7.69 :52, 15.38 :74, 23.08 :1464, 30.77 :942, 38.46 :2433, 46.15 :2379, 53.85 :3820, 61.54 :2750, 69.23 :2739, 76.92 :3057, 84.62 :1598, 92.31 :1450,100:630},
// //             //values: {0.0: 583.0, 50.0: 972.0, 100.0: 910.0},
// //             verticalLineEnabled: false,
// //             verticalLinePosition: 90.0,
// //             verticalLineStrokeWidth: 2.0,
// //             verticalLineText: "Your score",
// //             drawCircles: true,
// //             circleRadius: 4,
// //             width: 450,
// //             height: 400,
// //           ),

// //           ),
// //           ),
// //           Container(
// //             margin: EdgeInsets.all(20),
// //             height: 400,
            
// //             child: Form(
// //               child: ListView(
// //                 children: [
// //                   Container(
// //                     margin: EdgeInsets.all(20),
// //                     child: TextField(
// //                       controller: dateinput,
// //                      style: TextStyle(color: Colors.white),
// //                     decoration: InputDecoration(
// //                       labelText: 'Start-Date',
// //                       labelStyle: TextStyle(
// //                         color: Colors.white
// //                       ),
// //                       enabledBorder: OutlineInputBorder(
// //                         borderSide: BorderSide(
// //                              width: 3, color: Colors.blue), //<-- SEE HERE
// //           ),
// //   ),

// //             ),
// //                   ),
// //                   Container(
// //                     margin: EdgeInsets.all(20),
// //                     child: TextField(
// //                      style: TextStyle(color: Colors.white),
// //                     decoration: InputDecoration(
// //                       labelText: 'End-Date',
// //                       labelStyle: TextStyle(
// //                         color: Colors.white
// //                       ),
// //                       enabledBorder: OutlineInputBorder(
// //                         borderSide: BorderSide(
// //                              width: 3, color: Colors.blue), //<-- SEE HERE
// //           ),
// //   ),

// //             ),
// //                   ),
// //                   Container(
// //                     margin: EdgeInsets.all(20),
// //                     child: TextField(
// //                      style: TextStyle(color: Colors.white),
// //                     decoration: InputDecoration(
// //                       labelText: 'Volume',
// //                       labelStyle: TextStyle(
// //                         color: Colors.white
// //                       ),
// //                       enabledBorder: OutlineInputBorder(
// //                         borderSide: BorderSide(
// //                              width: 3, color: Colors.blue), //<-- SEE HERE
// //           ),
// //   ),

// //             ),
// //                   ),
            
// //                 ],
// //               ),
// //             ),
// //           )
          
// //         ],
// //       ),),
       

// //     );
// //   }
// // }