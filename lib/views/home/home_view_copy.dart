import 'package:flutter/material.dart';
import 'package:flutter_app/db/notes_db.dart';
import 'package:flutter_app/utils/my_colors.dart';
import 'package:flutter_app/utils/my_note.dart';
import 'package:flutter_app/utils/my_preferences.dart';
import 'package:flutter_app/utils/my_strings.dart';
import 'package:flutter_app/views/login/login_view.dart';

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
/*    resetDatabase();*/
  }

  /*Future<void> resetDatabase() async {
    await NotesDatabase.instance.resetDatabase();
  }*/

  Future<void> _loadNotes() async {
    final loadedNotes = await NotesDatabase.instance.readAllNotes();
    setState(() {
      notes = loadedNotes;
    });
  }

  Future<void> _addOrEditNote({Note? note}) async {
    // Inicjalizacja zmiennych
    String title = note?.title ?? '';
    String description = note?.description ?? '';
    bool isImportant = note?.isImportant ?? false;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(note == null ? 'Add Note' : 'Edit Note'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pole tekstowe dla tytułu
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      errorText: null, // Na początek brak błędu
                    ),
                    onChanged: (value) {
                      title = value;
                      setState(() {}); // Odświeżenie dialogu
                    },
                    controller: TextEditingController.fromValue(
                      TextEditingValue(text: title),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Pole tekstowe dla opisu
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      errorText: null, // Na początek brak błędu
                    ),
                    onChanged: (value) {
                      description = value;
                      setState(() {});
                    },
                    controller: TextEditingController.fromValue(
                      TextEditingValue(text: description),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: isImportant,
                        onChanged: (value) {
                          setState(() {
                            isImportant = value!;
                          });
                        },
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
                    // Walidacja pustych pól
                    if (title.isEmpty || description.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('All fields are required.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    // Dodawanie lub edycja notatki
                    if (note == null) {
                      // Tworzenie nowej notatki
                      final newNote = Note(
                        isImportant: isImportant,
                        number: notes.length + 1,
                        title: title,
                        description: description,
/*                        createdTime: DateTime.now(),*/
                      );
                      await NotesDatabase.instance.create(newNote);
                    } else {
                      // Aktualizacja istniejącej notatki
                      final updatedNote = note.copy(
                        title: title,
                        description: description,
                        isImportant: isImportant,
                      );
                      await NotesDatabase.instance.update(updatedNote);
                    }
                    Navigator.of(context).pop(); // Zamknięcie dialogu
                    await _loadNotes(); // Odświeżenie listy notatek
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _deleteNote(Note note) async {
    await NotesDatabase.instance.delete(note.id!);
    await _loadNotes();
  }

  Future<void> _signOut(BuildContext context) async {
    await MyPreferences.setLoggedIn(value: false);
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Header with logout button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    MyStrings.logOut,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: MyColors.purpleColor,
                      fontFamily: 'Inter',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () => _signOut(context),
                  ),
                ],
              ),
              // Notes list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addOrEditNote,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
