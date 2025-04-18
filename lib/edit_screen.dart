import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  String heading, note;

  EditScreen({super.key, required this.heading, required this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController _headingEditControlller = TextEditingController();
  final TextEditingController _noteEditControlller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    _headingEditControlller.dispose();
    _noteEditControlller.dispose();
    _focusNode.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _headingEditControlller.text = widget.heading;
    _noteEditControlller.text = widget.note;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
                  contextMenuBuilder: (context, editableTextState) {
                    final List<ContextMenuButtonItem> buttonItems =
                        editableTextState.contextMenuButtonItems;
                    buttonItems.removeWhere((ContextMenuButtonItem buttonItem) {
                      return buttonItem.type == ContextMenuButtonType.cut;
                    });
                    return AdaptiveTextSelectionToolbar.buttonItems(
                      anchors: editableTextState.contextMenuAnchors,
                      buttonItems: buttonItems,
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
