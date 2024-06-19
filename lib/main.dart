// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Matching Quiz',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: QuizScreen(),
//     );
//   }
// }

// class QuizScreen extends StatefulWidget {
//   @override
//   _QuizScreenState createState() => _QuizScreenState();
// }

// class _QuizScreenState extends State<QuizScreen> {
//   List<Question> _questions = [
//     Question(
//       image: 'assets/apples.png',
//       options: ['Flower', 'Apples', 'House', 'Car'],
//       correctAnswer: 'Apples',
//     ),
//     Question(
//       image: 'assets/dog.png',
//       options: ['Dog', 'Cat', 'Bird', 'Fish'],
//       correctAnswer: 'Dog',
//     ),
//     Question(
//       image: 'assets/onion.png',
//       options: ['Onion', 'Banana', 'Orange', 'Grapes'],
//       correctAnswer: 'Onion',
//     ),
//     Question(
//       image: 'assets/key.png',
//       options: ['Key', 'Pen', 'Pencil', 'Chair'],
//       correctAnswer: 'Key',
//     ),
//     Question(
//       image: 'assets/train.png',
//       options: ['Train', 'Moon', 'Cloud', 'Rain'],
//       correctAnswer: 'Train',
//     ),
//     Question(
//       image: 'assets/box.png',
//       options: ['Box', 'Car', 'Train', 'Boat'],
//       correctAnswer: 'Box',
//     ),
//     Question(
//       image: 'assets/hand.png',
//       options: ['Hand', 'Basketball', 'Tennis', 'Baseball'],
//       correctAnswer: 'Hand',
//     ),
//     Question(
//       image: 'assets/pen.png',
//       options: ['Pen', 'Piano', 'Drums', 'Violin'],
//       correctAnswer: 'Pen',
//     ),
//     Question(
//       image: 'assets/phone.png',
//       options: ['Phone', 'Pizza', 'Ice Cream', 'Sandwich'],
//       correctAnswer: 'Phone',
//     ),
//     Question(
//       image: 'assets/bird.png',
//       options: ['Bird', 'Phone', 'Tablet', 'TV'],
//       correctAnswer: 'Bird',
//     ),
//   ];

//   int _currentQuestion = 0;

//   int _score = 0;

//   int _errors = 0;

//   bool _isLastQuestion = false;
//   final FlutterTts _flutterTts = FlutterTts();

//   @override
//   void initState() {
//     super.initState();

//     _initTts();

//     // Shuffle questions and options

//     _questions.shuffle();

//     for (var question in _questions) {
//       question.options.shuffle();
//     }

//     _readImageName(_questions[_currentQuestion].image);
//   }

//   Future _initTts() async {
//     await _flutterTts.setLanguage("en-US");

//     await _flutterTts.setPitch(1.0);
//   }

//   Future _readImageName(String imageName) async {
//     await _flutterTts.speak(imageName.split('/').last.split('.').first);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Matching Quiz'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text(
//             'Current Question: ${_currentQuestion + 1}/${_questions.length}',
//             style: TextStyle(fontSize: 18),
//           ),
//           Text(
//             'Score: $_score',
//             style: TextStyle(fontSize: 18),
//           ),
//           Text(
//             'Errors: $_errors',
//             style: TextStyle(fontSize: 18),
//           ),
//           _currentQuestion < _questions.length
//               ? QuestionWidget(
//                   question: _questions[_currentQuestion],
//                   onAnswer: (answer) async {
//                     setState(() {
//                       if (answer ==
//                           _questions[_currentQuestion].correctAnswer) {
//                         _score++;
//                       } else {
//                         _errors++;
//                       }
//                     });

//                     await _flutterTts
//                         .speak(_questions[_currentQuestion].correctAnswer);

//                     if (_currentQuestion < _questions.length - 1) {
//                       setState(() {
//                         _currentQuestion++;

