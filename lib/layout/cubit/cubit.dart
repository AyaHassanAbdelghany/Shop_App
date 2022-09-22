import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favourities/change_favourite_model.dart';
import 'package:shop_app/models/favourities/favourite_model.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourite/favourite_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/constants.dart';
import '../../models/categories/category_model.dart';
import '../../models/home/home_model.dart';
import '../../modules/home/home_screen.dart';

class ShopCubit extends Cubit<ShopStates>{


  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const FavouriteScreen(),
     SettingsScreen(),
  ];
  HomeModel? homeModel ;
  CategoryModel? categoryModel;
  ChangeFavouriteModel? changeFavouriteModel;
  FavouriteModel? favouriteModel;
  LoginModel? loginModel;

  Map<int,bool>  favourites = Map() ;

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
          homeModel = HomeModel.fromJson(value.data);
          homeModel!.data!.products.forEach((element) {
            favourites.addAll({
              element.id!: element.inFavorites!
            });
          });
          emit(ShopProductSuccessState());
    }).catchError((error){
      emit(ShopProductErrorState());
    });
  }

  void getCategories(){
    emit(ShopLoadingState());
    DioHelper.getData(
        url: URL_CATEGORIES,
    ).then((value){
      categoryModel = CategoryModel.fromJson(value.data);
      print(value.data);
      emit(ShopCategorySuccessState());
    }).catchError((error){
      emit(ShopCategoryErrorState());
    });
  }

  void changeFavourite(int? productId){
    favourites[productId!] = !favourites[productId]!;
    emit(ShopChangeFavouriteState());
    DioHelper.postData(
        url: URL_FAVOURITES,
        data: {
          'product_id' :productId
        },
        token: token
    ).then((value){
      changeFavouriteModel =  ChangeFavouriteModel.fromJson(value.data);
      if(!changeFavouriteModel!.status){
        favourites[productId] = !favourites[productId]!;
      }
      else{
        getFavourite();
      }
      emit(ShopChangeFavouriteSuccessState(changeFavouriteModel!));
    }).catchError((error){
      favourites[productId] = !favourites[productId]!;
      emit(ShopChangeFavouriteErrorState());
    });
  }

  void getFavourite(){
    favouriteModel = null;
    DioHelper.getData(
        url: URL_FAVOURITES,
        token: token
    ).then((value){
      favouriteModel = FavouriteModel.fromJson(value.data);
      emit(ShopGetFavouriteSuccessState());
    }).catchError((error){
      emit(ShopGetFavouriteErrorState());
    });
  }

  void getProfile(){
    DioHelper.getData(
        url: URL_PROFILE,
        token: token
    ).then((value){
      loginModel = LoginModel.formJson(value.data);
      emit(ShopProfileSuccessState());
    }).catchError((error){
      emit(ShopProfileErrorState());
    });
  }

  void updateProfile({
  required String email,
    required String phone,
    required String name,

  }){
    emit(ShopUpdateProfileLoadingState());
    DioHelper.putData(
        url: URL_UPDATE_PROFILE,
        data: {
          'email': email,
          'phone': phone,
          'name': name
        },
        token: token
    ).then((value){
      loginModel = LoginModel.formJson(value.data);
      emit(ShopUpdateProfileSuccessState());
    }).catchError((error){
      emit(ShopUpdateProfileErrorState());
    });
  }
}