import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashState{initial, loading, loaded}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.initial);

 void loadData() async {
    await Future.delayed(Duration(seconds: 3));
    emit(SplashState.loaded);
  }
  }