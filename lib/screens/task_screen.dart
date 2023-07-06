import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/state.dart';
import 'package:todo/screens/day_task_screen.dart';
import 'package:todo/screens/task_day_info.dart';

import '../constants/colors/colors.dart';
import '../constants/constants.dart';
import '../models/task_model.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController yearController = TextEditingController();
    List<Map> list = [];
    String dayTask = '';
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()
        ..getHighTaskList()
        ..getTaskList(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is GetDateTaskListSuccessState) {
            list = HomeCubit.get(context).dayTaskList;
            dayTask = HomeCubit.get(context).getDateText;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DayTaskScreen(
                          title1: 'Day Task ',
                          title2: dayTask,
                          list: list,
                        )));
          }
        },
        builder: (context, state) {

          return Container(
            color: defaultColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                      child: Text(
                        isEnglish1 ? 'All Task':'كل المهمات',
                    style: TextStyle(
                        color: shadowColor,
                        fontFamily: 'Righteous-Regular',
                        fontSize: 24),
                  )),
                  Row(children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Container(
                          height: 1,
                          width: double.infinity,
                          color: shadowColor,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          HomeCubit.get(context).changeVisibility();
                          print(HomeCubit.get(context).isVisible);
                        },
                        icon: HomeCubit.get(context).isVisible
                            ? Icon(
                                Icons.arrow_drop_up,
                                size: 40,
                                color: shadowColor,
                              )
                            : Icon(
                                Icons.arrow_drop_down,
                                size: 40,
                                color: shadowColor,
                              ))
                  ]),
                  Visibility(
                    visible: HomeCubit.get(context).isVisible,
                    child: Container(
                      child: Column(
                        children: [
                          Center(
                              child: Text(
                                isEnglish1 ?'Level of important':'مستوي الاهميه',
                            style: TextStyle(color: shadowColor, fontSize: 20),
                          )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      list =
                                          HomeCubit.get(context).highTaskList;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DayTaskScreen(
                                                    title1:
                                                    isEnglish1 ?'Level of important':'مستوي الاهميه',
                                                    title2: isEnglish1 ?'high':'مهام عاليه',
                                                    list: list,
                                                  )));
                                    },
                                    color: primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Text(isEnglish1 ?'high':'عالي',
                                        style: TextStyle(
                                            color: shadowColor, fontSize: 18)),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      list =
                                          HomeCubit.get(context).middleTaskList;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DayTaskScreen(
                                                    title1:
                                                    isEnglish1 ?'Level of important':'مستوي الاهميه',
                                                    title2: isEnglish1 ?'middle':'المهم متوسطه',
                                                    list: list,
                                                  )));
                                    },
                                    color: primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Text(isEnglish1 ?'middle':'متوسط',
                                        style: TextStyle(
                                            color: shadowColor, fontSize: 18)),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: MaterialButton(
                                    onPressed: () {
                                      list = HomeCubit.get(context).lowTaskList;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DayTaskScreen(
                                                    title1:
                                                    isEnglish1 ?'Level of important':'مستوي الاهميه',
                                                    title2: isEnglish1 ?'low':'مهام مخنفض',
                                                    list: list,
                                                  )));
                                    },
                                    color: primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Text(isEnglish1 ?'low':'مخنفض',
                                        style: TextStyle(
                                            color: shadowColor, fontSize: 18)),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// line
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: shadowColor,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),

                          /// schedule
                          Text( isEnglish1 ?'Schedule':'جدول',
                              style:
                                  TextStyle(color: shadowColor, fontSize: 20)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              width: double.infinity,
                              child: MaterialButton(
                                onPressed: () {
                                  HomeCubit.get(context)
                                      .getDayTask(context: context);
                                },
                                color: shadowColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Text(
                                  isEnglish1 ? 'Choose Day Task ':'اختر يوم المهمة',
                                  style: TextStyle(
                                      color: defaultColor,
                                      fontFamily: 'Righteous-Regular',
                                      fontSize: 24),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              width: double.infinity,
                              child: MaterialButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => chooseMonthCard(
                                            yearController: yearController,
                                          ));
                                },
                                color: shadowColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Text(
                                  isEnglish1 ? 'Choose Month ':'اختر شهر المهمة',
                                  style: TextStyle(
                                      color: defaultColor,
                                      fontFamily: 'Righteous-Regular',
                                      fontSize: 24),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),

                          /// line
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: shadowColor,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => taskItem(
                            model: HomeCubit.get(context).taskList,
                            index: index,
                            context: context),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 5,
                            ),
                        itemCount: HomeCubit.get(context).taskList.length),
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

Widget taskItem(
        {required List<Map> model,
        required int index,
        required BuildContext context}) =>
    InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TaskDayInfoScreen(list: model[index],)));
      },
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Card(
              clipBehavior: Clip.hardEdge,
              color: shadowColor,
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
                        Text(
                          model[index]['title'],
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 24,
                              fontFamily: 'Righteous-Regular'),
                        ),
                        Spacer(),
                        Text(
                          model[index]['date'],
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

Widget chooseMonthCard({
  required TextEditingController yearController,
}) =>
    BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state)
        {
          if(state is GetMonthDateTaskListSuccessState)
          {
          List<Map>  list = HomeCubit.get(context).monthTaskList;
           String title2 = '${HomeCubit.get(context).chooseYearText}-${HomeCubit.get(context).monthTextListIndex + 1}';
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DayTaskScreen(
                      title1: 'Month Task ',
                      title2: title2,
                      list: list,
                    )));
          }
        },
        builder: (context, state) {
          return Dialog(
            clipBehavior: Clip.hardEdge,
            backgroundColor: shadowColor,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Year',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 24,
                              fontFamily: 'Righteous-Regular'),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              HomeCubit.get(context).minceYear();
                            },
                            icon: CircleAvatar(
                                backgroundColor: primaryColor,
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: shadowColor,
                                      fontFamily: 'Righteous-Regular'),
                                ))),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          HomeCubit.get(context).chooseYearText,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 24,
                              fontFamily: 'Righteous-Regular'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              HomeCubit.get(context).plusYear();
                            },
                            icon: CircleAvatar(
                                backgroundColor: primaryColor,
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: shadowColor,
                                      fontFamily: 'Righteous-Regular'),
                                ))),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          'month',
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 24,
                              fontFamily: 'Righteous-Regular'),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              HomeCubit.get(context).minceMonth();
                            },
                            icon: CircleAvatar(
                                backgroundColor: primaryColor,
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: shadowColor,
                                      fontFamily: 'Righteous-Regular'),
                                ))),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          HomeCubit.get(context).monthTextList[
                              HomeCubit.get(context).monthTextListIndex],
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 24,
                              fontFamily: 'Righteous-Regular'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              HomeCubit.get(context).plusMonth();
                            },
                            icon: CircleAvatar(
                                backgroundColor: primaryColor,
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: shadowColor,
                                      fontFamily: 'Righteous-Regular'),
                                ))),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    Spacer(),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: MaterialButton(
                          onPressed: ()
                          {
                            HomeCubit.get(context).getMonthTaskList(date: '${HomeCubit.get(context).chooseYearText}-${HomeCubit.get(context).monthTextListIndex + 1}');
                          },
                          clipBehavior: Clip.hardEdge,
                          color: primaryColor,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(
                            'Get task',
                            style: TextStyle(
                                color: shadowColor,
                                fontSize: 24,
                                fontFamily: 'Righteous-Regular'),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
