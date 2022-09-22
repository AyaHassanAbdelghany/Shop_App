import 'package:shop_app/models/favourities/change_favourite_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavBarState extends ShopStates{}

class ShopLoadingState extends ShopStates{}

class ShopProductSuccessState extends ShopStates{}

class ShopProductErrorState extends ShopStates{}

class ShopCategorySuccessState extends ShopStates{}

class ShopCategoryErrorState extends ShopStates{}

class ShopChangeFavouriteState extends ShopStates{}

class ShopChangeFavouriteSuccessState extends ShopStates{
  final ChangeFavouriteModel changeFavouriteModel;
  ShopChangeFavouriteSuccessState(this.changeFavouriteModel);
}

class ShopChangeFavouriteErrorState extends ShopStates{}

class ShopGetFavouriteSuccessState extends ShopStates{}

class ShopGetFavouriteErrorState extends ShopStates{}

class ShopProfileSuccessState extends ShopStates{}

class ShopProfileErrorState extends ShopStates{}

class ShopUpdateProfileLoadingState extends ShopStates{}

class ShopUpdateProfileSuccessState extends ShopStates{}

class ShopUpdateProfileErrorState extends ShopStates{}
