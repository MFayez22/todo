import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/task_screen.dart';

import '../constants/colors/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import 'day_task_screen.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map> list = [];
    String dayTask = '';
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()..getDoneList(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
if(state is DeleteDoneSuccessState)
{
  HomeCubit.get(context).getDoneList();
}
        },
        builder: (context, state) {
          return Container(
            color: defaultColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Center(
                      child: Text(
                        'All Done Task',
                        style: TextStyle(
                            color: shadowColor,
                            fontFamily: 'Righteous-Regular',
                            fontSize: 24),
                      )),
                  SizedBox(height: 20,),
                  Expanded(
                    flex: 2,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => doneItem(
                            model: HomeCubit.get(context).doneList,
                            index: index,
                            context: context),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: HomeCubit.get(context).doneList.length),
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

Widget doneItem(
    {required List<Map> model,
      required int index,
      required BuildContext context}) =>
    InkWell(
      onTap: () {
       // Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDayInfoScreen(list: model[index],)));
      },
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Card(
              clipBehavior: Clip.hardEdge,
              color: primaryColor,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [

                        Spacer(),
                        Text(
                         'Done time : ${model[index]['doneTime']}',
                          style: TextStyle(
                              color: defaultColor,
                              fontSize: 18,
                              fontFamily: 'Righteous-Regular'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      model[index]['title'],
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
                      style: TextStyle(
                          color: shadowColor,
                          fontSize: 18,
                          fontFamily: 'Righteous-Regular'),
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      model[index]['date'],
                      style: TextStyle(
                          color: defaultColor,
                          fontSize: 18,
                          fontFamily: 'Righteous-Regular'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          model[index]['time'],
                          style: TextStyle(
                              color: defaultColor,
                              fontSize: 18,
                              fontFamily: 'Righteous-Regular'),
                        ),
                        Spacer(),
                        Text(
                          model[index]['important'],
                          style: TextStyle(
                              color: defaultColor,
                              fontSize: 16,
                              fontFamily: 'Righteous-Regular'),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: IconButton(
                          onPressed: () {
                            final snackBar = SnackBar(
                              content: const Text(
                                  'delete task'),
                              action: SnackBarAction(
                                label: 'Delete',
                                onPressed: () {
                                  HomeCubit.get(context)
                                      .deleteDone(tableName: 'done',
                                      id: model![index]['id']);
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
                                    backgroundColor: primaryColor,
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ))),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),

        ],
      ),
    );
