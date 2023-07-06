import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo/constants/colors/colors.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/state.dart';
import 'package:todo/layouts/home/home_layout.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit()
        ..splashMoveToNextScreen(context)
        ..createDataBase()
        ..openDataBase()
        ..getTaskList()..getIsEnglish(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is SplashMoveSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeLayout()),
                (route) => false);
          }
        },
        builder: (context, state) {
          // HomeCubit.get(context).getIsEnglish();
          return Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      primaryColor,
                      defaultColor,
                    ]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                  ),

                  Center(
                    child: Container(
                      height: 300,
                      child: Lottie.asset('lib/images/splash-icon.json',
                          height: 100,
                          reverse: true,
                          repeat: true,
                          fit: BoxFit.cover),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Get Start your task with TODO',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Pacifico-Regular',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Spacer(),
                  // Align(
                  //   alignment: AlignmentDirectional.bottomCenter,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(bottom: 10.0),
                  //     child: Image.asset(
                  //       'lib/images/icons/main-icon.png',
                  //       height: 60,
                  //       width: 60,
                  //     ),
                  //
                  //   ),
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Text(
                        'Todo',
                        style: TextStyle(
                            color: shadowColor,
                            fontFamily: 'Righteous-Regular',
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'by MFayez',
                        style: TextStyle(
                            fontFamily: 'Righteous-Regular',
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
