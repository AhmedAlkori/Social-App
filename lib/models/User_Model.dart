class UserDataModel
{
  String? firstName;
  String? secondName;
  String? userEmail;
  String? phonNumber;
  String? userPassword;
  String? userOld;
  bool? haveSideEffect;
  String? userGender;
  String? skinType;
  String? otherData;
  String? userUId;

 UserDataModel(
  this.firstName,
  this.secondName,
  this.userEmail,
  this.phonNumber,
  this.userPassword,
  this.userOld,
  this.haveSideEffect,
     this.userGender,
     this.skinType,
     this.otherData,
     this.userUId,
  );
 UserDataModel.fromJson(Map<String,dynamic>json)
 {
   firstName=json['firstName'];
    secondName=json['secondName'];
  userEmail=json['userEmail'];
    phonNumber=json['userPhone'];
    userOld=json['userOld'];
    haveSideEffect=json['haveSideEffect'];
  userGender=json['userGender'];
   skinType=json['skinType'];
   otherData=json['otherData'];
    userUId=json['userId'];
 }

  Map<String,dynamic> toMap()
  {
    return {
      'firstName':firstName,
      'secondName':secondName,
      'userEmail':userEmail,
      'userPhone':phonNumber,
      'userOld':userOld,
      'haveSideEffect':haveSideEffect,
      'userGender':userGender,
      'skinType':skinType,
      'otherData':otherData,
      'userId':userUId,
    };
  }

}