class UserDataModel {

  int? id;
  String? name;
  String? email;
  String? image;
  String? token;
  String? phone;
  int? points;
  int? credit;

  UserDataModel.formJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    token = json['token'];
    phone = json['phone'];
    points = json['points'];
    credit = json['credit'];
  }

}