import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keepnotes/bloc/firebaseBloc/fireRealBloc.dart';
import 'package:keepnotes/bloc/firebaseBloc/fireRealEvent.dart';
import 'package:keepnotes/data_model/insertDataModel.dart';
import 'package:keepnotes/utils/customStylesKeep.dart';

class editKeepNotes extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
   editKeepNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
               controller: titleController,
               style: GoogleFonts.poppins(fontSize: 20),
               keyboardType: TextInputType.multiline,
               maxLines: null,
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
                  controller: descController,
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
       final note= NoteModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          description: descController.text,
          date: DateFormat.yMMMd().format(DateTime.now()),
          title: titleController.text
        );
        context.read<FireRealBloc>().add(FireRealAddDataEvent(note: note));
        print(titleController.text );
       if( titleController.text != "" || descController.text != ""){
         Navigator.pop(context);
       }
        }, label: const Text("Save"),
        backgroundColor: Styles().bgYelColor,
        splashColor: Styles().bgYelColor,
      ),
    );
  }
}
