import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:recalling_code/Note.dart';
import 'package:recalling_code/Widgets/ConfirmationDialog.dart';
import 'package:recalling_code/Widgets/DialogContainer.dart';
import 'package:recalling_code/Widgets/NoteCard.dart';
import 'package:recalling_code/db_controller.dart';
import 'package:recalling_code/edit_screen.dart';
import 'package:recalling_code/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool searchMode = false;
  final List<Note> _notesList = [];
  final _notesStreamController = StreamController<List<Note>>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _filterController = TextEditingController();
  final DBController _dbController = DBController();

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Widget newNoteDialog() {
    return DialogContainer(dialogContent: [
      TextField(
        controller: _titleController,
        decoration: const InputDecoration(
          label: Text(
            'Add Title',
          ),
        ),
      ),
      Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.topCenter,
          height: 200,
          child: TextFormField(
            controller: _textController,
            maxLines: 20,
            decoration: const InputDecoration(
                label: Text(
                  'Write a note',
                  textAlign: TextAlign.start,
                ),
                border: OutlineInputBorder(),
                hintMaxLines: 20),
          )),
      FilledButton(
          onPressed: () async {
            Note note = Note('-1', _titleController.text, _textController.text,
                Random().nextInt(6));
            await _dbController.insert(note);
            setState(() {});
            _titleController.clear();
            _textController.clear();
            Navigator.pop(context);
          },
          child: const Text('Add note'))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final _stream = _notesStreamController.stream;
    _notesList.clear();
    _notesStreamController.sink.add(_notesList);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return newNoteDialog();
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        leading: Container(),
        title: searchMode
            ? TextField(
                focusNode: _focusNode,
                controller: _filterController,
                onChanged: (value) {
                  List<Note> filteredList = [];
                  _notesStreamController.sink.add(filteredList);
                  filteredList.addAll(_notesList
                      .where((test) => test.title
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList());
                  _notesStreamController.add(filteredList);
                },
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            _notesStreamController.add(_notesList);
                            searchMode = false;
                          });
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                    hintText: 'Search Title',
                    border: InputBorder.none,
                    hintStyle: const TextStyle(color: Colors.white)),
              )
            : const Text("Memo App"),
        actions: searchMode
            ? []
            : [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _focusNode.requestFocus();
                        _filterController.clear();
                        searchMode = true;
                      });
                    },
                    icon: const Icon(
                      Icons.search,
                    )),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Image.asset('assets/images/info.png');
                          });
                    },
                    icon: const Icon(Icons.info_outline_rounded)),
                IconButton(
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('email', '');

                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => SignInScreen()));
                    },
                    icon: const Icon(Icons.logout)),
              ],
      ),
      body: FutureBuilder(
          future: _dbController.fetchAllNotes(),
          builder: (context, AsyncSnapshot<List<Note>> snapshot) {
            _notesList.clear();
            _notesList.addAll(snapshot.data ?? []);
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              default:
                _notesStreamController.add(snapshot.data ?? []);
            }

            return StreamBuilder<List<Note>>(
              stream: _stream,
              builder: (context, snapshot) {
                List<Note> tempList = snapshot.data?.toList() ?? [];
                return tempList.isNotEmpty
                    ? ListView.builder(
                        itemCount: tempList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPress: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) => ConfirmationDialog(
                                      msg: 'Do you want to delete this note?',
                                      yesCB: () {
                                        _dbController
                                            .deleteNote(tempList[index]);
                                        _filterController.clear();
                                        searchMode = false;
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                      noCB: () {
                                        Navigator.pop(context);
                                      }));
                            },
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditScreen(note: tempList[index])));
                              setState(() {});
                            },
                            child: NoteCard(note: tempList[index]),
                          );
                        },
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/empty.png'),
                            Text(
                              'No Note found!',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ],
                        ),
                      );
              },
            );
          }),
    );
  }
}
