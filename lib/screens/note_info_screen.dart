import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/colors/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class NoteInfoScreen extends StatelessWidget {
  Map? note;

  NoteInfoScreen({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    final key = new GlobalKey<ScaffoldState>();
    TextEditingController titleController =
        TextEditingController(text: note!['title']);
    TextEditingController describeController =
        TextEditingController(text: note!['describe']);
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()..getDateTime(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is DeleteDoneSuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: lightColor,
              iconTheme: IconThemeData(color: defaultColor),
              title: Text(
                'Note',
                style: TextStyle(
                    color: defaultColor,
                    fontFamily: 'Righteous-Regular',
                    fontSize: 24),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      final snackBar = SnackBar(
                        content: const Text(
                            'delete note'),
                        action: SnackBarAction(
                          label: 'Delete',
                          onPressed: () {
                            HomeCubit.get(context)
                                .deleteDone(
                              tableName: 'note',
                                id: note!['id']);
                          },
                        ),
                      );

                      // Find the ScaffoldMessenger in the widget tree
                      // and use it to show a SnackBar.
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar);
                    },
                    icon: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(
                              2.0),
                          child: CircleAvatar(
                              backgroundColor: lightColor,
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ))),
                IconButton(
                    onPressed: () {
                      HomeCubit.get(context).changeVisibility();
                    },
                    icon: CircleAvatar(
                        backgroundColor: defaultColor,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CircleAvatar(
                              backgroundColor: lightColor,
                              child: !HomeCubit.get(context).isVisible
                                  ? Icon(
                                      Icons.edit,
                                      color: defaultColor,
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: defaultColor,
                                    )),
                        ))),
              ],
            ),
            body: Form(
              key: formKey,
              child: Container(
                color: lightColor,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: !HomeCubit.get(context).isVisible,
                        child: Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Container(
                              child: Visibility(
                                visible: !HomeCubit.get(context).isVisible,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// title
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      note!['title'],
                                      style: TextStyle(
                                          color: defaultColor,
                                          fontFamily: 'Righteous-Regular',
                                          fontSize: 24),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 1,
                                      width: double.infinity,
                                      color: defaultColor,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),

                                    /// describe

                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      note!['describe'],
                                      style: TextStyle(
                                          color: defaultColor,
                                          fontFamily: 'Righteous-Regular',
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: HomeCubit.get(context).isVisible,
                        child: Expanded(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: MaterialButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          String editTime =
                                              HomeCubit.get(context).date;
                                          HomeCubit.get(context).updateNote(
                                              newTitle: titleController.text,
                                              newDescribe: describeController.text,
                                              editTime: editTime, id: note!['id'].toString());
                                        }
                                      },
                                      color: defaultColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0)),
                                      child: Text(
                                        'save',
                                        style: TextStyle(
                                            color: lightColor,
                                            fontFamily: 'Righteous-Regular',
                                            fontSize: 24),
                                      ),
                                    ),
                                  ),
                                  /// title
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: titleController,
                                          keyboardType: TextInputType.text,
                                          obscureText: false,
                                          style: TextStyle(
                                            color: defaultColor,
                                            fontFamily: 'Righteous-Regular',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'is empty';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'title of note....',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Righteous-Regular',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  /// describe

                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Expanded(
                                        child: TextFormField(
                                          controller: describeController,
                                          keyboardType: TextInputType.text,
                                          maxLines: 20,
                                          obscureText: false,
                                          style: TextStyle(
                                            color: defaultColor,
                                            fontFamily: 'Righteous-Regular',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'is empty';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'describe the note....',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Righteous-Regular',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
