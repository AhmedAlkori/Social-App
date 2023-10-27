

abstract class RegisterState{}
class RegisterInitState extends RegisterState{}

class RegisterChangePassState extends RegisterState{}


class RegisterLoadDataState extends RegisterState{}
class RegisterGetDataSuccessState extends RegisterState
{
}
class RegisterCreateUserSuccessState extends RegisterState
{
  final uId;
  RegisterCreateUserSuccessState(this.uId);
}
class RegisterCreateUserErrorState extends RegisterState
{
  final  error;
  RegisterCreateUserErrorState(this.error);
}
class RegisterGetDataErrorState extends RegisterState
{
  final String error;
  RegisterGetDataErrorState(this.error);
}