import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:recalling_code/Note.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  bool searchMode = false;
  final List<Note> _notesList = [
    ];
  final _notesStreamController = StreamController<List<Note>>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  
  List<Color> colors= 
  [
    const Color(0xffFD99FF),
    const Color(0xffFF9E9E),
    const Color(0xff91F48F),
    const Color(0xffFFF599),
    const Color(0xff9EFFFF),
    const Color(0xffB69CFF),
  ];
  
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
  _notesStreamController.sink.add(_notesList);


    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
         showDialog(context: context, builder: (BuildContext context){
          return Center(
            child: Wrap(
              children: [
                Card(
                  child: Container(
                      margin: const EdgeInsets.all(20),
                    child: Column(
                      children: [  
                        TextField(controller:  _titleController,decoration: const InputDecoration(label: Text('Add Title',),),),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.topCenter,
                        height: 200,
                        child: TextFormField(
                          controller: _textController,
                          maxLines: 20,
                          decoration: const InputDecoration(
                          label: Text('Write a note', textAlign: TextAlign.start,),  
                            border: OutlineInputBorder(
                                    
                            ),
                            hintMaxLines: 20
                          ),
                        )),
                        FilledButton(onPressed: (){

                          _notesList.add(Note(_titleController.text, _textController.text,Random().nextInt(6)));
                          _notesStreamController.add(_notesList);
                          _titleController.clear();
                          _textController.clear();
                          Navigator.pop(context);
                        }, child: const Text('Add note'))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
         });
      },
      child: const Icon(Icons.add,color: Colors.white, ),
      ),
      appBar: AppBar(title: searchMode?TextField(
        
        cursorColor: Colors.white,
        decoration: InputDecoration(
          suffix: IconButton(onPressed: (){setState(() {
        searchMode = false;
      });}, icon: const Icon(Icons.close,color: Colors.white,)),hintText: 'Search Title', border: InputBorder.none, hintStyle: const TextStyle(color: Colors.white)),):const Text("Memo App"), actions: searchMode?[]:[
        IconButton(onPressed: (){
          setState(() {
          searchMode = true;
          });
        }, icon: const Icon(Icons.search,)),
        IconButton(onPressed: ()
        {
          showDialog(context: context, builder: (context)
          {
            return Container(
              child: Image.asset('assets/images/info.png'),
              
              
            );
          });
        }, icon: const Icon(Icons.info_outline_rounded)),
      ],
      ), 
      body:  StreamBuilder<List<Note>>(
              stream: _stream,
              builder: (context, snapshot) {
                List<Note> tempList = snapshot.data?.toList() ??[];
                return tempList.isNotEmpty? ListView.builder(itemCount: tempList.length,itemBuilder: (context, index)
                {
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    constraints: const BoxConstraints(minHeight: 100),
                    decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: colors[tempList[index].color], ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tempList[index].title,style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 20),),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ReadMoreText(
                            tempList[index].text,
                            trimMode: TrimMode.Line,
                            trimLines: 2,
                            colorClickableText: Colors.pink,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: ' Show less',
                            moreStyle: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 15),
                            lessStyle: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  );
                },) :Container(child: Text('No data to show'),);
              },
            ),
    ); 
  } 
 
}