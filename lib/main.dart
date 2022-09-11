import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observe.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'network/remote/dio_helper.dart';

void main()  {

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:lightTheme,
      darkTheme: darkTheme,
      home:OnBoardingScreen() ,
    );
  }
}