//                         _readImageName(_questions[_currentQuestion].image);
//                       });
//                     } else {
//                       // Navigate to ResultScreen when last question is answered
//                       _flutterTts.stop();
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ResultScreen(
//                             score: _score,
//                             errors: _errors,
//                             totalQuestions: _questions.length,
//                             isLastQuestion: true,
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 )
//               : Container(),
//         ],
//       ),
//     );
//   }
// }

// class Question {
//   final String image;

//   final List<String> options;

//   final String correctAnswer;

//   Question(
//       {required this.image,
//       required this.options,
//       required this.correctAnswer});
// }

// class QuestionWidget extends StatefulWidget {
//   final Question question;

//   final Function(String) onAnswer;

//   QuestionWidget({required this.question, required this.onAnswer});

//   @override
//   _QuestionWidgetState createState() => _QuestionWidgetState();
// }

// class _QuestionWidgetState extends State<QuestionWidget> {
//   String? _selectedAnswer;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Image.asset(widget.question.image),
//         SizedBox(height: 20),
//         Wrap(
//           spacing: 10,
//           children: widget.question.options.map((option) {
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _selectedAnswer = option;
//                   widget.onAnswer(_selectedAnswer!);

//                   setState(() {
//                     _selectedAnswer = null;
//                   });
//                 });
//               },
//               child: Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color:
//                         _selectedAnswer == option ? Colors.blue : Colors.grey,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Text(option),
//               ),
//             );
//           }).toList(),
//         ),
//         SizedBox(height: 20),

//         // ElevatedButton(
//         //   onPressed: _selectedAnswer != null
//         //       ? () {
//         //           widget.onAnswer(_selectedAnswer!);

//         //           setState(() {
//         //             _selectedAnswer = null;
//         //           });
//         //         }
//         //       : null,
//         //   child: Text('Submit'),
//         // ),
//       ],
//     );
//   }
// }

// class ResultScreen extends StatelessWidget {
//   final int score;
//   final int errors;
//   final int totalQuestions;
//   final bool isLastQuestion;

//   ResultScreen({
//     required this.score,
//     required this.errors,
//     required this.totalQuestions,
//     required this.isLastQuestion,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (isLastQuestion) {
//       return Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'You scored $score out of $totalQuestions',
//                 style: TextStyle(fontSize: 24),
//               ),
//               Text(
//                 'You made $errors errors',
//                 style: TextStyle(fontSize: 18),
//               ),
//               Text(
//                 'Your percentage is ${(score / totalQuestions) * 100}%',
//                 style: TextStyle(fontSize: 18),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => QuizScreen()),
//                   );
//                 },
//                 child: Text('Play Again'),
//               ),
//             ],
//           ),
//         ),
//       );
//     } else {
//       return Container(); // or any other widget you want to display
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Matching Quiz',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: QuizScreen(),
//     );
//   }
// }

// class QuizScreen extends StatefulWidget {
//   @override
//   _QuizScreenState createState() => _QuizScreenState();
// }

// class _QuizScreenState extends State<QuizScreen> {
//   List<Question> _questions = [
//     Question(
//       image: 'assets/apples.png',
//       options: ['Flower', 'Apples', 'House', 'Car'],
//       correctAnswer: 'Apples',
//     ),
//     Question(
//       image: 'assets/dog.png',
//       options: ['Dog', 'Cat', 'Bird', 'Fish'],
//       correctAnswer: 'Dog',
//     ),
//     Question(
//       image: 'assets/onion.png',
//       options: ['Onion', 'Banana', 'Orange', 'Grapes'],
//       correctAnswer: 'Onion',
//     ),
//     Question(
//       image: 'assets/key.png',
//       options: ['Key', 'Pen', 'Pencil', 'Chair'],
//       correctAnswer: 'Key',
//     ),
//     Question(
//       image: 'assets/train.png',
//       options: ['Train', 'Moon', 'Cloud', 'Rain'],
//       correctAnswer: 'Train',
//     ),
//     Question(
//       image: 'assets/box.png',
//       options: ['Box', 'Car', 'Train', 'Boat'],
//       correctAnswer: 'Box',
//     ),
//     Question(
//       image: 'assets/hand.png',
//       options: ['Hand', 'Basketball', 'Tennis', 'Baseball'],
//       correctAnswer: 'Hand',
//     ),
//     Question(
//       image: 'assets/pen.png',
//       options: ['Pen', 'Piano', 'Drums', 'Violin'],
//       correctAnswer: 'Pen',
//     ),
//     Question(
//       image: 'assets/phone.png',
//       options: ['Phone', 'Pizza', 'Ice Cream', 'Sandwich'],
//       correctAnswer: 'Phone',
//     ),
//     Question(
//       image: 'assets/bird.png',
//       options: ['Bird', 'Phone', 'Tablet', 'TV'],
//       correctAnswer: 'Bird',
//     ),
//   ];

