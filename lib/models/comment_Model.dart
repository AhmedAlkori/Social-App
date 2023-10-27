class CommentDataModel
{
  String? userImage;
  String? userName;
  String? userComment;
  String? dateTime;
  String? userID;

  CommentDataModel({
    required String u_image,
    required String u_name,
    required String u_comment,
    required String time,
    required String uId,
})
  {
    this.userImage=u_image;
    this.userName=u_name;
    this.userComment=u_comment;
    this.dateTime=time;
    this.userID=uId;
  }

  CommentDataModel.fromJson(Map<String,dynamic>json)
  {
    userImage=json['userImage'];
    userName=json['userName'];
    userComment=json['userComment'];
    dateTime=json['dateTime'];
    userID=json['uId'];
  }

  Map<String,dynamic> toMap()
  {
    return {
      'userImage':userImage,
      'userName':userName,
      'userComment':userComment,
      'dateTime':dateTime,
      'uId':userID,

    };
  }

}