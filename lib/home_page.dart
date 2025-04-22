import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:recalling_code/Note.dart';
import 'package:recalling_code/db_controller.dart';
import 'package:recalling_code/edit_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Note sampleNote = Note('','This is my intro that I use everywhere','My name is Abdul Rehman but I am a software engineer by profession. Currently employed at ZOA energy solutions as retrofit assessor. ',0);
  bool searchMode = false;
  final List<Note> _notesList = [
  ];
  final _notesStreamController = StreamController<List<Note>>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _filterController = TextEditingController();
  DBController _dbController = DBController();

  List<Color> colors = [
    const Color(0xffFD99FF),
    const Color(0xffFF9E9E),
    const Color(0xff91F48F),
    const Color(0xffFFF599),
    const Color(0xff9EFFFF),
    const Color(0xffB69CFF),
  ];

  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
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
                return Center(
                  child: Wrap(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                            
                        child: Card(
                          child: Container(
                            margin: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                    label: Text(
                                      'Add Title',
                                    ),
                                  ),
                                ),
                                Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 20),
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
                                      Note note = Note(
                                        '-1',
                                          _titleController.text,
                                          _textController.text,
                                          Random().nextInt(6));
                                         await _dbController.insert(note);
                                         setState(() {
                                           
                                         });
                                      _titleController.clear();
                                      _textController.clear();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Add note'))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
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
                            return Container(
                              child: Image.asset('assets/images/info.png'),
                            );
                          });
                    },
                    icon: const Icon(Icons.info_outline_rounded)),
              ],
      ),
      body: FutureBuilder(
        future: _dbController.fetchAllNotes(),
        builder: (context, AsyncSnapshot<List<Note>> snapshot) {
          _notesList.clear();
          _notesList.addAll(snapshot.data??[]);
          switch (snapshot.connectionState){
          
          case ConnectionState.waiting: const Center(child: CircularProgressIndicator( color: Colors.white,));
          default: _notesStreamController.add(snapshot.data??[]);}

          return StreamBuilder<List<Note>>(
            stream: _stream,
            builder: (context, snapshot) {
              List<Note> tempList = snapshot.data?.toList() ?? [];
              return tempList.isNotEmpty
                  ? ListView.builder(
                      itemCount: tempList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditScreen(note:tempList[index])))
                                    ;
                                    setState(() {
                                      
                                    });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.all(10.0),
                            constraints: const BoxConstraints(minHeight: 100),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              color: colors[tempList[index].color],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tempList[index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  child: ReadMoreText(
                                    tempList[index].text,
                                    trimMode: TrimMode.Line,
                                    trimLines: 2,
                                    colorClickableText: Colors.pink,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                    moreStyle: const TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      child: const Text('No data to show'),
                    );
            },
          );
        }
      ),
    );
  }
}
