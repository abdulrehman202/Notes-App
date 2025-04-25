import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:recalling_code/Note.dart';
import 'package:http/http.dart' as http;
import 'package:recalling_code/constants.dart';


class DBController {
  static Db? db;

  connect() async {
    try {
  var url = Uri.http('${Constants.ip}:${Constants.port}','/');
var response = await http.get(url);
var body = json.decode( response.body.toString());

return body;

    } catch (e) {
      print('connection failed');
    }
  }

  Future<bool> insert(Note note) async {
    try {
      final collection = db?.collection('notes collection');

      final documentToInsert = {
        'id':note.id,
        'title': note.title,
        'text': note.text,
        'color': note.color,
      };

      await collection?.insert(documentToInsert);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Note>> fetchAllNotes() async {
    try {
      List<Note> list = [];
      final docs = db?.collection('notes collection');

      await docs?.find().forEach((note){
        Note noteFromDB = Note.fromJson(note);
        
        list.add(noteFromDB);
      });
      return list;

    } catch (e) {
      return [];
    }
  }

  Future<bool> updateNote(Note note) async{
    try{
      final collection = await db?.collection('notes collection');

      final documentToUpdate = {'\$set':{
        'id':note.id,
        'title': note.title,
        'text': note.text,
        'color': note.color,
      }};

      await collection?.updateOne({'_id':ObjectId.parse(note.id)},documentToUpdate,upsert: false);
      return true;
    }
    catch(e){
      return false;
    }
  }

  Future<bool> deleteNote(Note note) async{
    try{
      final collection = await db?.collection('notes collection');

      await collection?.deleteOne({'_id':ObjectId.parse(note.id)});
      return true;
    }
    catch(e){
      return false;
    }
  }
}
