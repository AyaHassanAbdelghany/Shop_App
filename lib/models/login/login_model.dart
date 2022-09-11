import 'package:shop_app/models/login/user_data_model.dart';

class LoginModel {

  String? message ;
  bool status = true ;
  UserDataModel? data;

  LoginModel.formJson(Map<String,dynamic> json){

    message = json['message'];
    status = json['status'];
    data = json['data'] !=null ? UserDataModel.formJson(json['data'] ) : null;
  }
}