import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepnotes/bloc/firebaseBloc/fireRealEvent.dart';
import 'package:keepnotes/bloc/firebaseBloc/fireRealState.dart';
import 'package:keepnotes/data_model/fetchDataModel.dart';
import 'package:keepnotes/utils/toast.dart';

class FireRealBloc extends Bloc<FireRealEvent, FireRealState> {
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
}
