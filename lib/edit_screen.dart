import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  
  String heading, note;

   EditScreen({super.key, required this.heading, required this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _headingEditControlller = TextEditingController();
  TextEditingController _noteEditControlller = TextEditingController();
  FocusNode _focusNode = FocusNode(
  );
  FocusNode _focusNode2 = FocusNode(
  );

  @override
  Widget build(BuildContext context) {
    _headingEditControlller.text =  widget.heading;
    _noteEditControlller.text = widget.note;
    return Scaffold(
      appBar: AppBar(
        
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.backspace_outlined, color: Colors.white,)),
      ),

      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditableText(minLines: 1,
               maxLines: 3, controller: _headingEditControlller, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 35, fontWeight: FontWeight.bold, ), cursorColor: Colors.white, backgroundCursorColor: Colors.white, focusNode: _focusNode,),
              const Divider(color: Color.fromARGB(85, 224, 224, 224),),
              Expanded(child: EditableText(controller: _noteEditControlller, style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 35,), cursorColor: Colors.white, backgroundCursorColor: Colors.white, focusNode: _focusNode2,),
              ),
          
            ],
          ),
        ),
      ),
    );
  }
}