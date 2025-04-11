class Note{
  String _title, _text;
  int _color;

  Note(this._title, this._text, this._color);

  String get title
  {
    return _title;
  }

  String get text
  {
    return _text;
  }

  int get color
  {
    return _color;
  }

  set title(String t)
  {
    _title = t;
  }

  set text(String t)
  {
    _text = t;
  }
}