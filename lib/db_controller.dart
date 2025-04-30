import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:recalling_code/Note.dart';
import 'package:http/http.dart' as http;
import 'package:recalling_code/constants.dart';

class DBController {
  static Db? db;

  connect() async {
    try {
      var url = Uri.http('${Constants.ip}:${Constants.port}', '/');
      var response = await http.get(url);
      var body = json.decode(response.body.toString());

      return body;
    } catch (e) {
      print('connection failed');
    }
  }

  Future<bool> insert(Note note) async {
    try {
      var url = Uri.parse('http://${Constants.ip}:${Constants.port}/insert');
      var response = await http.post(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(
              {'title': note.title, 'text': note.text, 'color': note.color}));
      var resCode = json.decode(response.body.toString())['code'];

      return resCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<List<Note>> fetchAllNotes() async {
    List<Note> notes = [];
    try {
      var url = Uri.http('${Constants.ip}:${Constants.port}', '/getAllNotes');
      var response = await http.get(url);
      var body = json.decode(response.body.toString())['msg'];

      body.forEach((note) => notes.add(Note.fromJson(note)));

      return notes;
    } catch (e) {
      print('connection failed');
    }
    return notes;
  }

  Future<bool> updateNote(Note note) async {
    try {
      var url = Uri.parse('http://${Constants.ip}:${Constants.port}/update');
      var response = await http.put(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(
              {'id':note.id,'title': note.title, 'text': note.text}));
      var resCode = json.decode(response.body.toString())['code'];

      return resCode== 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteNote(Note note) async {
    try {
      var url = Uri.parse('http://${Constants.ip}:${Constants.port}/remove');
      var response = await http.delete(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(
              {'id': note.id}));
      var resCode = json.decode(response.body.toString())['code'];

      return resCode == 200;
    } catch (e) {
      return false;
    }
  }

  registerUser(String email, String password)
  async {
    try {
      var url = Uri.parse('http://${Constants.ip}:${Constants.port}/registerUser');
      var response = await http.post(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(
              {'email': email, 'password': password}));
      var resCode = json.decode(response.body.toString())['code'];

      return resCode == 200;
    } catch (e) {
      return false;
    }
  }

  login(String email, String password) async {
    try {
      var url = Uri.http('${Constants.ip}:${Constants.port}', '/login');
      var response = await http.post(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(
              {'email': email, 'password': password}));

      var resCode = json.decode(response.body.toString())['code'];

      return resCode == 200;
    } catch (e) {
      return false;
    }
  }
}
