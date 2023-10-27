import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_final_app/shared/components/components.dart';
import 'package:social_final_app/shared/components/constant.dart';
import 'package:social_final_app/shared/end_points.dart';
import 'package:social_final_app/shared/service/local/dio_helper.dart';
import 'package:social_final_app/shared/styles/thems.dart';

import 'bloc_observer/Bloc_Observer.dart';
import 'layout/Social_Layout.dart';
import 'layout/cubit/social_cubit.dart';
import 'moduls/Login/social_login.dart';

// background FCM function
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print('Message from background ${message.data.toString()}');
  showMessage(
      message: 'On Background Message',
      bgColor: getColor(MessageState.SUCCESS)
  );

}

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CashHelper.initPreference();
  Bloc.observer=MyBlocObserver();
  uId=CashHelper.getCash(key: 'uId');
  //lastDate= CashHelper.getCash(key: 'isLastDate');

  //take user token from FCM
  var token =await FirebaseMessaging.instance.getToken();
  print(token.toString());
  print('user token ${token.toString()}');

  // FCM when app is open
  FirebaseMessaging.onMessage.listen((event)
  {
    print(event.toString());
    showMessage(
        message: 'On Message',
        bgColor: getColor(MessageState.SUCCESS)
    );
  });

  //FCM when app is open in RAM (background )
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print(event.data.toString());
    showMessage(
        message: 'On Message Opend app',
        bgColor: getColor(MessageState.SUCCESS)
    );
  });

  //handling background message
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);


  Widget? widget;
  if(uId != null)
  {
    widget =SocialLayout();
  }
  else
  {
    widget=LoginScreen();
  }

  runApp( MyApp(widget));
}
class MyApp extends StatelessWidget
{
  Widget? screen;
  MyApp(this.screen);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(
          create: (context)=>LayoutCubit()..getUserData()..getAllUsers(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: lightThem,
        darkTheme: darkThem,
        themeMode: ThemeMode.light,
        home: screen,
      ),
    );
  }

}