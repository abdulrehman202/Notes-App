import 'package:flutter/material.dart';
import 'package:recalling_code/Widgets/ConfirmationDialog.dart';
import 'package:recalling_code/Widgets/DialogContainer.dart';
import 'package:recalling_code/db_controller.dart';

import 'Note.dart';

class EditScreen extends StatefulWidget {
  Note note;

  EditScreen({super.key, required this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController _headingEditControlller = TextEditingController();
  final TextEditingController _noteEditControlller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  bool _isCHanged = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _headingEditControlller.dispose();
    _noteEditControlller.dispose();
    _focusNode.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  Widget _YesNoButton(String txt, VoidCallback doThis, Color color)
  {
    return Container(
      decoration: BoxDecoration(
        color: color,
      ),
      height: 50,
      child: TextButton(onPressed: doThis, child: Text(txt, style: TextStyle(color: Colors.black),)),
    );
  }

  @override
  Widget build(BuildContext context) {
    _headingEditControlller.text = widget.note.title;
    _noteEditControlller.text = widget.note.text;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {

              if(_isCHanged) {
                showDialog(context: context, builder: (context)=> ConfirmationDialog(msg:'Do you want to save changes?', yesCB: (){DBController().updateNote(Note(widget.note.id,_headingEditControlller.text,_noteEditControlller.text,widget.note.color)).then((updated){if(updated)Navigator.pop(context);Navigator.pop(context);});},
noCB: (){
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }));
              
              }
              else Navigator.pop(context);
            },
            icon: const Icon(
              Icons.backspace_outlined,
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) => _isCHanged = true,
                  contextMenuBuilder: (context, editableTextState) {
                    
                    return AdaptiveTextSelectionToolbar.buttonItems(
                      anchors: editableTextState.contextMenuAnchors,
                      buttonItems: editableTextState.contextMenuButtonItems,
                    );
                  },
                  minLines: 1,
                  maxLines: 1000,
                  controller: _headingEditControlller,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                  cursorColor: Colors.white,
                  focusNode: _focusNode,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
                const Divider(
                  color: Color.fromARGB(85, 224, 224, 224),
                ),
                TextField(
                  onChanged: (value) => _isCHanged = true,
                  contextMenuBuilder: (context, editableTextState) {
                    
                    return AdaptiveTextSelectionToolbar.buttonItems(
                      anchors: editableTextState.contextMenuAnchors,
                      buttonItems: editableTextState.contextMenuButtonItems,
                    );
                  },
                  minLines: 1,
                  maxLines: 1000,
                  controller: _noteEditControlller,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                      ),
                  cursorColor: Colors.white,
                  focusNode: _focusNode2,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
