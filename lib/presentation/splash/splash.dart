
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepnotes/bloc/authCubit/authCubit.dart';
import 'package:keepnotes/bloc/authCubit/authState.dart';
import 'package:keepnotes/presentation/home/homekeep.dart';
import 'package:keepnotes/presentation/login/signup.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            Future.delayed(Duration(seconds: 3)).then((value){
              (state is AuthLogInState) ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>KeepHome())) : Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignupKeepNotes()));
            });
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/keep.png',
                  height: 150,
                  width: 150,
                ),
                Text(
                  "Keep Notes",
                  style: GoogleFonts.lato(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 100,
                  child: const LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    color: Color(0xFFffc000),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
