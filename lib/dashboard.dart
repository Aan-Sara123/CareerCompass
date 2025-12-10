import 'package:flutter/material.dart';
import 'skill_test.dart';

class DashboardPage extends StatefulWidget {
  final String userName;

  const DashboardPage({super.key, required this.userName});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<int> _pastScores = [3, 2, 4];
  int? _latestScore;

  void _startSkillTest() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SkillTestPage()),
    );

    if (result != null && result is int) {
      setState(() {
        _latestScore = result;
        _pastScores.add(result);
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You scored $result in the test!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CareerCompass Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${widget.userName}!',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            if (_latestScore != null) ...[
              const SizedBox(height: 12),
              Text(
                'Latest Score: $_latestScore / 3',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
            const SizedBox(height: 24),
            const Text(
              'Your Past Test Scores:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _pastScores.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.check_circle_outline),
                    title: Text('Test ${index + 1}'),
                    trailing: Text('${_pastScores[index]} / 3'),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _startSkillTest,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Start Skill Test'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
