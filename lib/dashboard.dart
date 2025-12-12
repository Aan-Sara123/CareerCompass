import 'package:flutter/material.dart';
import 'skill_test.dart';
import 'database_service.dart';

class DashboardPage extends StatefulWidget {
  final String userName;

  const DashboardPage({super.key, required this.userName});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DatabaseService _dbService = DatabaseService();

  List<int> _pastScores = [];
  int? _latestScore;

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  Future<void> _loadScores() async {
    final scores = await _dbService.getPastScores();
    if (!mounted) return;

    setState(() {
      _pastScores = scores;
      if (_pastScores.isNotEmpty) _latestScore = _pastScores.first;
    });
  }

  void _startSkillTest() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SkillTestPage()),
    );

    if (result != null && result is int) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You scored $result!')),
      );

      _loadScores(); // refresh UI after new score
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
                'Latest Score: $_latestScore',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
            const SizedBox(height: 24),
            const Text(
              'Your Past Test Scores:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _pastScores.isEmpty
                  ? const Center(
                      child: Text(
                        "No scores yet. Start your first skill test!",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _pastScores.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.check_circle_outline),
                          title: Text('Test ${index + 1}'),
                          trailing: Text('${_pastScores[index]}'),
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