//   int _currentQuestion = 0;

//   int _score = 0;

//   int _errors = 0;

//   // bool _isLastQuestion = false;
//   final FlutterTts _flutterTts = FlutterTts();

//   @override
//   void initState() {
//     super.initState();

//     _initTts();

//     // Shuffle questions and options

//     _questions.shuffle();

//     for (var question in _questions) {
//       question.options.shuffle();
//     }

//     _readImageName(_questions[_currentQuestion].image);
//   }

//   Future _initTts() async {
//     await _flutterTts.setLanguage("en-US");

//     await _flutterTts.setPitch(1.0);
//   }

//   Future _readImageName(String imageName) async {
//     await _flutterTts.speak(imageName.split('/').last.split('.').first);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Matching Quiz'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Text(
//             'Current Question: ${_currentQuestion + 1}/${_questions.length}',
//             style: const TextStyle(fontSize: 18),
//           ),
//           Text(
//             'Score: $_score',
//             style: TextStyle(fontSize: 18),
//           ),
//           Text(
//             'Errors: $_errors',
//             style: TextStyle(fontSize: 18),
//           ),
//           _currentQuestion < _questions.length
//               ? QuestionWidget(
//                   question: _questions[_currentQuestion],
//                   onAnswer: (answer) async {
//                     setState(() {
//                       if (answer ==
//                           _questions[_currentQuestion].correctAnswer) {
//                         _score++;
//                       } else {
//                         _errors++;
//                       }
//                     });

//                     // await _flutterTts
//                     //     .speak(_questions[_currentQuestion].correctAnswer);

//                     // await Future.delayed(
//                     //     Duration(seconds: 2)); // Add a 2 second delay

//                     if (_currentQuestion < _questions.length - 1) {
//                       setState(() {
//                         _currentQuestion++;

//                         _readImageName(_questions[_currentQuestion].image);
//                       });
//                     } else {
//                       // Navigate to ResultScreen when last question is answered
//                       _flutterTts.stop();
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ResultScreen(
//                             score: _score,
//                             errors: _errors,
//                             totalQuestions: _questions.length,
//                             isLastQuestion: true,
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                 )
//               : Container(),
//         ],
//       ),
//     );
//   }
// }

// class Question {
//   final String image;

//   final List<String> options;

//   final String correctAnswer;

//   Question(
//       {required this.image,
//       required this.options,
//       required this.correctAnswer});
// }

// class QuestionWidget extends StatefulWidget {
//   final Question question;

//   final Function(String) onAnswer;

//   QuestionWidget({required this.question, required this.onAnswer});

//   @override
//   _QuestionWidgetState createState() => _QuestionWidgetState();
// }

