import 'package:flutter/material.dart';
import 'models/question.dart';

class SkillTestPage extends StatefulWidget {
  const SkillTestPage({super.key});

  @override
  State<SkillTestPage> createState() => _SkillTestPageState();
}

class _SkillTestPageState extends State<SkillTestPage> {
  final List<Question> _questions = [
    Question(
      questionText: 'Which programming language is used for Flutter?',
      options: ['Java', 'Dart', 'Python', 'C++'],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText: 'What does Firebase provide?',
      options: ['Database', 'Auth', 'Storage', 'All of these'],
      correctAnswerIndex: 3,
    ),
    Question(
      questionText: 'Which widget is used for layout in Flutter?',
      options: ['Column', 'Container', 'Text', 'Row'],
      correctAnswerIndex: 0,
    ),
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOption;

  void _nextQuestion() {
    if (_selectedOption != null &&
        _selectedOption ==
            _questions[_currentQuestionIndex].correctAnswerIndex) {
      _score++;
    }

    setState(() {
      _selectedOption = null;
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _finishTest();
      }
    });
  }

  void _finishTest() {
    // Return score to previous page (Dashboard)
    Navigator.pop(context, _score);
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Skill Test')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              question.questionText,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            RadioGroup<int>(
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                });
              },
              child: Column(
                children: List.generate(question.options.length, (index) {
                  return ListTile(
                    title: Text(question.options[index]),
                    leading: Radio<int>(value: index),
                    onTap: () {
                      setState(() {
                        _selectedOption = index;
                      });
                    },
                  );
                }),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _selectedOption != null ? _nextQuestion : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(
                _currentQuestionIndex == _questions.length - 1
                    ? 'Submit'
                    : 'Next',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
