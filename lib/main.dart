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
    return MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _noteStream =
      Supabase.instance.client.from('notes').stream(primaryKey: ['id']);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _noteStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final notes = snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Text(note['body']),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Text('Add Note'),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Note',
                    ),
                    onFieldSubmitted: (value) async {
                      await Supabase.instance.client
                          .from('notes')
                          .insert({'body': value});
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
