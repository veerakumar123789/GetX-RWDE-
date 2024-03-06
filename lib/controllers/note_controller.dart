import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newinterviewtask/models/note.dart';


class NoteController extends GetxController {
  RxList<NoteModel> notes = <NoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  Future<void> loadNotes() async {
    final box = await Hive.openBox<NoteModel>('notes');
    notes.assignAll(box.values.toList());
  }

  void addNote(NoteModel note) async {
    final box = await Hive.openBox<NoteModel>('notes');
    await box.add(note);
    loadNotes();
  }

  void updateNote(int index, NoteModel note) async {
    final box = await Hive.openBox<NoteModel>('notes');
    await box.putAt(index, note);
    loadNotes();
  }

  void deleteNote(int index) async {
    final box = await Hive.openBox<NoteModel>('notes');
    await box.deleteAt(index);
    loadNotes();
  }
}
