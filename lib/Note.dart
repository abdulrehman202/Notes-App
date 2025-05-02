class Note {
  String _title, _text, _id = '';
  int _color;

  Note(this._id, this._title, this._text, this._color);

  String get id {
    return _id;
  }

  String get title {
    return _title;
  }

  String get text {
    return _text;
  }

  int get color {
    return _color;
  }

  set id(String i) {
    _id = i;
  }

  set title(String t) {
    _title = t;
  }

  set text(String t) {
    _text = t;
  }

  factory Note.fromJson(Map<String, dynamic> parsedJson) {
    return Note(parsedJson['objId'], parsedJson['title'], parsedJson['text'],
        parsedJson['color']);
  }
}
