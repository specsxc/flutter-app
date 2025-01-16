import 'package:flutter_app/utils/my_note.dart';
import 'package:sqflite/sqflite.dart';

class NotesDatabaseCRUD {
  final Database db;

  NotesDatabaseCRUD(this.db);

  Future<Note> create(Note note) async {
    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    final maps = await db.query(
      tableNotes,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final result = await db.query(tableNotes);
    print('Loaded notes: $result');

    return result.map(Note.fromJson).toList();
  }

  Future<int> update(Note note) async {
    return db.update(
      tableNotes,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    return db.delete(
      tableNotes,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
  }
}
