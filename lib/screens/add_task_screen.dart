import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/constants/colors/colors.dart';
import 'package:todo/constants/widgets/widgets.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/state.dart';
import 'package:todo/layouts/home/home_layout.dart';

import '../constants/constants.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    final key = new GlobalKey<ScaffoldState>();
    TextEditingController titleController = TextEditingController();
    TextEditingController describeController = TextEditingController();
    String time;
    String day;
    String month;
    String year;
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()..openDataBase(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AddTaskListSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeLayout()),
                (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: key,
            appBar: AppBar(
                backgroundColor: primaryColor,
                elevation: 0,
                centerTitle: true,
                title:  Text(
                  isEnglish1 ?'ADD Task':'اضافة مهمة',
                  style: TextStyle(
                      color: shadowColor,
                      fontFamily: isEnglish1 ?'Righteous-Regular':'Cairo',
                      fontSize: 24),
                ),
                iconTheme: IconThemeData(color: shadowColor)),
            body: Form(
              key: formKey,
              child: Container(
                color: primaryColor,
                width: double.infinity,
                child: Column(
                  children: [

                    SizedBox(
                      height: 60.0,
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
                                  SizedBox(
                                    height: 40,
                                  ),

                                  /// title
                                  Text(
                                    isEnglish1 ?'Title':'العنوان',
                                    style: TextStyle(
                                        color: shadowColor,
                                        fontFamily: 'Righteous-Regular',
                                        fontSize: 18),
                                  ),
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
                                          controller: titleController,
                                          keyboardType: TextInputType.text,
                                          obscureText: false,
                                          style: TextStyle(
                                            color: Colors.grey[300],fontFamily: 'Righteous-Regular',),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'is empty';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: isEnglish1 ?'title of task....':'عنوان المهمة ....',
                                            hintStyle: TextStyle(
                                                color: Colors.grey[300],fontFamily: 'Righteous-Regular',),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30.0))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  /// describe

                                  Text(
                                    isEnglish1 ? 'Describe':'الوصف',
                                    style: TextStyle(
                                        color: shadowColor,
                                        fontFamily: 'Righteous-Regular',
                                        fontSize: 18),
                                  ),
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
                                            color: Colors.grey[300],fontFamily: 'Righteous-Regular',),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'is empty';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'describe the task....',
                                            hintStyle: TextStyle(
                                                color: Colors.grey[300],fontFamily: 'Righteous-Regular',),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30.0))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  /// colors

                                  // Text(
                                  //   'Color',
                                  //   style: TextStyle(
                                  //       color: shadowColor,
                                  //       fontFamily: 'Righteous-Regular',
                                  //       fontSize: 18),
                                  // ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.start,
                                  //   children: [
                                  //     SizedBox(
                                  //       width: 30,
                                  //     ),
                                  //     Icon(
                                  //       Icons.circle,
                                  //       color: primaryColor,
                                  //       size: 50,
                                  //     ),
                                  //     SizedBox(
                                  //       width: 5,
                                  //     ),
                                  //     Icon(
                                  //       Icons.circle,
                                  //       color: shadowColor,
                                  //       size: 50,
                                  //     ),
                                  //     SizedBox(
                                  //       width: 5,
                                  //     ),
                                  //     Icon(
                                  //       Icons.circle,
                                  //       color: Colors.blue,
                                  //       size: 50,
                                  //     ),
                                  //     SizedBox(
                                  //       width: 5,
                                  //     ),
                                  //   ],
                                  // ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),

                                  /// Level of important

                                  Text(
                                    isEnglish1 ?'Level of important':'مستوي الاهمية',
                                    style: TextStyle(
                                        color: shadowColor,
                                        fontFamily: 'Righteous-Regular',
                                        fontSize: 18),
                                  ),

                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    HomeCubit.get(context)
                                                        .chooseLevelOfImportant(
                                                            numTheme: 1);
                                                  },
                                                  color: HomeCubit.get(context)
                                                          .isHigh
                                                      ? primaryColor
                                                      : shadowColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: Text('high',
                                                      style: TextStyle(
                                                          color: HomeCubit.get(
                                                                      context)
                                                                  .isHigh
                                                              ? shadowColor
                                                              : defaultColor,
                                                          fontFamily:
                                                              'Righteous-Regular',
                                                          fontSize: 18)),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    HomeCubit.get(context)
                                                        .chooseLevelOfImportant(
                                                            numTheme: 2);
                                                  },
                                                  color: HomeCubit.get(context)
                                                          .isMiddle
                                                      ? primaryColor
                                                      : shadowColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: Text('middle',
                                                      style: TextStyle(
                                                          color: HomeCubit.get(
                                                                      context)
                                                                  .isMiddle
                                                              ? shadowColor
                                                              : defaultColor,
                                                          fontFamily:
                                                              'Righteous-Regular',
                                                          fontSize: 18)),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Expanded(
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    HomeCubit.get(context)
                                                        .chooseLevelOfImportant(
                                                            numTheme: 3);
                                                  },
                                                  color: HomeCubit.get(context)
                                                          .isLow
                                                      ? primaryColor
                                                      : shadowColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  child: Text('low',
                                                      style: TextStyle(
                                                          color: HomeCubit.get(
                                                                      context)
                                                                  .isLow
                                                              ? shadowColor
                                                              : defaultColor,
                                                          fontFamily:
                                                              'Righteous-Regular',
                                                          fontSize: 18)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),

                                  /// date and time

                                  Text(
                                    isEnglish1 ?'Date and Time':'التاريخ و الوقت',
                                    style: TextStyle(
                                        color: shadowColor,
                                        fontFamily: 'Righteous-Regular',
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),

                                  /// calender

                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 30,
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          HomeCubit.get(context)
                                              .chooseTime(context);
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0)),
                                        color: shadowColor,
                                        child: Text(
                                          HomeCubit.get(context).timeTask == ''
                                              ? 'Choose Time'
                                              : 'Time task is ${HomeCubit.get(context).timeTask}',
                                          style: TextStyle(
                                              color: defaultColor,
                                              fontFamily: 'Righteous-Regular',
                                              fontSize: 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TableCalendar(
                                          firstDay: DateTime.utc(2010, 10, 16),
                                          lastDay: DateTime.utc(2030, 3, 14),
                                          focusedDay:
                                              HomeCubit.get(context).focusedDay,
                                          headerStyle: HeaderStyle(
                                            titleTextStyle: TextStyle(
                                                color: shadowColor,
                                                fontFamily:
                                                    'Righteous-Regular'),
                                          ),
                                          daysOfWeekStyle: DaysOfWeekStyle(
                                              weekdayStyle: TextStyle(
                                                  color: shadowColor,
                                                  fontFamily:
                                                      'Righteous-Regular'),
                                              weekendStyle: TextStyle(
                                                  color: lightColor,
                                                  fontFamily:
                                                      'Righteous-Regular')),
                                          calendarStyle: CalendarStyle(
                                              outsideTextStyle:
                                                  TextStyle(color: Colors.grey),
                                              weekendTextStyle:
                                                  TextStyle(color: lightColor),
                                              rangeEndTextStyle:
                                                  TextStyle(color: shadowColor),
                                              withinRangeTextStyle:
                                                  TextStyle(color: shadowColor),
                                              selectedTextStyle:
                                                  TextStyle(color: shadowColor),
                                              rangeStartTextStyle:
                                                  TextStyle(color: shadowColor),
                                              rangeHighlightColor: primaryColor,
                                              disabledTextStyle:
                                                  TextStyle(color: shadowColor),
                                              holidayTextStyle:
                                                  TextStyle(color: shadowColor),
                                              todayTextStyle:
                                                  TextStyle(color: lightColor),
                                              defaultTextStyle: TextStyle(
                                                  color: shadowColor)),
                                          selectedDayPredicate: (day) {
                                            return isSameDay(
                                                HomeCubit.get(context)
                                                    .focusedDay,
                                                day);
                                          },
                                          onDaySelected:
                                              (selectedDay, focusedDay) {
                                            HomeCubit.get(context)
                                                .onDaySelected(
                                                    selectedDay, focusedDay);
                                          },
                                          calendarFormat: HomeCubit.get(context)
                                              .calendarFormat,
                                          availableCalendarFormats: {
                                            CalendarFormat.month: 'Week',
                                            CalendarFormat.twoWeeks: 'month',
                                            CalendarFormat.week: '2 weeks',
                                          },
                                          onFormatChanged: (format) {
                                            HomeCubit.get(context)
                                                .onFormatChanged(format);
                                          }),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: state is AddTaskListLoadingState
                ? Center(
                  child: CircularProgressIndicator(
                      color: shadowColor,
                    ),
                )
                : MaterialButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (HomeCubit.get(context).levelOfImportant != '') {
                          if (HomeCubit.get(context).timeTask != '') {
                            if (HomeCubit.get(context).dateTask != '') {
                              HomeCubit.get(context).addTask(
                                  title: titleController.text,
                                  describe: describeController.text,
                                  important:
                                      HomeCubit.get(context).levelOfImportant,
                                  date: HomeCubit.get(context).dateTask,
                                  month:HomeCubit.get(context).monthTask ,
                                  time: HomeCubit.get(context).timeTask);

                            } else {
                              final snackBar = SnackBar(
                                content: const Text('choose date.'),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );

                              // Find the ScaffoldMessenger in the widget tree
                              // and use it to show a SnackBar.
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            final snackBar = SnackBar(
                              content: const Text('choose time.'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );

                            // Find the ScaffoldMessenger in the widget tree
                            // and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } else {
                          final snackBar = SnackBar(
                            content: const Text('choose level of important'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    color: shadowColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: defaultColor,
                            fontFamily: 'Righteous-Regular',
                            fontSize: 24),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
