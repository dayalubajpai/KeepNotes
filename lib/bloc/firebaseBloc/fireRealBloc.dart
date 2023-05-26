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
    on<FireRealUpdateDataEvent>((event, emit){
      print(event.notes.id);
      _databaseRefs
          .child(event.notes.id.toString())
          .update(event.notes.toJson());
    });
    on<FireRealFetchDataEvent>((event, emit) {
      // print(_database.onValue.toString().length);
      emit(FireRealFetchState(_database.onValue));
    });
    on<FireRealDeleteEvent>((event, emit) async {
      emit(FireRealLoadingState());
      if (event is FireRealDeleteEvent) {
        await _database.child(event.id).remove();
        utils().toasterMessage(color: Colors.red, message: "Post Delete");
      }
    });
  }
  @override
  Future<void> close() {
    _fetchData?.cancel();
    // TODO: implement close
    return super.close();
  }
}
