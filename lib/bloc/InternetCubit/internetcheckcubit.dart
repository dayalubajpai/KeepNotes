import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetStatus{initial, lost, loaded}

class InternetCubit extends Cubit<InternetStatus>{
  Connectivity connectivity = Connectivity();
  StreamSubscription? _connection;
  InternetCubit() : super(InternetStatus.initial){
    _connection = connectivity.onConnectivityChanged.listen((event) {
      if(event == ConnectivityResult.wifi || event == ConnectivityResult.mobile){
        emit(InternetStatus.loaded);

      }else{
        emit(InternetStatus.lost);
      }
    });
  }
@override
  Future<void> close() {
    _connection?.cancel();
    // TODO: implement close
    return super.close();
  }
}