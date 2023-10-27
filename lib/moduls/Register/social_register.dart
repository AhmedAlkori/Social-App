import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';



import '../../layout/Social_Layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/end_points.dart';
import '../../shared/service/local/dio_helper.dart';
import 'cubit/Register_Cubit.dart';
import 'cubit/Register_State.dart';



class RegisterScreen extends StatelessWidget {

  var emailControl=TextEditingController();
  var passControl=TextEditingController();
  var nameControl=TextEditingController();
  var phoneControl=TextEditingController();
  var keyForm=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
        listener: (context,state)
        {
          if(state is RegisterCreateUserSuccessState)
            {
              uId=state.uId;
              CashHelper.saveCash(key: 'uId', value: uId);
              nextWidget(context: context, screen: SocialLayout());
            }
          else if(state is RegisterGetDataErrorState)
            {
              showMessage(
                  message: state.error.toString(),
                  bgColor: getColor(MessageState.ERROR));
            }
        },
        builder: (context,state)
        {

          RegisterCubit cubit=RegisterCubit.get(context);
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
                          'REGISTER',
                          style:Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Register now to communicate with friend ',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        //user name field
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child:  defaultForm(
                              controler: nameControl,
                              title: 'User Name',
                              prefix: Icons.account_circle,
                              type: TextInputType.text,
                              isPass: false,
                              validate: (value)
                              {
                                if(value?.isEmpty== true)
                                {
                                  return 'User Name must be not empty';
                                }
                                else
                                {
                                  return null;
                                }
                              }
                          ),
                        ),
                        //email field
                        SizedBox(
                          height: 10.0,
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
                        //password filed
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

                              }

                          ),
                        ),
                        //phone number field
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child:  defaultForm(
                              controler: phoneControl,
                              title: 'Phone',
                              prefix: Icons.phone,
                              type: TextInputType.phone,
                              isPass: false,
                              validate: (value)
                              {
                                if(value?.isEmpty== true)
                                {
                                  return 'Phone number must be not empty';
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
                                  cubit.MakeRegister(
                                    name: nameControl.text,
                                    email: emailControl.text,
                                    password: passControl.text,
                                    phone: phoneControl.text,
                                  );
                                }
                              }
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),

                        ConditionalBuilder(
                          condition: state is RegisterLoadDataState ,
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

                                  if(keyForm.currentState!.validate())
                                  {
                                    cubit.MakeRegister(
                                      name: nameControl.text,
                                      email: emailControl.text,
                                      password: passControl.text,
                                      phone: phoneControl.text,
                                    );
                                  }

                                }
                                else
                                {

                                }
                              },
                              child: Text(
                                'REGISTER',
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
