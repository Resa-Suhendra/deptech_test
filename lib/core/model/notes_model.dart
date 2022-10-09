import 'dart:io';

class NotesModel {
  String? title;
  String? description;
  String? reminder;
  String? reminderInterval;
  String? attachment;

  NotesModel({
    this.title,
    this.description,
    this.reminder,
    this.reminderInterval,
    this.attachment,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
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
      "title": title,
      "description": description,
      "reminder": reminder,
      "reminder_interval": reminderInterval,
      "attachment": attachment,
    };
  }
}
