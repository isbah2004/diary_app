import 'package:diary_app/addnotes/add_notes_screen.dart';
import 'package:diary_app/home/widgets/item_notes.dart';
import 'package:diary_app/model/note.dart';
import 'package:diary_app/repository/notes_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          )
        ],
        title: const Text('Diary'),
      ),
      body: FutureBuilder(
          future: NotesRepository.getNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData &&
                  (snapshot.data as List<Note>).isNotEmpty) {
                List<Note> notes = snapshot.data! as List<Note>;
                return ListView(
                  padding: const EdgeInsets.all(15),
                  children: [
                    for (var note in notes)
                      ItemNote(
                        note: note,
                      ),
                  ],
                );
              } else {
                return Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddNotes(),
                        ),
                      );
                    },
                    child: const Text(
                      'Add Notes',
                      style: TextStyle(fontSize: 15 ,color: Colors.black),
                    ),
                  ),
                );
              }
            }
            return const SizedBox();
          }),
      //  const Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     ItemNote(),
      //     ItemNote(),
      //     ItemNote(),
      //     ItemNote(),
      //     ItemNote(),
      //     ItemNote(),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNotes(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
