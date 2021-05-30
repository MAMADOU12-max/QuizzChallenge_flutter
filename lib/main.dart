import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizz_challenge/quizz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Quizz vrai ou faux'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void begin() {
     Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
          return new Quizz();
     }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
           child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                    Card(
                         child: Image.asset(
                           'assets/question.jpeg',
                           width: MediaQuery.of(context).size.width / 1.3,
                         ),
                         elevation: 6.0,
                   ),
                   ElevatedButton(
                       onPressed: begin,
                       child: Text(
                           'Commencer le quizz now',
                           style: TextStyle(
                             color: Colors.black,
                             fontSize: 19.0,
                           ),
                       ),
                       style: ButtonStyle(
                            // padding: EdgeInsets.only(left: 50, right: 50),
                            // primary: Colors.blue,
                            // onPrimary: Colors.red,
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                          // padding: MaterialStateProperty.all(value)
                       ),
                   ),
               ],
           ),

      ),
    );
  }
}
