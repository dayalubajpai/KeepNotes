// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepnotes/bloc/firebaseBloc/fireRealEvent.dart';
import 'package:keepnotes/bloc/firebaseBloc/fireRealState.dart';
import 'package:keepnotes/utils/toast.dart';

class FireRealBloc extends Bloc<FireRealEvent, FireRealState> {
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
        }
      }
    });
  }

  Stream<List<String>> fetchDataFireReal() {
    print(_database.onValue);
    return _database.onValue.map((event) {
      final snapshot = event.snapshot;
      final data = snapshot.value as Map<String, dynamic>;
      return data.values.toList().cast<String>();
    });
  }
}
