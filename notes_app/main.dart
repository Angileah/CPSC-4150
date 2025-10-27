import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyNotesApp());
}

class MyNotesApp extends StatelessWidget {
  const MyNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes Persistence Demo',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const HomeScreen(),
    );
  }
}

class Note {
  final String content;

  Note({
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        'content': content,
      };

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(content: json['content'] ?? '');
  }
}

class NoteStorage {
  static const String _key = 'notes_list';

  Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.map((item) => Note.fromJson(item)).toList();
    } catch (_) {
      // corrupted or invalid data
      return [];
    }
  }

  Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(notes.map((n) => n.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  Future<void> clearNotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteStorage _storage = NoteStorage();
  final TextEditingController _controller = TextEditingController();
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await _storage.loadNotes();
    setState(() {
      _notes = notes;
    });
  }

  Future<void> _addNote() async {
    if (_controller.text.trim().isEmpty) return;
    final newNote = Note(content: _controller.text.trim());
    setState(() {
      _notes.add(newNote);
    });
    await _storage.saveNotes(_notes);
    _controller.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note saved!')),
    );
  }

  Future<void> _deleteNoteAt(int index) async {
    setState(() {
      _notes.removeAt(index);
    });
    await _storage.saveNotes(_notes);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note deleted!')),
    );
  }

  Future<void> _clearAll() async {
    await _storage.clearNotes();
    setState(() {
      _notes.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notes cleared!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _clearAll,
            tooltip: 'Clear all notes',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter a note',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _addNote(),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _notes.isEmpty
                  ? const Center(
                      child: Text('No notes yet. Add one!'),
                    )
                  : ListView.builder(
                      itemCount: _notes.length,
                      itemBuilder: (context, index) {
                        return NoteTile(
                          note: _notes[index],
                          onDelete: () => _deleteNoteAt(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoteTile extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;

  const NoteTile({super.key, required this.note, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(note.content),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}