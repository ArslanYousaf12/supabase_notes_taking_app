import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ccxkssfxpokvhwnclybr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNjeGtzc2Z4cG9rdmh3bmNseWJyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjc4MDM3MDAsImV4cCI6MjA0MzM3OTcwMH0.Y83kVbl2Z56nfv0Rqtmv8F3xPGiBFFIQCM5QkQpr83I',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          backgroundColor: Colors.blue,
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
