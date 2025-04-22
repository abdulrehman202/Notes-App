import 'package:mongo_dart/mongo_dart.dart';
import 'package:recalling_code/Note.dart';

class DBController {
  static Db? db;

  static Future<void> connect() async {
    try {
      db = await Db.create(
          'mongodb+srv://user:user123@cluster0.cfknulu.mongodb.net/Notes');
      await db!.open();
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
