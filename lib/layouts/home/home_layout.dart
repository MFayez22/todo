import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/constants/colors/colors.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/state.dart';
import 'package:todo/screens/add_task_screen.dart';
import 'package:todo/screens/done_screen.dart';
import 'package:todo/screens/note_screen.dart';
import 'package:todo/screens/task_screen.dart';

import '../../constants/constants.dart';
import '../../screens/home_screen.dart';
import '../../screens/settings_screen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    PageController controllerPageView = PageController();
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()
        ..getDateTime()
        ..getNoteList()
        ..getTaskList()
        ..getDoneList()
        ..getTodayTaskList()
        ..getHighTaskList(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit.get(context).getTaskList();
          HomeCubit.get(context).getDoneList();
          HomeCubit.get(context).getNoteList();
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: HomeCubit.get(context).bNBIndex ==0 ? 0:4,
              title: Text(
                titleList[HomeCubit.get(context).bNBIndex],
                style: TextStyle(
                  color: shadowColor,
                  fontFamily: isEnglish1 ? 'Pacifico-Regular':'Cairo',
                  fontSize: 24,

                ),
              ),
            ),
            body: listOfScreens[HomeCubit.get(context).bNBIndex],
            bottomNavigationBar: BottomNavigationBar(
                items: bottomNavigationBarItemList,
                onTap: (index) {
                  HomeCubit.get(context).changeBNBIndex(index);
                  // controllerPageView.animateToPage(
                  //     index, duration: Duration(seconds: 1), curve: Curves.linear);
                },
                elevation: 0,
                fixedColor: shadowColor,
                currentIndex: HomeCubit.get(context).bNBIndex),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddTaskScreen()));
                },
                child: Icon(
                  Icons.add,
                  size: 35,
                )),
          );
        },
      ),
    );
  }
}

List<Widget> listOfScreens = [
  SettingsScreen(),
  homeScreen(),
  TaskScreen(),
  NoteScreen(),
  DoneScreen(),
];



List<BottomNavigationBarItem> bottomNavigationBarItemList = [
  BottomNavigationBarItem(
      icon: Icon(
        Icons.settings_outlined,
        color: shadowColor,
      ),
      label: isEnglish1 ?  'Settings': 'الإعدادات',
      backgroundColor: defaultColor),
  BottomNavigationBarItem(
      icon: Icon(
        Icons.home_outlined,
        color: shadowColor,
      ),
      label:isEnglish1 ?   'Home': 'الصفحة الرئيسية',
      backgroundColor: primaryColor),
  BottomNavigationBarItem(
      icon: Icon(
        Icons.task,
        color: shadowColor,
      ),
      label:isEnglish1 ?   'Task':'المهمات',
      backgroundColor: defaultColor),
  BottomNavigationBarItem(
      icon: Icon(
        Icons.sticky_note_2_outlined,
        color: shadowColor,
      ),
      label:isEnglish1 ?   'Note':'مذكرة',
      backgroundColor: primaryColor),
  BottomNavigationBarItem(
      icon: Icon(
        Icons.done_outline,
        color: shadowColor,
      ),
      label: isEnglish1 ?  'Done':'المنجز',
      backgroundColor: defaultColor),
];
