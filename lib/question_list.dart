class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

List<Question> sampleQuestions = [
  Question(
    questionText: 'Which language is used for Flutter?',
    options: ['Java', 'Dart', 'Kotlin', 'Python'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Firebase is used for?',
    options: ['Backend', 'UI', 'Animation', 'Testing'],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Hot Reload helps in?',
    options: ['Faster debugging', 'Database', 'Designing icons', 'Testing'],
    correctAnswerIndex: 0,
  ),
];
