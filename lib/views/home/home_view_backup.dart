import 'package:flutter/material.dart';
import 'package:flutter_app/db/notes_db.dart';
import 'package:flutter_app/utils/my_note.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final loadedNotes = await NotesDatabase.instance.readAllNotes();
    setState(() {
      notes = loadedNotes;
    });
  }

  Future<void> _addOrEditNote({Note? note}) async {
    var title = note?.title ?? '';
    var description = note?.description ?? '';
    var isImportant = note?.isImportant ?? false;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(note == null ? 'Add Note' : 'Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) => title = value,
                controller: TextEditingController(text: note?.title),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (value) => description = value,
                controller: TextEditingController(text: note?.description),
              ),
              Row(
                children: [
                  Checkbox(
                    value: isImportant,
                    onChanged: (value) => setState(() => isImportant = value!),
                  ),
                  const Text('Mark as Important'),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (note == null) {
                  // Create new note
                  final newNote = Note(
                    isImportant: isImportant,
                    number: notes.length + 1,
                    title: title,
                    description: description,
                    createdTime: DateTime.now(),
                  );
                  await NotesDatabase.instance.create(newNote);
                } else {
                  // Update existing note
                  final updatedNote = note.copy(
                    title: title,
                    description: description,
                    isImportant: isImportant,
                  );
                  await NotesDatabase.instance.update(updatedNote);
                }
                Navigator.of(context).pop();
                await _loadNotes();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteNote(Note note) async {
    await NotesDatabase.instance.delete(note.id!);
    await _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.description),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _addOrEditNote(note: note),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteNote(note),
                ),
              ],
            ),
            onTap: () => _addOrEditNote(note: note),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addOrEditNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
