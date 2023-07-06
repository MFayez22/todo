import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo/constants/constants.dart';
import 'package:todo/screens/splash_screen.dart';

import '../constants/colors/colors.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) =>
      HomeCubit()
        ..openDataBase()
        ,
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is SaveLanguageSuccessState) {

            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SplashScreen()), (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: key,
            body: Container(
              color: primaryColor,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
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

                                /// language
                                Row(
                                  children: [
                                    Icon(
                                      Icons.language,
                                      color: shadowColor,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'language',
                                      style: TextStyle(
                                          color: shadowColor,
                                          fontFamily: 'Righteous-Regular',
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
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
                                        HomeCubit.get(context)
                                            .changeVisibility();
                                        print(HomeCubit
                                            .get(context)
                                            .isVisible);
                                      },
                                      icon: HomeCubit
                                          .get(context)
                                          .isVisible
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
                                  visible: HomeCubit
                                      .get(context)
                                      .isVisible,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'اللغة العربيه ',
                                                style: TextStyle(
                                                    color: shadowColor,
                                                    fontFamily:
                                                    'Righteous-Regular',
                                                    fontSize: 18),
                                              ),
                                              Spacer(),
                                              CircleAvatar(
                                                  backgroundColor: primaryColor,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        4.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        HomeCubit.get(context)
                                                            .changeLanguage();
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                        HomeCubit
                                                            .get(
                                                            context)
                                                            .isEnglish
                                                            ? defaultColor
                                                            : primaryColor,
                                                      ),
                                                    ),
                                                  )),
                                              SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'English',
                                                style: TextStyle(
                                                    color: shadowColor,
                                                    fontFamily:
                                                    'Righteous-Regular',
                                                    fontSize: 18),
                                              ),
                                              Spacer(),
                                              CircleAvatar(
                                                  backgroundColor: primaryColor,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        4.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        HomeCubit.get(context)
                                                            .changeLanguage();
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                        HomeCubit
                                                            .get(
                                                            context)
                                                            .isEnglish
                                                            ? primaryColor
                                                            : defaultColor,
                                                      ),
                                                    ),
                                                  )),
                                              SizedBox(
                                                width: 20,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: MaterialButton(
                                              onPressed: () {
                                                HomeCubit.get(context)
                                                    .saveLanguage(
                                                    test: HomeCubit
                                                        .get(
                                                        context)
                                                        .isEnglish);
                                              },
                                              color: shadowColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.0)),
                                              child: Text(
                                                'save',
                                                style: TextStyle(
                                                    color: defaultColor,
                                                    fontFamily:
                                                    'Righteous-Regular',
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),


                              ]),
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
