import 'package:deptech_test/core/model/notes_model.dart';
import 'package:deptech_test/core/utils/extensions/string_extension.dart';
import 'package:deptech_test/core/utils/navigation/navigation_utils.dart';
import 'package:deptech_test/core/view_model/notes_provider.dart';
import 'package:deptech_test/ui/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({Key? key}) : super(key: key);

  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  bool isReminder = false;

  String _reminder = '';
  String _interval = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add New Notes",
            style: styleTitle.copyWith(
                color: Colors.white, fontSize: setFontSize(60)),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: deviceHeight,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: styleSubtitle.copyWith(
                        fontSize: setFontSize(50),
                      ),
                    ),
                    SizedBox(
                      height: setHeight(20),
                    ),
                    TextFormField(
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius:
                                  BorderRadius.circular(borderRadius))),
                    ),
                    SizedBox(
                      height: setHeight(100),
                    ),
                    Text(
                      "Description",
                      style: styleSubtitle.copyWith(
                        fontSize: setFontSize(50),
                      ),
                    ),
                    SizedBox(
                      height: setHeight(20),
                    ),
                    TextFormField(
                      controller: descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      minLines: 5,
                      maxLines: 8,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          gapPadding: 0,
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: setHeight(100),
                    ),
                    Row(
                      children: [
                        Text(
                          "Reminder",
                          style: styleSubtitle.copyWith(
                            fontSize: setFontSize(50),
                          ),
                        ),
                        Checkbox(
                          checkColor: Colors.white,
                          // fillColor:
                          value: isReminder,
                          onChanged: (bool? value) {
                            setState(() {
                              isReminder = value!;
                              _reminder = '';
                              _interval = '0';
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: setHeight(20),
                    ),
                    isReminder
                        ? TextButton(
                            onPressed: () async {
                              var init = _reminder.isEmpty
                                  ? DateTime.now()
                                  : DateFormat('dd-MM-yyyy HH:mm')
                                      .parse(_reminder);

                              FocusManager.instance.primaryFocus?.unfocus();
                              DatePicker.showDateTimePicker(
                                context,
                                currentTime: init,
                                onChanged: (value) {
                                  setState(() {
                                    _reminder = DateFormat('dd-MM-yyyy HH:mm')
                                        .format(value);
                                  });
                                },
                                minTime: DateTime.now(),
                              ).then((value) => null);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(50), //
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  size: 25,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  _reminder.isEmpty
                                      ? "Set Reminder"
                                      : _reminder,
                                  style: styleTitle.copyWith(
                                    fontSize: setFontSize(50),
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    isReminder
                        ? SizedBox(
                            height: setHeight(100),
                          )
                        : const SizedBox(),
                    isReminder
                        ? Text(
                            "Reminder Interval",
                            style: styleSubtitle.copyWith(
                              fontSize: setFontSize(50),
                            ),
                          )
                        : const SizedBox(),
                    isReminder
                        ? SizedBox(
                            height: setHeight(20),
                          )
                        : const SizedBox(),
                    isReminder
                        ? DropdownButton(
                            value: _interval,
                            items: const [
                              DropdownMenuItem(
                                value: '0',
                                child: Text("Select Reminder Interval"),
                              ),
                              DropdownMenuItem(
                                value: '1',
                                child: Text("1 Hour Before"),
                              ),
                              DropdownMenuItem(
                                value: '3',
                                child: Text("3 Hours Before"),
                              ),
                              DropdownMenuItem(
                                value: '24',
                                child: Text("1 Day Before"),
                              ),
                            ],
                            onChanged: (v) {
                              setState(() {
                                _interval = v!;
                              });
                            })
                        : const SizedBox(),
                    SizedBox(
                      height: setHeight(100),
                    ),
                    Consumer<NotesProvider>(
                        builder: (context, notesProvider, _) {
                      return TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (isReminder) {
                              if (_reminder.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Please set reminder time"),
                                  ),
                                );
                                return;
                              }
                            }

                            NotesModel data = NotesModel(
                              title: titleController.text,
                              description: descriptionController.text,
                              reminder: _reminder,
                              reminderInterval: _interval,
                            );

                            var res = await notesProvider.createNotes(data);

                            if (res > 0) {

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: primaryColor,
                                  content: const Text("Success Add Data"),
                                ),
                              );
                              navigate.pop();
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(borderRadius)),
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: Text(
                          'Login',
                          style: styleTitle.copyWith(
                            fontSize: setFontSize(50),
                            color: Colors.white,
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
