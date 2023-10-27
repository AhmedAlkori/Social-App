class PostDataModel
{
  String? userName;
  String? userId;
  String? userImage;
  String? postImage;
  String? postText;
  String? dateTime;

  PostDataModel({
    required String name,
    required String uerId,
    required String image,
    required String posImage,
    required String text,
    required String time,
})
  {
    this.userName=name;
    this.userId=uerId;
    this.userImage=image;
    this.postImage=posImage;
    this.postText=text;
    this.dateTime=time;
  }

  PostDataModel.fromJson(Map<String,dynamic>json)
  {
    userName=json['userName'];
    userId=json['userId'];
    userImage=json['userImage'];
    postImage=json['postImage'];
    postText=json['postText'];
    dateTime=json['dateTime'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'userName':userName,
      'userId':userId,
      'userImage':userImage,
      'postImage':postImage,
      'postText':postText,
      'dateTime':dateTime,
    };
  }

}