// class _QuestionWidgetState extends State<QuestionWidget> {
//   String? _selectedAnswer;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Image.asset(widget.question.image),
//         SizedBox(height: 20),
//         Wrap(
//           spacing: 10,
//           children: widget.question.options.map((option) {
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _selectedAnswer = option;
//                 });
//               },
//               child: Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color:
//                         _selectedAnswer == option ? Colors.blue : Colors.grey,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Text(option),
//               ),
//             );
//           }).toList(),
//         ),
//         SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: _selectedAnswer != null
//               ? () {
//                   widget.onAnswer(_selectedAnswer!);

//                   setState(() {
//                     _selectedAnswer = null;
//                   });
//                 }
//               : null,
//           child: Text('Submit'),
//         ),
//       ],
//     );
//   }
// }

// class ResultScreen extends StatelessWidget {
//   final int score;
//   final int errors;
//   final int totalQuestions;
//   final bool isLastQuestion;

//   ResultScreen({
//     required this.score,
//     required this.errors,
//     required this.totalQuestions,
//     required this.isLastQuestion,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (isLastQuestion) {
//       return Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'You scored $score out of $totalQuestions',
//                 style: TextStyle(fontSize: 24),
//               ),
//               Text(
//                 'You made $errors errors',
//                 style: TextStyle(fontSize: 18),
//               ),
//               Text(
//                 'Your percentage is ${(score / totalQuestions) * 100}%',
//                 style: TextStyle(fontSize: 18),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => QuizScreen()),
//                   );
//                 },
//                 child: Text('Play Again'),
//               ),
//             ],
//           ),
//         ),
//       );
//     } else {
//       return Container(); // or any other widget you want to display
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matching Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [
    Question(
      image: 'assets/apples.png',
      options: ['Flower', 'Apples', 'House', 'Car'],
      correctAnswer: 'Apples',
    ),
    Question(
      image: 'assets/dog.png',
      options: ['Dog', 'Cat', 'Bird', 'Fish'],
      correctAnswer: 'Dog',
    ),
    Question(
      image: 'assets/onion.png',
      options: ['Onion', 'Banana', 'Orange', 'Grapes'],
      correctAnswer: 'Onion',
    ),
    Question(
      image: 'assets/key.png',
      options: ['Key', 'Pen', 'Pencil', 'Chair'],
      correctAnswer: 'Key',
    ),
    Question(
      image: 'assets/train.png',
      options: ['Train', 'Moon', 'Cloud', 'Rain'],
      correctAnswer: 'Train',
    ),
    Question(
      image: 'assets/box.png',
      options: ['Box', 'Car', 'Train', 'Boat'],
      correctAnswer: 'Box',
    ),
    Question(
      image: 'assets/hand.png',
      options: ['Hand', 'Basketball', 'Tennis', 'Baseball'],
      correctAnswer: 'Hand',
    ),
    Question(
      image: 'assets/pen.png',
      options: ['Pen', 'Piano', 'Drums', 'Violin'],
      correctAnswer: 'Pen',
    ),
    Question(
      image: 'assets/phone.png',
      options: ['Phone', 'Pizza', 'Ice Cream', 'Sandwich'],
      correctAnswer: 'Phone',
    ),
    Question(
      image: 'assets/bird.png',
      options: ['Bird', 'Phone', 'Tablet', 'TV'],
      correctAnswer: 'Bird',
    ),
  ];

  int _currentQuestion = 0;

  int _score = 0;

  int _errors = 0;

  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();

    _initTts();

    // Shuffle questions and options

    _questions.shuffle();

    for (var question in _questions) {
      question.options.shuffle();
    }

    _readImageName(_questions[_currentQuestion].image);
  }

  Future _initTts() async {
    await _flutterTts.setLanguage("en-US");

    await _flutterTts.setPitch(1.0);
  }

  Future _readImageName(String imageName) async {
    await _flutterTts.speak(imageName.split('/').last.split('.').first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matching Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Current Question: ${_currentQuestion + 1}/${_questions.length}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Score: $_score',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Errors: $_errors',
            style: TextStyle(fontSize: 18),
          ),
          _currentQuestion < _questions.length
              ? QuestionWidget(
                  question: _questions[_currentQuestion],
                  onAnswer: (answer) async {
                    setState(() {
                      if (answer ==
                          _questions[_currentQuestion].correctAnswer) {
                        _score++;
                      } else {
                        _errors++;
                      }
                    });

                    // await _flutterTts
                    //    .speak(_questions[_currentQuestion].correctAnswer);

                    if (_currentQuestion < _questions.length - 1) {
                      setState(() {
                        _currentQuestion++;

                        _readImageName(_questions[_currentQuestion].image);
                      });
                    } else {
                      // Navigate to ResultScreen when last question is answered
                      _flutterTts.stop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultScreen(
                            score: _score,
                            errors: _errors,
                            totalQuestions: _questions.length,
                            isLastQuestion: true,
                          ),
                        ),
                      );
                    }
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}

