import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHighScore extends StatelessWidget {
  const MyHighScore({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Highscore(),
    );
  }
}

class Highscore extends StatefulWidget {
  const Highscore({super.key});

  @override
  State<StatefulWidget> createState() {
    return _High_scoreState();
  }
}

// ignore: camel_case_types
class _High_scoreState extends State<Highscore> {
  String? topUser = '';
  int highScore = 0;

  @override
  void initState() {
    super.initState();
    _loadHighScore();
  }

  // Load high score data from SharedPreferences
  Future<void> _loadHighScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      topUser = prefs.getString('top_user') ?? 'No user';
      highScore = prefs.getInt('high_score') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('High Score'),
        ),
        body: Container(
          height: 300,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 1),
            color: Colors.white,
            boxShadow: const [BoxShadow(blurRadius: 5)]
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(topUser ?? 'No user'),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(highScore.toString()),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Exit',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
