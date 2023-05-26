import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keepnotes/bloc/firebaseBloc/fireRealBloc.dart';
import 'package:keepnotes/bloc/firebaseBloc/fireRealEvent.dart';
import 'package:keepnotes/data_model/insertDataModel.dart';
import 'package:keepnotes/presentation/edit/editkeep.dart';
import 'package:keepnotes/utils/customStylesKeep.dart';

class ViewKeepNotes extends StatelessWidget {
  final String? title;
  final String? desc;
  final String? date;
  final int? id;
   const ViewKeepNotes({Key? key,this.date , this.title, this.desc, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(id);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () {
                  print('edit button clicked');
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditKeepNotes(title: title, desc: desc, ids: id,)));
                  },
                child: const Icon(
                  Icons.edit_calendar_rounded,
                  color: Colors.black54,
                ),
              ),
            );
          },
          ),
        ],
        leading: Builder(builder: (context) {
          return InkWell(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
          );
        },
        ),
      ),
      backgroundColor: Styles().bgcolor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Container(
             child: Text(title ?? '', style: TextStyle( fontSize: 20,)),
           ),
           SizedBox(height: 8,),
           Padding(
             padding: const EdgeInsets.only(left: 2.0),
             child: Text('Date - ${date}',style: TextStyle(fontSize: 12),),
           ),
            SizedBox(height: 12,),
            Flexible(
              child: SizedBox(
                 height: double.infinity,
                child: Text(desc ?? '', style: TextStyle( fontSize: 16,)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
