import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo/cubit/state.dart';
import 'package:todo/layouts/home/home_layout.dart';
import 'package:todo/network/local/cache_helper.dart';

import '../constants/constants.dart';
import '../models/task_model.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  /// splash screen

  Future<void> splashMoveToNextScreen(BuildContext context) async {
    await Future.delayed(Duration(seconds: 8));
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(builder: (context) => HomeLayout()),
    //         (route) => false);

    emit(SplashMoveSuccessState());
  }

  Future<void> delay(int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
  }

  /// BottomNavigationBar

  int bNBIndex = 1;

  void changeBNBIndex(int newIndex) {
    bNBIndex = newIndex;
    emit(BottomNavigationBarIndexChange());
  }

  /// get  time

  // get Date Time
  String date = '';
  String time = '';
  String year = '';
  String month = '';
  String month2 = '';
  String day = '';
  String tomorrow = '';

  Future getDateTime() async {
    date = DateFormat.MMMMEEEEd().format(DateTime.now());
    time = DateFormat.Hm().format(DateTime.now());
    year = DateFormat.y().format(DateTime.now());
    month = DateFormat.M().format(DateTime.now());
    month2 = DateFormat.MMM().format(DateTime.now());
    day = DateFormat.d().format(DateTime.now());
    tomorrow = '${int.parse(DateFormat.d().format(DateTime.now())) + 1}';
    emit(GetDateTimeState());
  }

  /// data base

  var database;

  void createDataBase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE task (id INTEGER PRIMARY KEY, title TEXT, describe TEXT, important TEXT, date TEXT, month TEXT,time TEXT)');
      print('data base is created');
      await db.execute(
          'CREATE TABLE done (id INTEGER PRIMARY KEY, title TEXT, describe TEXT, important TEXT, date TEXT, month TEXT,time TEXT, doneTime TEXT)');

      await db.execute(
          'CREATE TABLE note (id INTEGER PRIMARY KEY, title TEXT, describe TEXT, editTime TEXT)');

      print('data base note is created');
    });
  }

  void openDataBase() async {
    database = await openDatabase('todo.db');
  }

  void addTask({
    required String title,
    required String describe,
    required String important,
    required String date,
    required String month,
    required String time,
  }) async {
    emit(AddTaskListLoadingState());
    //  database.transaction((txn)  {
    //    return  txn.rawInsert(
    //       'INSERT INTO task( title , describe , important , color , day , month , year , time ) VALUES("$title", "$describe", "$important", "$color", "$day", "$month", "$year" , "$time")')
    //   .then((value)
    //    {
    //
    //    }).catchError((error){});
    //
    // });
    database = await openDatabase('todo.db');
    database
        .rawInsert(
            'INSERT INTO task(title , describe , important , date, month,time ) VALUES("$title", "$describe", "$important", "$date" , "$month", "$time")')
        .then((value) {
      setTaskNotification(
          id: value,
          taskTitle: title,
          taskDescribe: describe,
          setYear: notificationYear,
          setMonth: notificationMonth,
          setDay: notificationDay,
          setHour: notificationHour,setMinute: notificationMinute);
      emit(AddTaskListSuccessState());
      print('INSERT INTO task success $title');
    });

  }

  List<Map> taskList = [];

  Future<void> getTaskList() async {
    emit(GetTaskListLoadingState());
    database = await openDatabase('todo.db');
    taskList = await database.rawQuery('SELECT * FROM task');

    emit(GetTaskListSuccessState());
  }

  List<Map> testSqliteString = [];
  String text = 'mohamed';

  Future<void> testSqlite() async {
    emit(GetTaskListLoadingState());
    database = await openDatabase('todo.db');
    // testSqliteString = await  database.rawQuery('SELECT * FROM task WHERE title = mohamed');
    // testSqliteString = await database.rawQuery(
    //     "SELECT * FROM task WHERE title LIKE '%${text}%' OR  body LIKE '%${text}%'");
    testSqliteString = await database.query(
      "task",
      where: 'title = "khaled"',
    );
    // return res.isNotEmpty ? Client.fromMap(res.first) : null;
    emit(GetTaskListSuccessState());
    print(testSqliteString);
  }

  List<Map> todayTaskList = [];
  List<Map> tomorrowTaskList = [];

  //String text = 'mohamed';
  Future<void> getTodayTaskList() async {
    emit(GetTodayTaskListLoadingState());
    database = await openDatabase('todo.db');

    todayTaskList = await database.query(
      "task",
      where: 'date = "$year-$month-$day"',
    );

    tomorrowTaskList = await database.query(
      "task",
      where: 'date = "$year-$month-$tomorrow"',
    );

    emit(GetTodayTaskListSuccessState());
  }

  List<Map> highTaskList = [];
  List<Map> middleTaskList = [];
  List<Map> lowTaskList = [];

  Future<void> getHighTaskList() async {
    emit(GetTodayTaskListLoadingState());
    database = await openDatabase('todo.db');

    highTaskList = await database.query(
      "task",
      where: 'important = "high"',
    );
    middleTaskList = await database.query(
      "task",
      where: 'important = "middle"',
    );
    lowTaskList = await database.query(
      "task",
      where: 'important = "low"',
    );

    emit(GetTodayTaskListSuccessState());
  }

  List<Map> dayTaskList = [];

  Future<void> getDayTaskList({required String date}) async {
    database = await openDatabase('todo.db');
    dayTaskList = [];
    dayTaskList = await database.query(
      "task",
      where: 'date = "${date}"',
    );

    emit(GetTodayTaskListSuccessState());
  }

  List<Map> monthTaskList = [];

  Future<void> getMonthTaskList({required String date}) async {
    database = await openDatabase('todo.db');

    monthTaskList = await database.query(
      "task",
      where: 'month = "${date}"',
    );

    emit(GetMonthDateTaskListSuccessState());
  }

  void deleteTask({required int id}) async {
    database = await openDatabase('todo.db');
    database.delete("task", where: 'id = "${id}"');

    emit(DeleteTaskListSuccessState());
  }

  void updateTask({
    required String newTitle,
    required String newDescribe,
    required String id,
  }) async {
    database = await openDatabase('todo.db');

    await database.update(
        "task", {'title': "${newTitle}", 'describe': "${newDescribe}"},
        where: 'id = "${id}"');
    emit(UpdateTaskSuccessState());
  }

  void addDone({
    required String id,
    required String title,
    required String describe,
    required String important,
    required String date,
    required String month,
    required String time,
    required String doneTime,
  }) async {
    emit(AddTaskListLoadingState());
    await AwesomeNotifications().cancel(int.parse(id));
    database = await openDatabase('todo.db');

    database.delete("task", where: 'id = "${id}"');
    database
        .rawInsert(
            'INSERT INTO done(title , describe , important , date, month,time ,doneTime ) VALUES("$title", "$describe", "$important", "$date" , "$month", "$time" ,"$doneTime")')
        .then((value) {

      emit(DoneTaskSuccessState());
      print('INSERT INTO task success $title');
    });
  }

  List<Map> doneList = [];

  Future<void> getDoneList() async {
    database = await openDatabase('todo.db');
    doneList = await database.rawQuery('SELECT * FROM done');

    emit(GetDoneListSuccessState());
  }

  void deleteDone({required int id, required String tableName}) async {
    database = await openDatabase('todo.db');

    database.delete(tableName, where: 'id = "${id}"');

    emit(DeleteDoneSuccessState());
  }

  void addNote({
    required String title,
    required String describe,
    required String editTime,
  }) async {
    emit(AddTaskListLoadingState());

    database = await openDatabase('todo.db');
    database
        .rawInsert(
            'INSERT INTO note(title , describe, editTime ) VALUES("$title", "$describe", "$editTime")')
        .then((value) {
      emit(AddNoteSuccessState());
      print('INSERT INTO task success $title');
    });
  }

  List<Map> noteList = [];

  Future<void> getNoteList() async {
    database = await openDatabase('todo.db');
    noteList = await database.rawQuery('SELECT * FROM note');

    emit(GetDoneListSuccessState());
  }

  void updateNote({
    required String newTitle,
    required String newDescribe,
    required String editTime,
    required String id,
  }) async {
    database = await openDatabase('todo.db');

    await database.update(
        "note",
        {
          'title': "${newTitle}",
          'describe': "${newDescribe}",
          'editTime': "${editTime}"
        },
        where: 'id = "${id}"');
    emit(UpdateNoteSuccessState());
  }

  List<Map> searchList = [];

  Future<void> getSearchList({required String searchTitle}) async {
    database = await openDatabase('todo.db');

    // searchList = await database
    //     .query(
    //   "task",
    //   where: 'title like "${searchTitle}"',
    // );

    searchList = await database.rawQuery(
        'SELECT * FROM task WHERE title = "$searchTitle" ORDER BY title ');

    emit(GetSearchListSuccessState());
    // .then((value) {
    // emit(GetSearchListSuccessState());
    // })
  }

  /// choose level of important

  bool isHigh = false;
  bool isMiddle = false;
  bool isLow = false;

  String levelOfImportant = '';

  void chooseLevelOfImportant({required int numTheme}) {
    switch (numTheme) {
      case 1:
        {
          isHigh = !isHigh;
          isMiddle = false;
          isLow = false;
          levelOfImportant = 'high';
        }
        break;
      case 2:
        {
          isMiddle = !isMiddle;
          isHigh = false;
          isLow = false;
          levelOfImportant = 'middle';
        }
        break;
      case 3:
        {
          isLow = !isLow;
          isMiddle = false;
          isHigh = false;
          levelOfImportant = 'low';
        }
        break;
    }
    emit(ChooseLevelOfImportant());
  }

  /// choose time

  // Future<TimeOfDay?> selectedTimeRTL ;

  String timeTask = '';
  int notificationHour = 0;
  int notificationMinute = 0;

  void chooseTime(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value!.periodOffset == 12) {
        timeTask = '${value!.hourOfPeriod} : ${value!.minute} PM';
      } else {
        timeTask = '${value!.hourOfPeriod} : ${value!.minute} AM';
      }
      notificationHour = value.hour;
      notificationMinute = value.minute;
      print(timeTask);
      print(notificationHour);
      print(notificationMinute);
      emit(ChooseTime());
    });
  }

  /// choose date

  DateTime focusedDay = DateTime.now();
  String dateTask = '';
  String monthTask = '';
  int notificationYear = 0;
  int notificationMonth = 0;
  int notificationDay = 0;

  void onDaySelected(DateTime time1, DateTime time2) {
    focusedDay = time1;
    dateTask = '${time1.year}-${time1.month}-${time1.day}';
    monthTask = '${time1.year}-${time1.month}';

    notificationYear = time1.year;
    notificationMonth = time1.month;
    notificationDay = time1.day;

    emit(ChooseDate());
  }

  CalendarFormat calendarFormat = CalendarFormat.month;

  void onFormatChanged(CalendarFormat format) {
    calendarFormat = format;
    emit(ChooseDate());
  }

  /// get date to list

  String getDateText = '';

  void getDayTask({required BuildContext context}) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.utc(2010, 10, 16),
      lastDate: DateTime.utc(2030, 3, 14),
    ).then((value) {
      if (value != null) {
        getDateText = '${value?.year}-${value?.month}-${value?.day}';
        getDayTaskList(date: '${value?.year}-${value?.month}-${value?.day}');
        print(getDateText);
        print('${value?.year}-${value?.month}-${value?.day}');
        emit(GetDateTaskListSuccessState());
      }
    });
  }

  /// Container Visibility

  bool isVisible = false;

  void changeVisibility() {
    isVisible = !isVisible;
    emit(ContainerVisibilitySuccessState());
  }

  ///  choose month to get month list

  String chooseYearText = DateFormat.y().format(DateTime.now());

  void plusYear() {
    chooseYearText = (int.parse(chooseYearText) + 1).toString();
    emit(ChooseYearState());
  }

  void minceYear() {
    chooseYearText = (int.parse(chooseYearText) - 1).toString();
    emit(ChooseYearState());
  }

  int monthTextListIndex = 0;

  void plusMonth() {
    if (monthTextListIndex < 11) {
      monthTextListIndex = monthTextListIndex + 1;
      emit(ChooseYearState());
    }
  }

  void minceMonth() {
    if (monthTextListIndex > 0) {
      monthTextListIndex = monthTextListIndex - 1;
      emit(ChooseYearState());
    }
  }

  List<String> monthTextList = [
    'Jan.	',
    'Feb.	',
    'Mar.	',
    'Apr.	',
    'May.	',
    'Jun.	',
    'Jul.	',
    'Aug.	',
    'Sep.	',
    'Oct.	',
    'Nov.	',
    'Dec.	',
  ];

  ///

  bool isEnglish = CacheHelper.getData(key: 'isEnglish') ?? true;

  void changeLanguage() {
    isEnglish = !isEnglish;
    emit(SwitchValueChangeState());
  }

  void saveLanguage({required bool test}) {
    CacheHelper.setData(key: 'isEnglish', value: test).then((value) {
      print('done 2');
      emit(SaveLanguageSuccessState());
    });
    // isEnglish = !isEnglish;
  }

  void getIsEnglish() {
    isEnglish1 = CacheHelper.getData(key: 'isEnglish') ?? true;
    emit(SwitchValueChangeState());
  }

  /// notification

  Future<void> setTaskNotification({
    required int id,
    required int setYear,
    required int setMonth,
    required int setDay,
    required int setHour,
    required int setMinute,
    required String taskTitle,
    required String taskDescribe,
  }) async {
    // DateTime date = DateTime(2023,6,28,18,26,00);
    AwesomeNotifications().requestPermissionToSendNotifications();
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id + 99,
            channelKey: 'taskKey',
            title: taskTitle,
            body: taskDescribe),
        schedule: NotificationCalendar(
            year: setYear,
            month: setMonth,
            day: setDay,
            hour: setHour,
            minute: setMinute,
            second: 00));
  }

   Future<void> cancelNotifications({required int id}) async {
    // await AwesomeNotifications().cancelAll();
    await AwesomeNotifications().cancel(id,);
  }
}
