import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/constants.dart';
import '../../../models/search/search_model.dart';

class SearchCubit extends Cubit<SearchStates> {

  SearchModel? searchModel;

  SearchCubit() : super(SearchInitialState());

  static SearchCubit getInstance (context) => BlocProvider.of(context);

  void getSearch(String text){
    emit(ShopSearchLoadingState());
    DioHelper.postData(
        url: URL_SEARCH,
        data: {
          'text': text
        },
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(ShopSearchSuccessState());
    })
        .catchError((onError){
      emit(ShopSearchErrorState());
    });
  }
}