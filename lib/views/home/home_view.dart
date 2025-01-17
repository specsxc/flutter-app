import 'package:flutter/material.dart';
import 'package:flutter_app/db/notes_db_crud.dart';
import 'package:flutter_app/db/notes_db_service.dart';
import 'package:flutter_app/utils/my_colors.dart';
import 'package:flutter_app/utils/my_note.dart';
import 'package:flutter_app/utils/my_preferences.dart';
import 'package:flutter_app/utils/my_strings.dart';
import 'package:flutter_app/views/login/login_view.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<void> _signOut(BuildContext context) async {
    await MyPreferences.setLoggedIn(value: false);
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
    );
  }

  late NotesDatabaseCRUD notesService;
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final db = await NotesDatabaseService.instance.database;
    notesService = NotesDatabaseCRUD(db);
    await _loadNotes();
  }

  Future<void> _loadNotes() async {
    final loadedNotes = await notesService.readAllNotes();
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
          backgroundColor: MyColors.grayColorAlert,
          titleTextStyle: TextStyle(
            color: MyColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
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
                decoration: const InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                onChanged: (value) => description = value,
                controller: TextEditingController(text: note?.description),
              ),
              Row(
                children: [
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Row(
                        children: [
                          Checkbox(
                            value: isImportant,
                            onChanged: (value) {
                              setState(() {
                                isImportant = value!;
                              });
                            },
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isImportant = !isImportant;
                              });
                            },
                            child: const Text('Mark as Important'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              if (note != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Created: ${note.createdTime}',
                    style: TextStyle(color: MyColors.grayColor),
                  ),
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
                if (title.isEmpty || description.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('All fields are required.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }
                if (note == null) {
                  final newNote = Note(
                    isImportant: isImportant,
                    number: notes.length + 1,
                    title: title,
                    description: description,
                    createdTime: DateTime.now(),
                  );
                  await notesService.create(newNote);
                } else {
                  final updatedNote = note.copy(
                    title: title,
                    description: description,
                    isImportant: isImportant,
                  );
                  await notesService.update(updatedNote);
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
    await notesService.delete(note.id!);
    await _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.blueBackGroundScaffold,
        body: SingleChildScrollView(
          child: Column(
            children: [
              ColoredBox(
                color: MyColors.purpleNotes,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            MdiIcons.noteOutline,
                            size: 30,
                            color: MyColors.whiteColor,
                          ),
                          Text(
                            MyStrings.notes,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: MyColors.whiteColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () => _signOut(context),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  MyStrings.logOut,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: MyColors.whiteColor,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.logout),
                                onPressed: () {
                                  _signOut(context);
                                },
                                iconSize: 15,
                                tooltip: 'Log Out',
                                color: MyColors.whiteColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: note.isImportant
                          ? MyColors.redColorBackGround
                          : MyColors.yellowColorBackGround,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.blackColor.withValues(alpha: 0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        note.title,
                        style: TextStyle(
                          color: note.isImportant
                              ? MyColors.redColorError
                              : MyColors.blackColor,
                        ),
                      ),
                      isThreeLine: true,
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(note.description),
                          Text(
                            DateFormat('dd/MM HH:mm').format(note.createdTime),
                            style: TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
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
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addOrEditNote,
          backgroundColor: MyColors.purpleFadeColor,
          foregroundColor: MyColors.purpleColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
