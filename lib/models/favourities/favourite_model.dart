import 'favourite_data_model.dart';

class FavouriteModel{

  bool? status;
  String? message;
  FavouriteDataModel? data;

  FavouriteModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new FavouriteDataModel.fromJson(json['data']) : null;
  }
}