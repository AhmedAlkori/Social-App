import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../layout/Social_Layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/end_points.dart';
import '../../shared/service/local/dio_helper.dart';
import '../Register/social_register.dart';
import 'cubit/social_login_cubit.dart';
import 'cubit/social_login_state.dart';




class LoginScreen extends StatelessWidget {

  var emailControl=TextEditingController();
  var passControl=TextEditingController();
  var keyForm=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> SocialCubit(),
      child: BlocConsumer<SocialCubit,SocialState>(
        listener: (context,state)
        {
            if(state is SocialGetDataSuccessState)
              {
                uId=state.uId;
                CashHelper.saveCash(key: 'uId', value: uId);
                nextWidget(context: context, screen: SocialLayout());
              }
            else if(state is SocialGetDataErrorState)
              {
                showMessage(
                    message: state.error.toString(),
                    bgColor: getColor(MessageState.WARNING));
              }
            else
              {

              }
        },
        builder: (context,state)
        {

          SocialCubit cubit=SocialCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child:  Form(
                    key: keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child:  defaultForm(
                              controler: emailControl,
                              title: 'Email Address',
                              prefix: Icons.email_outlined,
                              type: TextInputType.emailAddress,
                              isPass: false,
                              validate: (value)
                              {
                                if(value?.isEmpty== true)
                                {
                                  return 'Email Address must be not empty';
                                }
                                else
                                {
                                  return null;
                                }
                              }
                          ),
                        ),

                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: defaultForm(
                              controler: passControl,
                              title: 'Password',
                              prefix: Icons.lock,
                              type: TextInputType.visiblePassword,
                              isPass: true,
                              isVisibale: cubit.isHide,
                              onPress: ()
                              {
                                cubit.changePass();
                              },
                              validate: (value)
                              {
                                if(value?.isEmpty== true)
                                {
                                  return 'Sorry ! , Password is too short';
                                }
                                else
                                {
                                  return null;
                                }
                              },
                              onSubmit: (value)
                              {
                                if(keyForm.currentState!.validate())
                                {
                                  cubit.MakeLogin(
                                      email: emailControl.text,
                                      password: passControl.text);
                                }
                              }

                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),

                        ConditionalBuilder(
                          condition: state is SocialLoadDataState ,
                          builder:(context)=> Center(child: CircularProgressIndicator()),
                          fallback: (context)=>  Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: MaterialButton(
                              onPressed: ()
                              {

                                if(keyForm.currentState!.validate())
                                {
                                  cubit.MakeLogin(
                                      email: emailControl.text,
                                      password: passControl.text);

                                }
                                else
                                {

                                }
                              },
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                ),

                              ),
                            ),
                          ),
                        ),



                        SizedBox(
                          height: 20.0,
                        ),

                        Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            TextButton(
                              onPressed: ()
                              {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context)=>RegisterScreen()));
                              },
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        ),



                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),
    );
  }
}
