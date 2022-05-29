import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:ms_project/model/emotion.dart';

const double buttonSize = 70;

class MyHomePage extends StatefulWidget {
  static const routeName = '/home-page';

  String moodName = " ";

  MyHomePage({Key? key, required this.moodName}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List<String> sadQuotes = [
    "You say you are depressed, all I see is resilience. You are allowed to feel messed up and inside out. It doesn't mean you are defective, it just means you are human.",
    "You're like a grey sky.You're beautiful, even though you don't want to be.",
    "Even for me life had its gleams of sunshine.",
    "You must hold your quiet center, where you do what only you can do.",
    "Every man has his secret sorrows which the world knows not; and often times we call a man cold when he is only sad.",
  ];

  List<String> fearfulQuotes = [
    "When life gives you something that makes you feel AFRAID that's when life gives you a chance to be BRAVE. -Lupytha Hermin",
    "That rish you're afraid to take, could be the one that changes your entire life. -Kylie Francis",
    "It's OKAY to be scared but DON'T LET that fear overpower your mind and control you.",
    "Sometimes what you're most afraid of doing is the very thing that will set you free."
        "Never let the fear of striking out get in your way. -Babe Ruth",
  ];

  String neutral = "You are doing Great!";

  List<String> happyQuotes = [
    "Be happy in the moment, that's enough. Each moment is all we need, not more. -Mother Teresa",
    "What makes yoy happy doesn't need to make sense to others.",
    "At the end of the day, people will judge you anyway, so do whatever makes YOU happy!",
    "I am happy because I'm grateful. I choose to be grateful. That gratitude allows me to be happy. -Will Arnett",
    "It's a helluva start, being able to recognize what makes you happy!. -Lucille Ball",
  ];

  List<String> disgustedQuotes = [
    "I used to be disgusted; now I try to be amused. -Elvis Costello",
    "Hate. It has caused a lot of problems in this world but has not solved one yet.",
    "We are all here for some special reason. Stop being a prisoner of your past. Become the architect of your future.",
    "The best way to gain self-confidence is to do what you are afraid to do.",
    "We can complain because rose bushes have thorns, or rejoice because thorn bushes have roses.",
  ];

  List<String> angryQuotes = [
    "When you're mad at someone you love, be careful what you say because your mind gets angry but your heart still cares.",
    "If you are patient in one moment of anger, you will escape a hundred days of sorrow.",
    "Anger is a momentary madness, so control your passion or it will control you.",
    "Explain your anger instead of expressing it, and you will find solutions & connection instead of agruments",
    "Be selective in your battles sometimes peace is better than being right.",
  ];

  List<String> surprisedQuotes = [
    "I am not making any plans. I'm just going to let the universe surprise me.",
    "The unexpected moment is always sweeter.",
    "Expect Nothing. Live frugally on Surprise.",
    "If you're going to win games, you're going to have to come up with the big hits. That's the bottom line. -Derek Jeter",
    "I'm not so much surprised by the success of 'Ugly Betty' as I am feeling so blessed by it. -Ana Ortiz",
  ];

  late final List<charts.Series<Emotion, String>> _seriesBarData = [];
  List<Emotion> mydata = [];

  final docRef = FirebaseFirestore.instance.collection("users");
  _generateData(mydata) {
    _seriesBarData.add(
      charts.Series(
          domainFn: (Emotion emotion, _) => emotion.day.toString(),
          measureFn: (Emotion emotion, _) =>
              int.parse(emotion.moodScore.toString()),
          colorFn: (Emotion emotion, _) => charts.ColorUtil.fromDartColor(
                Color(
                  int.parse(emotion.colorVal),
                ),
              ),
          id: 'Emotion',
          data: mydata,
          labelAccessorFn: (Emotion row, _) => row.day),
    );
  }

  bool showLoginPage = false;
  bool loading = false;
  void toggleScreen() {
    setState(
      () {
        showLoginPage = !showLoginPage;
      },
    );
  }

  late AnimationController controller;

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .listen((event) {
      setState(() {
        event.data()?.forEach(
          (key, value) {
            mydata.add(
              Emotion(
                  day: value['day'],
                  moodScore: value['moodScore'],
                  colorVal: value['colorVal']),
            );
          },
        );
        loading = false;
      });
    });

    super.initState();
    sadQuotes.shuffle();
    fearfulQuotes.shuffle();
    happyQuotes.shuffle();
    disgustedQuotes.shuffle();
    angryQuotes.shuffle();
    surprisedQuotes.shuffle();

    // _buildBody(context);
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String quotes() {
    if (widget.moodName == 'Sad') {
      return sadQuotes[0].toString();
    } else if (widget.moodName == 'Fearful') {
      return fearfulQuotes[0].toString();
    } else if (widget.moodName == 'Happy') {
      return happyQuotes[0].toString();
    } else if (widget.moodName == 'Angry') {
      return angryQuotes[0].toString();
    } else if (widget.moodName == 'Surprised') {
      return surprisedQuotes[0].toString();
    } else if (widget.moodName == 'Disgusted') {
      return disgustedQuotes[0].toString();
    } else if (widget.moodName == 'Neutral') {
      return neutral;
    } else {
      return 'Let\'s see your mood for today. Please go to Emotion Detector.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              const Divider(),
              loading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(child: _buildChart(context, mydata)),
              Image.asset(
                'assets/colorScheme.png',
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.22,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Text(
                      quotes(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChart(BuildContext context, List<Emotion> emotion) {
    _generateData(mydata);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          children: [
            const Text(
              'Your Mood Tracker',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: charts.BarChart(
                _seriesBarData,
                animate: true,
                animationDuration: const Duration(
                  seconds: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
