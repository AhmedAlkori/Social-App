class UsersDataModel
{
  String? name;
  String? email;
  String? password;
  String? phone;
  String? image;
  String? bio;
  String? cover;
  bool? isEmailVerfied;
  String? uId;

  UsersDataModel({
    this.name,
    this.email,
    this.password,
    this.phone,
    this.image,
    this.bio,
    this.cover,
    this.isEmailVerfied,
    this.uId,
});

UsersDataModel.fromJson(Map<String,dynamic>json)
{
  name=json['name'];
  email=json['email'];
  password=json['password'];
  phone=json['phone'];
  image=json['image'];
  bio=json['bio'];
  cover=json['cover'];
  isEmailVerfied=json['isEmailVerfied'];
  uId=json['uId'];
}
Map<String,dynamic> toMap()
{
  return {
    'name':name,
    'email':email,
    'phone':phone,
    'image':image,
    'bio':bio,
    'cover':cover,
    'password':password,
    'uId':uId,
    'isEmailVerfied':isEmailVerfied
  };
}

}