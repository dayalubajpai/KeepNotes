import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keepnotes/bloc/firebaseBloc/fireRealBloc.dart';
import 'package:keepnotes/bloc/firebaseBloc/fireRealEvent.dart';
import 'package:keepnotes/data_model/insertDataModel.dart';
import 'package:keepnotes/presentation/home/homekeep.dart';
import 'package:keepnotes/utils/customStylesKeep.dart';

class EditKeepNotes extends StatelessWidget {

  final String? title;
  final String? desc;
  final int? ids;

  const EditKeepNotes({Key? key, this.title, this.desc, this.ids}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String? titleText, dscText, id ;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
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
        }),
      ),
      backgroundColor: Styles().bgcolor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
           Container(
             child: TextFormField(
               initialValue: title ?? '',
               // controller: titleController,
               style: GoogleFonts.poppins(fontSize: 20),
               keyboardType: TextInputType.multiline,
               maxLines: null,
               onChanged: (valu){
                    titleText = valu;
               },
               decoration: const InputDecoration(
                 hintText: "Title",
                 border: InputBorder.none,
               ),
             ),
           ),
           Flexible(
              child: SizedBox(
                 height: double.infinity,
                child: TextFormField(
                  // controller: descController,
                  initialValue: desc ?? '',
                  onChanged: (valu){
                    dscText = valu;
                  },
                  style: GoogleFonts.poppins(fontSize: 16),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Notes",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        print(ids);
       final notes= NoteModel(
          id: ids!= null ? ids.toString() :  DateTime.now().millisecondsSinceEpoch.toString(),
          description: dscText ?? desc,
          date: DateFormat.yMMMd().format(DateTime.now()),
          title: titleText ?? title,
        );
       if(ids != null){
         print('Da ${ids}');
         context.read<FireRealBloc>().add(FireRealUpdateDataEvent(notes: notes));
       }else{
         context.read<FireRealBloc>().add(FireRealAddDataEvent(note: notes));
       }
       if( titleText != "" || dscText != ""){
         Navigator.of(context).popUntil((route) => route.isFirst);
         // Navigator.pop(context);
       }
        }, label: const Text("Save"),
        backgroundColor: Styles().bgYelColor,
        splashColor: Styles().bgYelColor,
      ),
    );
  }
}