class Question {
  final String image;

  final List<String> options;

  final String correctAnswer;

  Question(
      {required this.image,
      required this.options,
      required this.correctAnswer});
}

//1111111111
class QuestionWidget extends StatefulWidget {
  final Question question;

  final Function(String) onAnswer;

  QuestionWidget({required this.question, required this.onAnswer});

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

// class _QuestionWidgetState extends State<QuestionWidget> {
//   String? _selectedAnswer;
//   bool _isWaiting = false; // متغير لتحديد ما إذا كنا في فاصل زمني أم لا

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Image.asset(widget.question.image),
//         SizedBox(height: 20),
//         Wrap(
//           spacing: 10,
//           children: widget.question.options.map((option) {
//             return GestureDetector(
//               onTap: _isWaiting
//                   ? null // إذا كنا في فاصل زمني، لا نسمح بالاختيار
//                   : () async {
//                       setState(() {
//                         _selectedAnswer = option;
//                         _isWaiting =
//                             true; // نضع المتغير على true أثناء الانتظار
//                       });

//                       await widget.onAnswer(_selectedAnswer!);

//                       // await Future.delayed(
//                       //     Duration(seconds: 2)); // فاصل زمني لمدة 2 ثانية

//                       setState(() {
//                         _isWaiting =
//                             false; // نضع المتغير على false بعد الانتهاء من الفاصل الزمني
//                       });
//                     },
//               child: Container(
//                 padding: EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color:
//                         _selectedAnswer == option ? Colors.blue : Colors.grey,
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Text(option),
//               ),
//             );
//           }).toList(),
//         ),
//       ],
//     );
//   }
// }

///////////222222222222
///
///
///

class _QuestionWidgetState extends State<QuestionWidget> {
  String? _selectedAnswer;
  bool _imageVisible = false;
  bool _optionsVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _imageVisible = true;
      });
    });
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _optionsVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          top: _imageVisible ? 0 : MediaQuery.of(context).size.height,
          child: Image.asset(widget.question.image),
        ),
        SizedBox(height: 20),
        AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          top: _optionsVisible ? 0 : MediaQuery.of(context).size.height,
          child: Wrap(
            spacing: 10,
            children: widget.question.options.map((option) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedAnswer = option;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _selectedAnswer == option ? Colors.blue : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(option),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _selectedAnswer != null
              ? () {
                  widget.onAnswer(_selectedAnswer!);

                  setState(() {
                    _selectedAnswer = null;
                  });
                }
              : null,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
 
class ResultScreen extends StatelessWidget {
  final int score;
  final int errors;
  final int totalQuestions;
  final bool isLastQuestion;

  ResultScreen({
    required this.score,
    required this.errors,
    required this.totalQuestions,
    required this.isLastQuestion,
  });

  @override
  Widget build(BuildContext context) {
    if (isLastQuestion) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You scored $score out of $totalQuestions',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'You made $errors errors',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'Your percentage is ${(score / totalQuestions) * 100}%',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => QuizScreen()),
                  );
                },
                child: Text('Play Again'),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(); // or any other widget you want to display
    }
  }
}
