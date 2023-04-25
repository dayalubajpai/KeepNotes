import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepnotes/bloc/authCubit/authCubit.dart';
import 'package:keepnotes/bloc/authCubit/authState.dart';
import 'package:keepnotes/presentation/home/homekeep.dart';
import 'package:keepnotes/utils/toast.dart';
import 'package:pinput/pinput.dart';

class OtpKeepNotes extends StatelessWidget {
  final phoneNumber;
  TextEditingController otpController = TextEditingController();
  OtpKeepNotes(this.phoneNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/keep.png',
                  height: 150,
                  width: 150,
                ),
                const Text(
                  'Verify OTP',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Please Verify Your Mobile Number - $phoneNumber',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Pinput(
                  controller: otpController,
                  length: 6,
                  // validator: (s) {
                  //   return s == '222222' ? null : 'Pin is incorrect';
                  // },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) => print(otpController.text.toString()),
                ),
                SizedBox(
                  height: 20,
                ),
                BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
                  if(state is AuthLoadingState){
                    return Center(
                      child: CircularProgressIndicator(),
                    );}
                    return SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<AuthCubit>(context).verifyOTP(otpController.text.toString());
                          },
                          child: Text('Verify OTP'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFffa505),
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                        ));
                }, listener: (context, state) {
                  if (state is AuthLogInState) {
                    utils().toasterMessage(color: Colors.green, message: "Login Successful");
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => KeepHome()));
                  }else if(state is AuthErrorState){
                    utils().toasterExcep(state.error);
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
