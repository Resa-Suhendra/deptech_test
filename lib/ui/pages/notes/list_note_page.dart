import 'package:deptech_test/core/utils/navigation/navigation_utils.dart';
import 'package:deptech_test/core/view_model/notes_provider.dart';
import 'package:deptech_test/ui/constant/constant.dart';
import 'package:deptech_test/ui/router/route_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListNotesPage extends StatefulWidget {
  const ListNotesPage({Key? key}) : super(key: key);

  @override
  State<ListNotesPage> createState() => _ListNotesPageState();
}

class _ListNotesPageState extends State<ListNotesPage> {
  @override
  void initState() {
    Provider.of<NotesProvider>(context, listen: false).getAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notes List",
          style: styleTitle.copyWith(
              color: Colors.white, fontSize: setFontSize(60)),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigate.pushTo(routeAddNotes);
          },
          child: const Icon(
            Icons.note_add_rounded,
            color: Colors.white,
          )),
      body: SingleChildScrollView(
        child: Consumer<NotesProvider>(builder: (context, notesProvider, _) {

          print(notesProvider.listNotes.length);

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: notesProvider.listNotes.map((e) {
              return Text(e.title!);
            }).toList(),
          );
        }),
      ),
    );
  }
}
