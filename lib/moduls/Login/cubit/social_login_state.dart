
abstract class SocialState{}

class SocialInitState extends SocialState{}

class SocialChangeLastState extends SocialState{}

class SocialSetOnBoardingState extends SocialState{}

class SocialChangePassState extends SocialState{}

class SocialLoadDataState extends SocialState{}
class SocialGetDataSuccessState extends SocialState
{
  final uId;
  SocialGetDataSuccessState(this.uId);
}
class SocialGetDataErrorState extends SocialState
{
   final error;
   SocialGetDataErrorState(this.error);
}
