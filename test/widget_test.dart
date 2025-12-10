import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const CareerCompassApp());
}

class CareerCompassApp extends StatelessWidget {
  const CareerCompassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CareerCompass',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CareerCompass Home')),
      body: const Center(
        child: Text(
          'Firebase Initialized! Ready for Login 🔥',
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
