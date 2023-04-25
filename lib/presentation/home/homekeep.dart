import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepnotes/bloc/InternetCubit/internetcheckcubit.dart';
import 'package:keepnotes/bloc/authCubit/authCubit.dart';
import 'package:keepnotes/bloc/authCubit/authState.dart';
import 'package:keepnotes/bloc/firebaseBloc/fireRealBloc.dart';
import 'package:keepnotes/presentation/edit/editkeep.dart';
import 'package:keepnotes/presentation/login/signup.dart';
import 'package:keepnotes/utils/customStylesKeep.dart';
import 'package:keepnotes/utils/toast.dart';

class KeepHome extends StatelessWidget {
  const KeepHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetCubit, InternetStatus>(
        builder: (context, state) {
      return BlocListener<AuthCubit, AuthState>(listener: (contexts, states){
        if(states is AuthLogOutState || states == AuthLogOutState){
          utils().toasterMessage(color: Colors.red, message: "Log Out Successful");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignupKeepNotes()));
        }
      }, child: Scaffold(
          backgroundColor: Styles().bgcolor,
          body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  backgroundColor: Colors.black12.withOpacity(0.05),
                  elevation: 0.0,
                  title: Text(
                    "Notes",
                    style:
                    GoogleFonts.lato(color: Colors.black, fontSize: 20),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        context.read<AuthCubit>().logOut();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                        child: const Icon(
                          Icons.logout,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  ],
                )
              ],
              body: MasonryGridView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(5.0),
                  gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      overlayColor:
                      MaterialStateProperty.all(Colors.transparent),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xFFFEFF86),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "How to Learn Flutter with Easy Steps in Two Days",
                                  style: TextStyle(fontSize: 20, height: 1.4),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Date - 07/12/2025",
                                  style: TextStyle(fontSize: 12, height: 1.4),
                                )
                              ],
                            )),
                      ),
                    );
                  })),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BlocProvider(create: (context)=> FireRealBloc(), child: editKeepNotes(),)));
            },
            backgroundColor: const Color(0xFFffa505),
            child: const Icon(Icons.edit),
          )),);
    }, listener: (context, state) {
      if (state == InternetStatus.lost) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          content: Text("Internet Lost"),
          backgroundColor: Colors.red,
        ));
      } else if (state == InternetStatus.loaded) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Internet Connected"),
          backgroundColor: Colors.green,
        ));
      }
    });
  }
}
