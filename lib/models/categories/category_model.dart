import 'category_data_model.dart';

class CategoryModel{

  bool? status;
  CategoryDataModel? model;

  CategoryModel.fromJson(Map<String,dynamic> json){

    status = json['status'];
    model = CategoryDataModel.fromJson(json['data']);
  }
}