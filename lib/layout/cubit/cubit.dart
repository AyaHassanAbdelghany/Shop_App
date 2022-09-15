import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourite/favourite_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/constants.dart';

import '../../models/home/home_model.dart';
import '../../modules/home/home_screen.dart';

class ShopCubit extends Cubit<ShopStates>{


  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavouriteScreen(),
    const SettingsScreen(),
  ];
  HomeModel? homeModel ;

  ShopCubit() : super(ShopInitialState());

  static ShopCubit getInstance (context) => BlocProvider.of(context);

  void changeIndex(int index){

    currentIndex = index;
    emit(ShopChangeBottomNavBarState());
  }

  void getProducts(){
    emit(ShopLoadingState());
    DioHelper.getData(
      url: URL_HOME,
      token: token
        ).then((value){
          print(value.data);
          print("token $token");
          homeModel = HomeModel.fromJson(value.data);
          emit(ShopProductSuccessState());
    }).catchError((error){
      emit(ShopProductErrorState());
    });
  }
}