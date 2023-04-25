abstract class FireRealState {}

class FireRealInitialState extends FireRealState {}

class FireRealLoadingState extends FireRealState {}

class FireRealLoadedState extends FireRealState {}

class FireRealErrorState extends FireRealState {}

class FireRealInsertState extends FireRealState {}

class FireRealFetchState extends FireRealState {
  FireRealFetchState();
}

class FireRealUpdateState extends FireRealState {}

class FireRealDeleteState extends FireRealState {}
