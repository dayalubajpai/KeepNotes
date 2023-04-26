import 'package:keepnotes/data_model/insertDataModel.dart';

abstract class FireRealEvent{}

class FireRealAddDataEvent extends FireRealEvent{
  final NoteModel note;
  FireRealAddDataEvent({required this.note});
}

class FireRealFetchDataEvent extends FireRealEvent{}

class FireRealDeleteEvent extends FireRealEvent{
  final String id;
  FireRealDeleteEvent({required this.id});
}