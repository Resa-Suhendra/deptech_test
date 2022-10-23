import 'dart:io';

class NotesModel {
  int? id;
  String? title;
  String? description;
  String? reminder;
  String? reminderInterval;
  String? attachment;

  NotesModel({
    this.id,
    this.title,
    this.description,
    this.reminder,
    this.reminderInterval,
    this.attachment,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      id: json['_id'],
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      reminder: json['reminder'] ?? "",
      reminderInterval: json['reminder_interval'] ?? "",
      attachment: json['attachment'] ?? "",
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return {
      "_id" : id,
      "title": title,
      "description": description,
      "reminder": reminder,
      "reminder_interval": reminderInterval,
      "attachment": attachment,
    };
  }
}
