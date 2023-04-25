import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepnotes/bloc/authCubit/authState.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificatioID;
  AuthCubit() : super(AuthInitialState()){
    final user= _auth.currentUser;
    Future.delayed(const Duration(seconds: 0)).then((value){
      if(user != null){
        emit(AuthLogInState(user));
      }else{
        emit(AuthLogOutState());
      }
    });

  }

  void sendOTP(String phoneNumber) async {
    emit(AuthLoadingState());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationID, forceResendignToken) {
        _verificatioID = verificationID;
        emit(AuthCodeSendState());
      },
      verificationCompleted: (phoneAuthCrediential) {
        signWithPhone(phoneAuthCrediential);
      },
      verificationFailed: (error) {
        String _error = error.message.toString();
        log(_error);
        if(error.code == "too-many-requests"){
          _error = "Found To Many Request";
        }if(error.code == "invalid-phone-number"){
          _error = "Phone Number Invalid";
        }
        emit(AuthErrorState(_error));
      },
      codeAutoRetrievalTimeout: (verificationID) {
        _verificatioID = verificationID;
      },
    );
  }

  void verifyOTP(String OTP) async {
    emit(AuthLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificatioID!, smsCode: OTP);
    signWithPhone(credential);
  }

  void signWithPhone(PhoneAuthCredential credential) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        emit(AuthLogInState(userCredential.user!));
      }
    } on FirebaseAuthException catch (ex) {
      emit(AuthErrorState(ex.message.toString()));
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
    emit(AuthLogOutState());
  }
}
