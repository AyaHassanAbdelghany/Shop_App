import 'data_model.dart';

class CategoryDataModel{

  int? currentPage;
  List<DataModel> data =[];

  CategoryDataModel.fromJson(Map<String,dynamic> json){

    currentPage = json['current_page'];
    json['data'].forEach((element) {
     data.add(DataModel.fromJson(element));
    });
  }
}