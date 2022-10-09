import 'dart:io';

class NotesModel {
  String? title;
  String? description;
  String? reminder;
  String? intervalRemider;
  String? attachment;

  NotesModel({
    this.title,
    this.description,
    this.reminder,
    this.intervalRemider,
    this.attachment,
  });

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      reminder: json['reminder'] ?? "",
      intervalRemider: json['interval_reminder'] ?? "",
      attachment: json['attachment'] ?? "",
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "reminder": reminder,
      "interval_remider": intervalRemider,
      "attachment": attachment,
    };
  }
}
