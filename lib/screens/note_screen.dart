import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/note_info_screen.dart';

import '../constants/colors/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    final key = new GlobalKey<ScaffoldState>();
    TextEditingController titleController = TextEditingController();
    TextEditingController describeController = TextEditingController();
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()..getNoteList(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AddNoteSuccessState) {
            HomeCubit.get(context).getNoteList();
          }
        },
        builder: (context, state) {
          HomeCubit.get(context).getNoteList();
          return Container(
            color: lightColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Card(
                      color: shadowColor,
                      clipBehavior: Clip.hardEdge,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => addNoteDialog(
                                context: context,
                                formKey: formKey,
                                titleController: titleController,
                                describeController: describeController,
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.note_add_outlined,
                            size: 50,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => noteItem(
                            model: HomeCubit.get(context).noteList,
                            index: index,
                            context: context),
                        itemCount: HomeCubit.get(context).noteList.length),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget noteItem(
        {required List<Map> model,
        required int index,
        required BuildContext context}) =>
    InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NoteInfoScreen(note: model[index],)));
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        color: primaryColor,
        elevation: 5.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                model[index]['title'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: shadowColor,
                    fontSize: 24,
                    fontFamily: 'Righteous-Regular'),
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                model[index]['describe'],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: shadowColor,
                    fontSize: 18,
                    fontFamily: 'Righteous-Regular'),
              ),
            ],
          ),
        ),
      ),
    );

Widget addNoteDialog(
        {
          required BuildContext context,
          required var formKey,
        required TextEditingController titleController,
        required TextEditingController describeController}) =>
    BlocProvider<HomeCubit>(
      create: (context)=>HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state)
        {
          if (state is AddNoteSuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state)
        {
          return Dialog(
            clipBehavior: Clip.hardEdge,
            backgroundColor: lightColor,
            elevation: 5.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 250,
                child: Form(
                  key: formKey,
                  child: Container(
                    color: lightColor,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'add Note',
                            style: TextStyle(
                                color: defaultColor,
                                fontFamily: 'Righteous-Regular',
                                fontSize: 24),
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
                          Spacer(),

                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  String editTime = HomeCubit.get(context).date;
                                  HomeCubit.get(context).addNote(
                                      title: titleController.text,
                                      describe: describeController.text,
                                      editTime: editTime);
                                }
                              },
                              color: defaultColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text(
                                'save',
                                style: TextStyle(
                                    color: lightColor,
                                    fontFamily: 'Righteous-Regular',
                                    fontSize: 24),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
