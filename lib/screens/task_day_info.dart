import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/state.dart';
import 'package:todo/layouts/home/home_layout.dart';

import '../constants/colors/colors.dart';

class TaskDayInfoScreen extends StatelessWidget {
  Map? list;

  TaskDayInfoScreen({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
    TextEditingController(text: list!['title']);
    TextEditingController describeController =
    TextEditingController(text: list!['describe']);
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()..getDateTime(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is DeleteTaskListSuccessState ||
              state is UpdateTaskSuccessState ||state is DoneTaskSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeLayout()), (
                route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                backgroundColor: primaryColor,
                elevation: 0,
                centerTitle: true,
                title:  Text(
                  'Task ',
                  style: TextStyle(
                      color: shadowColor,
                      fontFamily: 'Righteous-Regular',
                      fontSize: 24),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        HomeCubit.get(context).changeVisibility();
                      },
                      icon: CircleAvatar(
                          backgroundColor: defaultColor,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: CircleAvatar(
                                backgroundColor: primaryColor,
                                child: !HomeCubit
                                    .get(context)
                                    .isVisible
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
                iconTheme: IconThemeData(color: shadowColor)),
            body: Container(
              color: primaryColor,
              width: double.infinity,
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 40,
                  // ),

                  // Align(
                  //   alignment: AlignmentDirectional.bottomEnd,
                  //   child: IconButton(
                  //       onPressed: () {
                  //         HomeCubit.get(context).changeVisibility();
                  //       },
                  //       icon: CircleAvatar(
                  //           backgroundColor: defaultColor,
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(2.0),
                  //             child: CircleAvatar(
                  //                 backgroundColor: primaryColor,
                  //                 child: !HomeCubit
                  //                     .get(context)
                  //                     .isVisible
                  //                     ? Icon(
                  //                   Icons.edit,
                  //                   color: defaultColor,
                  //                 )
                  //                     : Icon(
                  //                   Icons.close,
                  //                   color: defaultColor,
                  //                 )),
                  //           ))),
                  // ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: defaultColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              topLeft: Radius.circular(50))),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              /// task info

                              Visibility(
                                visible: !HomeCubit
                                    .get(context)
                                    .isVisible,
                                child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                        child: Text(
                                          list!['title'],
                                          style: TextStyle(
                                              color: shadowColor,
                                              fontFamily: 'Righteous-Regular',
                                              fontSize: 30),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        list!['describe'],
                                        style: TextStyle(
                                            color: shadowColor,
                                            fontFamily: 'Righteous-Regular',
                                            fontSize: 22),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              /// edit

                              Visibility(
                                visible: HomeCubit
                                    .get(context)
                                    .isVisible,
                                child: Container(
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: Container(
                                            width: 100,
                                            child: TextField(
                                              controller: titleController,
                                              keyboardType: TextInputType.text,
                                              clipBehavior: Clip.hardEdge,
                                              style: TextStyle(
                                                color: shadowColor,
                                                fontSize: 30,
                                                fontFamily: 'Righteous-Regular',
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: TextField(
                                            controller: describeController,
                                            keyboardType: TextInputType.text,
                                            clipBehavior: Clip.hardEdge,
                                            style: TextStyle(
                                              color: shadowColor,
                                              fontFamily: 'Righteous-Regular',
                                              fontSize: 22,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ]),
                                ),
                              ),

                              /// all
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                list!['important'],
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 24,
                                    fontFamily: 'Righteous-Regular'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    list!['time'],
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 24,
                                        fontFamily: 'Righteous-Regular'),
                                  ),
                                  Spacer(),
                                  Text(
                                    list!['date'],
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 24,
                                        fontFamily: 'Righteous-Regular'),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              /// delete

                              Visibility(
                                visible: !HomeCubit
                                    .get(context)
                                    .isVisible,
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    children: [

                                      MaterialButton(
                                        onPressed: () {

                                          final snackBar = SnackBar(
                                            content: const Text(
                                                'Move Task To Done'),
                                            action: SnackBarAction(
                                              label: 'Done',
                                              onPressed: () {
                                                String doneDate =HomeCubit.get(context).date;
                                                HomeCubit.get(context).addDone(
                                                    id: list!['id'].toString(),
                                                    title: list!['title'],
                                                    describe: list!['describe'],
                                                    important: list!['important'],
                                                    date: list!['date'],
                                                    month: list!['month'],
                                                    time: list!['time'],
                                                    doneTime: doneDate );
                                              },
                                            ),
                                          );

                                          // Find the ScaffoldMessenger in the widget tree
                                          // and use it to show a SnackBar.
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);

                                        },
                                        color: primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0)),
                                        child: Text(
                                          'Done',
                                          style: TextStyle(
                                              color: defaultColor,
                                              fontFamily: 'Righteous-Regular',
                                              fontSize: 24),
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            final snackBar = SnackBar(
                                              content: const Text(
                                                  'delete task'),
                                              action: SnackBarAction(
                                                label: 'Delete',
                                                onPressed: () {
                                                  HomeCubit.get(context)
                                                      .deleteTask(
                                                      id: list!['id']);
                                                  HomeCubit()
                                                      .cancelNotifications(
                                                      id: list!['id']);
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
                                                    backgroundColor: defaultColor,
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    )),
                                              ))),
                                    ],
                                  ),
                                ),
                              ),

                              /// update

                              Visibility(
                                visible: HomeCubit
                                    .get(context)
                                    .isVisible,
                                child: MaterialButton(
                                  onPressed: () {
                                    HomeCubit.get(context).updateTask(
                                        newTitle: titleController.text,
                                        newDescribe: describeController.text,
                                        id: list!['id'].toString());
                                  },
                                  color: shadowColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0)),
                                  child: Text(
                                    'update ',
                                    style: TextStyle(
                                        color: defaultColor,
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
