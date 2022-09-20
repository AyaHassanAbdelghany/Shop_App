class ChangeFavouriteModel{

  bool status = true;
  String? message;

  ChangeFavouriteModel.fromJson(Map<String,dynamic> json){

    status = json['status'];
    message = json['message'];
  }

}