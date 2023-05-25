import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepnotes/bloc/InternetCubit/internetcheckcubit.dart';
import 'package:keepnotes/bloc/authCubit/authCubit.dart';
import 'package:keepnotes/bloc/authCubit/authState.dart';
import 'package:keepnotes/bloc/firebaseBloc/fireRealBloc.dart';
import 'package:keepnotes/bloc/splash/splash_cubit.dart';
import 'package:keepnotes/presentation/home/homekeep.dart';
import 'package:keepnotes/presentation/login/signup.dart';
import 'package:keepnotes/presentation/splash/splash.dart';

import 'bloc/firebaseBloc/fireRealEvent.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const KeepNotes());
}

class KeepNotes extends StatelessWidget {
  const KeepNotes({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(create: (context) => InternetCubit()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider(
            create: (context) => FireRealBloc()),
      ],
      child: MaterialApp(
        home: KeepHome(),
      ),
    );
  }
}
