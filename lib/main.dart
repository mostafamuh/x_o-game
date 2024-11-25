
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:x_o/moduls/WinnerPage.dart';
import 'package:x_o/shared/cubit/games_cubit.dart';
import 'package:x_o/moduls/playing_screen.dart';
import 'package:x_o/moduls/playingwithcomputer.dart';
import 'package:x_o/layout/settingOfGame.dart';


void main()  {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor:const Color(0xffFCFBFB),
            ),
            routerConfig: _route,
          )
      ),
    );
  }

  final GoRouter _route= GoRouter(routes: [
    GoRoute(path: "/",builder: ((context,stste)=> const Settingofgame())),
    GoRoute(path: "/PlayingScreen",builder: ((context,stste)=> const PlayingScreen())),
    GoRoute(path: "/PlayingWithComputer",builder: (context, state) {
      final difficulty = state.extra as int? ?? 0;
      return PlayingWithComputer(difficulty: difficulty);
    },),

  ]) ;
}
