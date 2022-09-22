import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

import '../../../models/login/login_model.dart';

class RegisterCubit extends Cubit<RegisterStates>{

  IconData iconPassword = Icons.remove_red_eye_outlined;
  bool isPassword = true ;
  LoginModel? loginModel ;

  RegisterCubit() : super(RegisterInitialState());

  static  RegisterCubit getInstance (context) => BlocProvider.of(context);

  void userRegister(
      @required String email ,
      @ required String password,
      @ required String name,
      @ required String phone,
      ){
    emit(RegisterLoadingState());
    DioHelper.postData
      (url: URL_REGISTER,
        data:{
        'name' :name,
          'phone' :phone,
        'email' : email,
          'password' : password
        }
    ).then((value) {
      loginModel = LoginModel.formJson(value.data);
     emit(RegisterSuccessState(loginModel!));
    }).catchError((error){
      print('msg ${error.toString()}');
      emit(RegisterErrorState(error.toString()));
    });
  }

  void changePasswordVisibility(){

    isPassword = !isPassword;
    isPassword ? iconPassword = Icons.visibility_off_outlined: iconPassword = Icons.remove_red_eye_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }
}