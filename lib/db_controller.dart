import 'package:mongo_dart/mongo_dart.dart';

class DBController{

  static Db? db;
  static late var userCollection;

  static Future<void> connect() async {
    try {
      db = await Db.create('mongodb+srv://user:user123@cluster0.cfknulu.mongodb.net/');
      await db!.open();
      print('connection established');
    } catch (e) {
      print('connection established not');
    }
  }
}