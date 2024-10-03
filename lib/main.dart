import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'class/quiz.dart';
import 'dart:async';

// void RemovePref(){
//   prefs?.remove('counter');
// }

SharedPreferences? prefs;
// ignore: non_constant_identifier_names
int _question_no = 0;
int _point = 0;
final List<QuestionObj> _questions = [];
final int _initValue = 60;
int counter = 60;
// ignore: non_constant_identifier_names
String active_user = "";

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user_id = prefs.getString("user_id") ?? '';
  return user_id;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Quiz(),
    );
  }
}

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    startTimer();
    _questions.add(QuestionObj(
        "Not a member of Avengers",
        'Ironman',
        'Spiderman',
        'Thor',
        'Hulk Hogan',
        'Hulk Hogan',
        'https://i.pinimg.com/originals/8b/01/89/8b01897cc449f955192f9edab8554e26.jpg'));
    _questions.add(QuestionObj(
        "Not a member of Teletubbies",
        'Dipsy',
        'Patrick',
        'Laalaa',
        'Poo',
        'Patrick',
        'https://ichef.bbci.co.uk/images/ic/1200x675/p07ds9pc.jpg'));
    _questions.add(QuestionObj(
        "Not a member of Justice League",
        'batman',
        'aquades',
        'superman',
        'flash',
        'aquades',
        'https://static.wikia.nocookie.net/marvel_dc/images/c/c2/Justice_League_Vol_4_44_Textless_Variant.jpg/revision/latest?cb=20200512210106'));
    _questions.add(QuestionObj(
        "Not a member of BTS",
        'Jungkook',
        'Jimin',
        'Gong Yoo',
        'Suga',
        'Gong Yoo',
        'https://i.pinimg.com/736x/95/db/c7/95dbc7099f82bc680173c1a1f4c29171.jpg'));
    _questions.add(QuestionObj(
        "Menumbuhkan bawang dengan cara",
        'Lapisan bola',
        'Daunnya',
        'Tunas',
        'Rimpang',
        'Lapisan bola',
        'https://asset.kompas.com/crops/IKfz6XNj7umHWJx6VgxTUWt2-l4=/100x67:900x600/750x500/data/photo/2022/03/12/622ca84cdd9a8.jpg'));
    _questions.add(QuestionObj(
        " Lapisan perairan yang menyelimuti permukaan Bumi disebut",
        'Litosfer',
        'Hidrosfer',
        'Stratosfer',
        'Atmosfer',
        'Hidrosfer',
        'https://www.zenius.net/blog/wp-content/uploads/2021/02/water-cycle.jpg'));
    _questions.add(QuestionObj(
        " Daerah di luar atmosfer yang terletak lebih dari 400 km di atas permukaan Bumi adalah",
        'Termosfer',
        'Eksosfer',
        'Mesosfer',
        'Troposfer',
        'Eksosfer',
        'https://blue.kumparan.com/image/upload/fl_progressive,fl_lossy,c_fill,q_auto:best,w_640/v1634025439/01hwq58614y9xmm8gjmksr7f3n.jpg'));
    _questions.add(QuestionObj(
        "Berapa lapisan yang terdapat dalam atmosfer Bumi?",
        '3',
        '5',
        '7',
        '9',
        '5',
        'https://cdn0-production-images-kly.akamaized.net/YOu53X81f9ipe8cItp7fOCfBwZ8=/1200x1200/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/2999991/original/017493100_1576665560-050608500_1539682117-094970900_1464866685-globe.jpg'));
    _questions.add(QuestionObj(
        "Apa fungsi utama dari lapisan atmosfer?",
        'Melindungi Bumi dari radiasi matahari',
        'Mengatur suhu Bumi',
        'Menyebarkan bau-bauan di udara',
        'Menghasilkan hujan asam',
        'Melindungi Bumi dari radiasi matahari',
        'https://cdn1-production-images-kly.akamaized.net/LaFmn0l3epCkk3hkQUCF1a1EYm0=/800x450/smart/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3239515/original/038969200_1600238963-international-space-station-1176518_1920.jpg'));
    _questions.add(QuestionObj(
        "Berapa bagian utama yang terdapat dalam sistem pencernaan manusia?",
        '3',
        '4',
        '5',
        '6',
        '5',
        'https://www.honestdocs.id/system/redactor2_assets/images/321/content_anatomi_sistem_pencernaan__2_.jpg'));
    _questions.add(QuestionObj(
        "Dimana proses pencernaan makanan dimulai?",
        'Mulut',
        'Hati',
        'Usus',
        'Perut',
        'Mulut',
        'https://static.honestdocs.id/989x500/webp/system/blog_articles/main_hero_images/000/006/201/original/iStock-1086539760_%282%29_%281%29.jpg'));
    _questions.add(QuestionObj(
        "Apa yang dimaksud dengan lingkaran?",
        'Himpunan semua titik dalam bidang yang berjarak sama dari titik tetap',
        'Himpunan semua titik dalam bidang yang berjarak sama dari dua titik tetap',
        'Himpunan semua titik dalam bidang yang berjarak sama dari dua titik berbeda',
        'Semua benar',
        'Himpunan semua titik dalam bidang yang berjarak sama dari titik tetap',
        'https://mamatematika.wordpress.com/wp-content/uploads/2016/11/179.png'));
    _questions.add(QuestionObj(
        "Jika sebuah lingkaran memiliki jari-jari sepanjang 10 cm, berapakah diameter lingkaran tersebut?",
        '5',
        '10',
        '15',
        '20',
        '20',
        'https://cdnwpedutorenews.gramedia.net/wp-content/uploads/2024/07/08152038/620cd127ec905.png'));
    _questions.add(QuestionObj(
        "Luas juring dengan sudut pusat 90 derajat dan jari-jari 8 cm adalah:",
        '16π cm²',
        '64π cm²',
        '32π cm²',
        '128π cm²',
        '32π cm²',
        'https://akupintar.id/documents/portlet_file_entry/20143/1.png/d3cae7a9-5811-c6c3-3453-101122d576da?imagePreview=1'));
    _questions.shuffle();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (counter == 0) {
          _timer.cancel();
          showDialog(context: context, builder: _buildEndDialog);
        } else {
          counter--;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  AlertDialog _buildEndDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Quiz Ended!'),
      content: const Text('The quiz has ended.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            setState(() {
              counter = _initValue;
              startTimer();
              _questions.shuffle();
            });
            Navigator.of(context).pop();
          },
          child: const Text('Restart'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Center(child: Text("No questions available."));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Timer'),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                LinearPercentIndicator(
                  center: Text(
                    formatTime(counter),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  width: MediaQuery.of(context).size.width,
                  lineHeight: 30.0,
                  percent: counter / _initValue,
                  backgroundColor: Colors.grey,
                  progressColor: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 50),
            Positioned(
              top: 10,
              left: MediaQuery.of(context).size.width / 2 -
                  100, // Center the image horizontally
              child: Container(
                margin: const EdgeInsets.all(16.0), // Add margin here
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(_questions[_question_no].picture),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Positioned(
              top: 240,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Text(_questions[_question_no].narration),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () =>
                        checkAnswer(_questions[_question_no].optionA),
                    child: Text("A. ${_questions[_question_no].optionA}"),
                  ),
                  TextButton(
                    onPressed: () =>
                        checkAnswer(_questions[_question_no].optionB),
                    child: Text("B. ${_questions[_question_no].optionB}"),
                  ),
                  TextButton(
                    onPressed: () =>
                        checkAnswer(_questions[_question_no].optionC),
                    child: Text("C. ${_questions[_question_no].optionC}"),
                  ),
                  TextButton(
                    onPressed: () =>
                        checkAnswer(_questions[_question_no].optionD),
                    child: Text("D. ${_questions[_question_no].optionD}"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkAnswer(String answer) {
    setState(() {
      if (answer == _questions[_question_no].answer) {
        _point += 100;
      }
      // Check if this is the last question
      if (_question_no == _questions.length - 1) {
        endGame();
      } else {
        _question_no++;
        counter = _initValue;
        _timer.cancel();
        startTimer();
      }
    });
  }

  void endGame() {
    _timer.cancel();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz Finished!'),
          content: Text('Your final score: $_point points'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  counter = _initValue;
                  _point = 0;
                  _question_no = 0;
                  startTimer();
                  _questions.shuffle();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Restart Quiz'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  String formatTime(int hitung) {
    var hours = (hitung ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((hitung % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (hitung % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  checkUser().then((String result) {
    if (result == '') {
      runApp(MyLogin());
    } else {
      active_user = result;
      runApp(MyApp());
    }
  });
  // runApp(const MyApp());
}
