class DataModel{


  int? id ;
  String? image;
  String? name;

  DataModel.fromJson(Map<String,dynamic> json){

  id = json['id'];
  image = json['image'];
  name = json['name'];

  }
}