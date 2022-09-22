import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observe.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget? widget ;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
   token = CacheHelper.getData(key: 'token');

  if(onBoarding!=null){
    if(token!=null){
      widget = ShopLayout();
    }
    else{
      widget = LoginScreen();
    }
  }
  else{
    widget = OnBoardingScreen();
  }

  runApp(MyApp(widget!));
}

class MyApp extends StatelessWidget {
  final Widget widget ;

  MyApp(this.widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopCubit()..getProducts()..getCategories()..getFavourite()..getProfile()),
      ],
      child: MaterialApp(
        theme:lightTheme,
        darkTheme: darkTheme,
        home: widget ,
      ),
    );
  }
}
