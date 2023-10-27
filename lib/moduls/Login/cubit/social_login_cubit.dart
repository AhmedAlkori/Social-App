import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_final_app/moduls/Login/cubit/social_login_state.dart';




class SocialCubit extends Cubit<SocialState>
{
  SocialCubit() :super(SocialInitState());

  static SocialCubit get(context)=>BlocProvider.of(context);

  var pageContoroller=PageController();
  bool isLast=false;
  bool isOnBoardingSkipped=false;
  bool isHide=true;

  bool isLogin=false;




  void changePass()
  {
    isHide =!isHide;
    emit(SocialChangePassState());
  }



  void MakeLogin({
    required String email,
    required String password,
  })
  {
    emit(SocialLoadDataState());
    FirebaseAuth
        .instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          print(value.user?.uid);
         emit(SocialGetDataSuccessState(value.user?.uid));
    }).catchError((error){
      print('error when sign in with email ${error.toString()}');
      emit(SocialGetDataErrorState(error));
    });
  }



}