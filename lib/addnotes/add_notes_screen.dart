import 'package:diary_app/model/note.dart';
import 'package:diary_app/repository/notes_repository.dart';
import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  final Note? note;
  const AddNotes({super.key, this.note});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final title = TextEditingController();
  final description = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      title.text = widget.note!.title;
      description.text = widget.note!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
        actions: [
          if (widget.note != null)
            IconButton(
              onPressed: deleteNote,
              icon: const Icon(Icons.delete),
            ),
          IconButton(
            onPressed: widget.note == null ? insertNote : updateNote,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: description,
              minLines: 1,
              maxLines: 20,
              decoration: InputDecoration(
                hintText: 'Start typing here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  insertNote() async {
    final note = Note(
      title: title.text,
      description: description.text,
      createdAt: DateTime.now(),
    );
    await NotesRepository.insert(note: note);
    Navigator.pop(context);
  }

  updateNote() async {
    final note = Note(
      id: widget.note!.id,
      title: title.text,
      description: description.text,
      createdAt: widget.note!.createdAt,
    );
    await NotesRepository.update(note: note);
    Navigator.pop(context);
  }

  deleteNote() async {
    NotesRepository.delete(note: widget.note!);
    Navigator.pop(context);
  }
}
