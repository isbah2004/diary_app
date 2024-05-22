import 'package:diary_app/addnotes/add_notes_screen.dart';
import 'package:diary_app/model/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemNote extends StatelessWidget {
  final Note note;
  const ItemNote({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  AddNotes(note: note,),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              child: Column(
                children: [
                  Text(
                    DateFormat(DateFormat.ABBR_MONTH).format(note.createdAt),
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    DateFormat(DateFormat.DAY).format(note.createdAt),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    DateFormat(DateFormat.YEAR).format(note.createdAt),
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          note.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Text(
                        DateFormat(DateFormat.HOUR_MINUTE_GENERIC_TZ)
                            .format(note.createdAt),
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                  Text(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    note.description,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
