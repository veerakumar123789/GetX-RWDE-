import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String content;

  @HiveField(2)
  late String? image;

  NoteModel(this.title, this.content, {this.image});
}
