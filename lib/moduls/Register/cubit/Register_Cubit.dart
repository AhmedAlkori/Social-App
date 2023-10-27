
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../models/social_model.dart';
import 'Register_State.dart';

class RegisterCubit extends Cubit<RegisterState>
{
  RegisterCubit():super(RegisterInitState());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  bool isHide=true;

  void changePass()
  {
    isHide =!isHide;
    emit(RegisterChangePassState());
  }


  void MakeRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
     String image='https://img.freepik.com/free-photo/headshot-pleased-hipster-has-satisfied-expression_273609-18229.jpg?w=826&t=st=1665347610~exp=1665348210~hmac=a47973c7659b03ca14bd6a1f076356672738334b8465b50f3a5549113d07e65b',
    String bio='write your bio ...',
    String cover='https://img.freepik.com/free-photo/tomatoes-tomatoes-lemon-leaves-garlic-bottle-oil-tree-branches_140725-74118.jpg?w=826&t=st=1665347759~exp=1665348359~hmac=59cc9d1a5ccf80f6654c43d4c960b70acba313be280d117f670a9fcd1d7eaaf5',
  })
  {
    emit(RegisterLoadDataState());
    FirebaseAuth
        .instance
        .createUserWithEmailAndPassword(
        email: email,
        password: password)
        .then((value)
    {
      print(value.user?.email);
      print(value.user?.uid);
      createUser(
          name: name,
          email: email,
          password: password,
          phone: phone,
          image: image,
          bio: bio,
          cover: cover,
          uId: value.user!.uid,
          isEmailVerfied: value.user!.emailVerified);
    }).catchError((error){
      print('error when register new user ${error.toString()}');
      emit(RegisterGetDataErrorState(error));
    });
  }


  void createUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String uId,
    required String image,
    required String bio,
    required String cover,
    required bool isEmailVerfied,
  })
  {
    UsersDataModel model=UsersDataModel(
        name: name,
        email: email,
        password: password,
        phone: phone,
        image: image,
        bio: bio,
        cover: cover,
        uId:uId ,
        isEmailVerfied: isEmailVerfied
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value)
    {
      emit(RegisterCreateUserSuccessState(uId));
    }).catchError((error){
      print('error when create user ${error.toString()}');
      emit(RegisterCreateUserErrorState(error));
    });
  }

}