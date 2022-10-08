import 'dart:io';

class NoteModel {
  String? title;
  String? description;
  DateTime? reminder;
  DateTime? intervalRemider;
  File? attachment;

  NoteModel({
    this.title,
    this.description,
    this.reminder,
    this.intervalRemider,
    this.attachment,
  });
}
