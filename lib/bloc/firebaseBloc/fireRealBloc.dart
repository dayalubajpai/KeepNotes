// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepnotes/bloc/firebaseBloc/fireRealEvent.dart';
import 'package:keepnotes/bloc/firebaseBloc/fireRealState.dart';
import 'package:keepnotes/data_model/insertDataModel.dart';
import 'package:keepnotes/utils/toast.dart';

class FireRealBloc extends Bloc<FireRealEvent, FireRealState> {
  StreamSubscription? _fetchData;
  final _database = FirebaseDatabase.instance
      .ref(FirebaseAuth.instance.currentUser?.uid.toString());
  final FirebaseAuth auths = FirebaseAuth.instance;
  final _databaseRef = FirebaseDatabase.instance;
  FireRealBloc() : super(FireRealInitialState()) {
    final _databaseRefs = _databaseRef.ref(auths.currentUser?.uid.toString());
    on<FireRealAddDataEvent>((event, emit) {
      if (event is FireRealAddDataEvent) {
        if (event.note.title == "" && event.note.description == "") {
          utils().toasterMessage(
              color: Colors.red, message: "Please Add Title or Description");
        } else {
          _databaseRefs
              .child(event.note.id.toString())
              .set(event.note.toJson());
          utils().toasterMessage(
              color: Colors.green, message: "Data Inserted Please go Back");
        }
      }
    });
    on<FireRealFetchDataEvent>((event, emit) {
      // List<NoteModel> noteData = [];
      // _database.onValue.listen((event) {
      //   Object? valuex = event.snapshot.value;
      //   String jsonString = jsonEncode(valuex);
      //   Map<String, dynamic> mapData = jsonDecode(jsonString);
      //   mapData.forEach((key, value) {
      //     noteData.add(NoteModel.fromJson(value));
      //   });
      // });
      // Future.delayed(Duration(seconds: 1),(){
      //   print(noteData);
      //   emit(FireRealFetchState(noteData));
      // });
      emit(FireRealFetchState(_database.onValue));
    });
  }
  @override
  Future<void> close() {
    _fetchData?.cancel();
    // TODO: implement close
    return super.close();
  }
}
