import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';

class Result extends StatefulWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback resetHandler;

  const Result(this.score, this.totalQuestions, this.resetHandler, {Key? key})
      : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  // final score = FirebaseFirestore.instance.collection('users').doc('score');

  String getRemarks() {
    // getScore();
    storeScore();
    if (widget.score == widget.totalQuestions) {
      return 'Perfect Score! Congratulations!';
    } else if (widget.score >= widget.totalQuestions * 0.8) {
      return 'Great Job! You did well!';
    } else if (widget.score >= widget.totalQuestions * 0.5) {
      return 'Good Effort! Keep it up!';
    } else {
      return 'You can do better. Keep learning!';
    }
  }

  Future<String?> getScore() async {
    return null;

    // DocumentSnapshot snapshot =
    //     await FirebaseFirestore.instance.collection('users').doc('score').get();
    // if (snapshot.exists) {
    //   final data = snapshot.data();
    //   // if (data.containsKey('score')) {
    //     return data['score'].toString();
    //   // }
    //   // return snapshot.data['scores'];
    // }
    // // Return a default value or handle the case when the document or field doesn't exist.
    // return "0";

    // final userScoresRef = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc('score');
    //     // .collection('scores');
    // final querySnapshot = await userScoresRef.get();
    //
    // return querySnapshot.${doc.scores};
  }

  storeScore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // final userUid = user.uid;
      // final scoreData = {
      //   'score': widget.score,
      // };

      final userScoresRef =
          FirebaseFirestore.instance.collection('users').doc('score');
      // .collection('scores');

      await userScoresRef.update({
        'scores': widget.score,
      });
    } else {
      debugPrint("user null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Quiz Completed!',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Your Score: ${widget.score} / ${widget.totalQuestions}',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16.0),
          Text(
            storeScore(),
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Text(
            getRemarks(),
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () {
              widget.resetHandler();
              Navigator.pushReplacementNamed(context, '/');
            },
            child: const Text(
              'Restart Quiz',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _questions = [
    {
      'questionText': 'Q1. A local variable is stored in _',
      'answers': [
        {'text': 'Stack Segment', 'isCorrect': true},
        {'text': 'Code segment', 'isCorrect': false},
        {'text': 'Heap segment', 'isCorrect': false},
        {'text': 'None of the above', 'isCorrect': false},
      ],
    },
    {
      'questionText': 'Q2. “Stderr” is a standard error.',
      'answers': [
        {'text': 'True', 'isCorrect': false},
        {'text': 'Standard error streams', 'isCorrect': true},
        {'text': 'Standard error types', 'isCorrect': false},
        {'text': 'Standard error function', 'isCorrect': false},
      ],
    },
    {
      'questionText':
          'Q3. During preprocessing, the code “#include<stdio.h>” gets replaced by the contents of the file stdio.h.',
      'answers': [
        {'text': 'No, happens during linking of code', 'isCorrect': false},
        {'text': 'Yes', 'isCorrect': true},
        {'text': 'No, happens during execution of code', 'isCorrect': false},
        {'text': 'No, happens during editing of code', 'isCorrect': false},
      ],
    },
    {
      'questionText': 'Q4.  The type name/reserved word ‘short’ is _',
      'answers': [
        {'text': 'short long', 'isCorrect': false},
        {'text': 'short int', 'isCorrect': true},
        {'text': 'short char', 'isCorrect': false},
        {'text': 'short float', 'isCorrect': false},
      ],
    },
    {
      'questionText': 'Q5.  Linker generates _ file.',
      'answers': [
        {'text': 'Object code', 'isCorrect': false},
        {'text': 'Assembly code', 'isCorrect': false},
        {'text': 'Executable code', 'isCorrect': true},
        {'text': 'None', 'isCorrect': false},
      ],
    },
  ];

  int _questionIndex = 0;
  int _score = 0;

  void _answerQuestion(bool isCorrect) {
    setState(() {
      if (isCorrect) {
        _score++;
      }
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizzy', textAlign: TextAlign.center),
        backgroundColor: Colors.red, // Set the app bar background color
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              questionIndex: _questionIndex,
              questions: _questions,
              answerQuestion: _answerQuestion,
            )
          : Result(_score, _questions.length, _resetQuiz),
    );
  }
}

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, dynamic>> questions;
  final Function(bool) answerQuestion;

  const Quiz({
    Key? key,
    required this.questionIndex,
    required this.questions,
    required this.answerQuestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Question ${questionIndex + 1} / ${questions.length}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.transparent, // Set the text color
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            questions[questionIndex]['questionText'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ...questions[questionIndex]['answers']
                  .asMap()
                  .entries
                  .map((entry) {
                final answer = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () => answerQuestion(answer['isCorrect']),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent, // Set the text color
                      elevation: 2,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 24.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: Text(
                      answer['text'],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }
}
