import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/state.dart';
import 'package:todo/screens/search_screen.dart';


import '../constants/colors/colors.dart';
import '../constants/constants.dart';
import 'day_task_screen.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is GetSearchListSuccessState) {

          List<Map> list =HomeCubit.get(context).searchList;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchScreen(
                    title1: 'Search',
                    title2: '',
                    list: list,
                  )));
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
          child: Column(
            children: [

              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        isEnglish1 ? 'GOOD DAY' : 'يوم جميل',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 24,
                            fontFamily:
                            isEnglish1 ? 'Righteous-Regular' : 'Cairo'),
                      ),
                      Text(
                        '${HomeCubit.get(context).day} , ${HomeCubit.get(context).month2} ${HomeCubit.get(context).year}',
                        style: TextStyle(
                            color: defaultColor,
                            fontFamily: 'Righteous-Regular',
                            fontSize: 24),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        height: 1,
                        width: 100,
                        color: primaryColor,
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 100,
                    child: Lottie.asset('lib/images/home-icon.json',
                        height: 100,
                        reverse: true,
                        repeat: true,
                        fit: BoxFit.cover),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),

              /// search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  onEditingComplete: () {
                    HomeCubit.get(context)
                        .getSearchList(searchTitle: searchController.text);
                  },
                  obscureText: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'is empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text(
                        isEnglish1 ? 'search for task' : 'البحث عن المهمة'),
                    prefixIcon: Icon(
                      Icons.search,
                      color: defaultColor,
                    ),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(30.0))),
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
                  color: primaryColor,
                ),
              ),
              SizedBox(
                height: 8,
              ),

              /// Single Child Scroll View

              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      /// card home today task
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              clipBehavior: Clip.hardEdge,
                              color: primaryColor,
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: InkWell(
                                onTap: () {
                                  List<Map> todayList =
                                      HomeCubit.get(context).todayTaskList;
                                  String todayDate =
                                      HomeCubit.get(context).date;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DayTaskScreen(
                                            list: todayList,
                                            title1: 'Today task',
                                            title2: todayDate,
                                          )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          isEnglish1
                                              ? 'Today Task'
                                              : 'مهام اليوم',
                                          style: TextStyle(
                                              color: shadowColor,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        HomeCubit.get(context)
                                            .todayTaskList
                                            .length ==
                                            0
                                            ? Center(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(
                                                20.0),
                                            child: Text(
                                              'No Task FOR Today ',
                                              style: TextStyle(
                                                  color: lightColor,
                                                  fontSize: 20,
                                                  fontFamily:
                                                  'Righteous-Regular'),
                                            ),
                                          ),
                                        )
                                            : ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                          NeverScrollableScrollPhysics(),
                                          itemBuilder: (context,
                                              index) =>
                                              todayTaskItem(
                                                  index: index,
                                                  list: HomeCubit.get(
                                                      context)
                                                      .todayTaskList),
                                          itemCount:
                                          HomeCubit.get(context)
                                              .todayTaskList
                                              .length,
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),

                      /// card home note

                      Row(
                        children: [
                          SizedBox(
                            width: 80,
                          ),
                          Expanded(
                            child: Card(
                              clipBehavior: Clip.hardEdge,
                              color: defaultColor,
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isEnglish1 ? 'Notes' : 'المذكرة',
                                      style: TextStyle(
                                          color: shadowColor, fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    HomeCubit.get(context).noteList.length ==
                                        0
                                        ? Center(
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(20.0),
                                        child: Text(
                                          'the note is empty',
                                          style: TextStyle(
                                              color: lightColor,
                                              fontSize: 20,
                                              fontFamily:
                                              'Righteous-Regular'),
                                        ),
                                      ),
                                    )
                                        : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          todayTaskItem(
                                              index: index,
                                              list:
                                              HomeCubit.get(context)
                                                  .noteList),
                                      itemCount: HomeCubit.get(context).noteList.length,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),

                      /// card home for tomorrow

                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              clipBehavior: Clip.hardEdge,
                              color: shadowColor,
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: InkWell(
                                onTap: () {
                                  List<Map> tomorrowList =
                                      HomeCubit.get(context).tomorrowTaskList;
                                  String todayDate =
                                      '${HomeCubit.get(context).year}-${HomeCubit.get(context).month}-${HomeCubit.get(context).tomorrow}';
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DayTaskScreen(
                                            list: tomorrowList,
                                            title1: 'Tomorrow task',
                                            title2: todayDate,
                                          )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        isEnglish1
                                            ? 'FOR Tomorrow'
                                            : 'مهمات الغد',
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      HomeCubit.get(context)
                                          .tomorrowTaskList
                                          .length ==
                                          0
                                          ? Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              20.0),
                                          child: Text(
                                            'No Task FOR Tomorrow ',
                                            style: TextStyle(
                                                color: defaultColor,
                                                fontSize: 20,
                                                fontFamily:
                                                'Righteous-Regular'),
                                          ),
                                        ),
                                      )
                                          : ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                        NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            tomorrowTaskItem(
                                                index: index,
                                                list: HomeCubit.get(
                                                    context)
                                                    .tomorrowTaskList),
                                        itemCount:
                                        HomeCubit.get(context)
                                            .tomorrowTaskList
                                            .length,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget todayTaskItem({required List<Map> list, required int index}) {
  return Column(
    children: [
      Row(
        children: [
          Icon(
            Icons.circle,
            color: shadowColor,
            size: 14,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              list[index]['title'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: lightColor,
                  fontSize: 20,
                  fontFamily: 'Righteous-Regular'),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 5,
      ),
    ],
  );
}

Widget tomorrowTaskItem({required List<Map> list, required int index}) {
  return Column(
    children: [
      Row(
        children: [
          Icon(
            Icons.circle,
            color: primaryColor,
            size: 14,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              list[index]['title'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: defaultColor,
                  fontSize: 20,
                  fontFamily: 'Righteous-Regular'),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 5,
      ),
    ],
  );
}
