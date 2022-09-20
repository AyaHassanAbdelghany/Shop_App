import '../home/product_model.dart';

class DataModel{
  int? id;
  ProductModel? product;

  DataModel.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  product =
  json['product'] != null ? new ProductModel.fromJson(json['product']) : null;
  }

}