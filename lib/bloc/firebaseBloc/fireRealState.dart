import 'package:firebase_database/firebase_database.dart';
import 'package:keepnotes/data_model/insertDataModel.dart';

abstract class FireRealState {}

class FireRealInitialState extends FireRealState {}

class FireRealLoadingState extends FireRealState {}

class FireRealLoadedState extends FireRealState {}

class FireRealErrorState extends FireRealState {}

class FireRealInsertState extends FireRealState {}

class FireRealFetchState extends FireRealState {
  Stream<DatabaseEvent> note;
  FireRealFetchState(this.note);
}

class FireRealUpdateState extends FireRealState {}

class FireRealDeleteState extends FireRealState {}
