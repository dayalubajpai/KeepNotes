import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keepnotes/bloc/authCubit/authCubit.dart';
import 'package:keepnotes/bloc/authCubit/authState.dart';
import 'package:keepnotes/presentation/login/otp.dart';
import 'package:keepnotes/utils/customStylesKeep.dart';
import 'package:keepnotes/utils/toast.dart';

class SignupKeepNotes extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();
  SignupKeepNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Center(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/keep.png',
                  height: 150,
                  width: 150,
                ),
                const Text(
                  'Welcome to KeepNotes',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'To Keep connected with us \n please login with your phone number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 3.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'Phone Number'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return const CircularProgressIndicator();
                  }
                  return SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          String phoneNumber = "+91${phoneController.text}";
                          BlocProvider.of<AuthCubit>(context)
                              .sendOTP(phoneNumber);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:  Styles().bgYelColor,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                        child: const Text('Verify Phone'),
                      ));
                }, listener: (context, state) {
                  if (state is AuthCodeSendState) {
                    utils().toasterMessage(color: Colors.green, message: "OTP Sent");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OtpKeepNotes(phoneController.text.toString())));
                  }
                  if (state is AuthErrorState) {
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
