import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

import '../../../models/login/login_model.dart';

class LoginCubit extends Cubit<LoginStates>{

  IconData iconPassword = Icons.remove_red_eye_outlined;
  bool isPassword = true ;
  LoginModel? loginModel ;

  LoginCubit() : super(LoginInitialState());

  static  LoginCubit getInstance (context) => BlocProvider.of(context);

  void userLogin( @required String email , @ required String password){
    emit(LoginLoadingState());
    DioHelper.postData
      (url: URL_LOGIN,
        data:{
        'email' : email,
          'password' : password
        }
    ).then((value) {
      loginModel = LoginModel.formJson(value.data);
     emit(LoginSuccessState(loginModel!));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });
  }

  void changePasswordVisibility(){

    isPassword = !isPassword;
    isPassword ? iconPassword = Icons.visibility_off_outlined: iconPassword = Icons.remove_red_eye_outlined;
    emit(PasswordChangeVisibilityState());
  }
}