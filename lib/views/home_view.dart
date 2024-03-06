import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newinterviewtask/controllers/note_controller.dart';
import 'package:newinterviewtask/models/note.dart';


class NoteListView extends StatelessWidget {
  final NoteController _noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note App'),
      ),
      body: Obx(
            () => ListView.builder(
          itemCount: _noteController.notes.length,
          itemBuilder: (context, index) {
            final note = _noteController.notes[index];
            return ListTile(
              title: Text(note.title),
              subtitle: Text(note.content),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showEditNoteDialog(context, note, index);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _noteController.deleteNote(index);
                    },
                  ),
                ],
              ),
              onTap: () {
                // Add functionality here if needed
              },
              leading: note.image != null
                  ? Image.file(
                File(note.image!),
                width: 100, // Set width as per your requirement
                height: 100, // Set height as per your requirement// Adjust the fit as needed
              )
                  : null,
            );


          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show add note dialog
          _showAddNoteDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context) async {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();
    final picker = ImagePicker();

    XFile? pickedFile;

    showDialog(
      context: context,
      builder: (context) =>
          StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Add Note'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(labelText: 'Content'),
                ),
                TextButton(
                  onPressed: () async {
                    pickedFile = await picker.pickImage(source: ImageSource.gallery);
                    setState(() {}); // Update the state to show selected image
                  },
                  child: Text('Add Image'),
                ),
                if (pickedFile != null)
                  Image.file(
                    File(pickedFile!.path),
                    width: 100, // Adjust width and height as needed
                    height: 100,
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Save note and dismiss dialog
                  final newNote = NoteModel(
                    titleController.text,
                    contentController.text,
                    image: pickedFile?.path,
                  );
                  _noteController.addNote(newNote);
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          );
        },
      ),
    );
  }



  void _showEditNoteDialog(BuildContext context, NoteModel note, int index) async {
    TextEditingController titleController = TextEditingController(text: note.title);
    TextEditingController contentController = TextEditingController(text: note.content);
    final picker = ImagePicker();

    XFile? pickedFile = note.image != null ? XFile(note.image!) : null;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Edit Note'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(labelText: 'Content'),
                ),
                TextButton(
                  onPressed: () async {
                    pickedFile = await picker.pickImage(source: ImageSource.gallery);
                    setState(() {}); // Update the state to show selected image
                  },
                  child: Text('Add Image'),
                ),
                if (pickedFile != null)
                  Image.file(
                    File(pickedFile!.path),
                    width: 100, // Adjust width and height as needed
                    height: 100,
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Update note and dismiss dialog
                  final updatedNote = NoteModel(
                    titleController.text,
                    contentController.text,
                    image: pickedFile?.path,
                  );
                  _noteController.updateNote(index, updatedNote);
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          );
        },
      ),
    );
  }

}
