import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class utils{
  void toasterMessage({String? message, required Color color}){
    Fluttertoast.showToast(
        msg: message!,
        // toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void toasterExcep(error){
    Fluttertoast.showToast(
        msg: error,
        // toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}