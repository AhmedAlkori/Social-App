import 'dart:math';

class ChatModel
{
  String? senderId;
  String? reciverId;
  String? message;
  String? dateTime;
  String? img;

  ChatModel({
    required String sender,
    required String reciver,
    required String msg,
    required String Time,
    required String pic,
})
  {
    this.senderId=sender;
    this.reciverId=reciver;
    this.message=msg;
    this.dateTime=Time;
    this.img=pic;
  }

  ChatModel.fromJson(Map<String,dynamic>json)
  {
    senderId=json['senderId'];
    reciverId=json['reciverId'];
    message=json['message'];
    dateTime=json['dateTime'];
    img=json['img'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'senderId':senderId,
      'reciverId':reciverId,
      'message':message,
      'dateTime':dateTime,
      'img':img,
    };
  }
}