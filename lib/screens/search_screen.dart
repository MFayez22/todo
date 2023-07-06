import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/screens/task_day_info.dart';

import '../constants/colors/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class SearchScreen extends StatelessWidget {
  List<Map>? list;
  String? title1;
  String? title2;
   SearchScreen({Key? key, this.list, this.title1, this.title2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                backgroundColor: defaultColor,
                elevation: 0,
                centerTitle: true,
                title: Text(
                  title1!,
                  style: TextStyle(
                      color: shadowColor,
                      fontFamily: 'Righteous-Regular',
                      fontSize: 24),
                ),
                iconTheme: IconThemeData(color: shadowColor)),
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      primaryColor,
                      primaryColor,
                      defaultColor,
                      defaultColor,
                    ]),
              ),
              child: Column(children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: defaultColor,
                      borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(80))),
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: 40,
                      // ),

                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        title2!,
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Righteous-Regular',
                            fontSize: 24),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Expanded(
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(80),
                          )),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) => dayTaskItem(
                                    list: list!,
                                    index: index,
                                    context: context),
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 15,
                                ),
                                itemCount: list!.length),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
Widget dayTaskItem(
    {required List<Map> list,
      required int index,
      required BuildContext context}) =>
    InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TaskDayInfoScreen(
                  list: list[index],
                )));
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
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      list[index]['title'],
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 24,
                          fontFamily: 'Righteous-Regular'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      list[index]['date'],
                      style: TextStyle(
                          color: defaultColor,
                          fontSize: 20,
                          fontFamily: 'Righteous-Regular'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          list[index]['time'],
                          style: TextStyle(
                              color: defaultColor,
                              fontSize: 18,
                              fontFamily: 'Righteous-Regular'),
                        ),
                        Spacer(),
                        Text(
                          list[index]['important'],
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
