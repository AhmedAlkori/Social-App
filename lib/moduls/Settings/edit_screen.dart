import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/social_cubit.dart';
import '../../layout/cubit/social_state.dart';
import '../../models/Posts_Model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/styles/icon_broken.dart';
import '../../layout/cubit/social_cubit.dart';




class EditScreen extends StatelessWidget {

   var nameController=TextEditingController();
   var bioController=TextEditingController();
   var phoneController=TextEditingController();
   var formKey=GlobalKey<FormState>();
   //UsersDataModel? model;

   EditScreen(context)
   {
     LayoutCubit.get(context).userImage=null;
     LayoutCubit.get(context).userCover=null;
     nameController.text=LayoutCubit.get(context).usersDataModel!.name!;
     bioController.text=LayoutCubit.get(context).usersDataModel!.bio!;
     phoneController.text=LayoutCubit.get(context).usersDataModel!.phone!;


   }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<LayoutCubit,LayoutState>(
        listener: (context,state)
        {
          if(state is LayoutSettingUpdateUserDataSuccess)
            {
              showMessage(
                  message: 'تم التعديل بنجاح',
                  bgColor: getColor(MessageState.SUCCESS));
            }
        },
        builder: (context,state)
        {
          LayoutCubit cubit=LayoutCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Edit Profile',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              actions:
              [
                Container(
                  child: defaultTextButton(
                      text: 'UPDATE',
                      onClick: ()
                      {
                        if(formKey.currentState!.validate())
                        {
                          cubit.updateUserData(
                              name: nameController.text,
                              bio: bioController.text,
                              phone: phoneController.text);
                        }
                        else
                        {

                        }
                      }),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children:
                      [
                        SizedBox(
                          height: 15.0,
                        ),
                        if(state is LayoutSettingLoadUpdate)
                          LinearProgressIndicator(),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 180.0,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children:
                            [
                              Align(

                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 150.0,
                                      decoration: BoxDecoration(
                                        borderRadius:BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                        image: cubit.userCover != null? DecorationImage(
                                          image: FileImage(File(cubit.userCover)),
                                          //   image: NetworkImage('imgafff'),
                                          fit: BoxFit.cover,
                                        ):DecorationImage(
                                          image:NetworkImage(cubit.usersDataModel!.cover.toString()),
                                          //   image: NetworkImage('imgafff'),

                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                        horizontal: 10.0,
                                      ),
                                      child: CircleAvatar(
                                        radius: 20.0,
                                        child: IconButton(
                                          onPressed: ()
                                          {
                                            cubit.PickCover();
                                          },
                                          icon: Icon(
                                              IconBroken.Camera
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topCenter,
                              ),
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children:
                                [

                                  CircleAvatar(
                                    backgroundColor: Colors.white,

                                    radius: 65.0,
                                    child:cubit.userImage != null ?CircleAvatar(
                                      backgroundImage: FileImage(File(cubit.userImage)) ,

                                      radius: 60.0,

                                    ):CircleAvatar(
                                      backgroundImage:NetworkImage(cubit.usersDataModel!.image.toString()),
                                      radius: 60.0,

                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10.0,
                                      horizontal: 10.0,
                                    ),
                                    child: CircleAvatar(
                                      radius: 18.0,
                                      child: IconButton(
                                        onPressed: ()
                                        {
                                          cubit.PickImage();
                                        },
                                        icon: Icon(
                                          IconBroken.Camera,
                                          size: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        if(cubit.userCover != null || cubit.userImage != null)
                        Row(
                          children:
                          [
                            if(cubit.userImage != null)
                              Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: MaterialButton(
                                        onPressed: ()
                                        {
                                          cubit.updateProfile(
                                              name: nameController.text,
                                              bio: bioController.text,
                                              phone: phoneController.text,
                                              profilePath: cubit.userImage,
                                          );
                                        },
                                      child: Text(
                                        'UPLOAD PROFILE',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  if(state is LayoutLoadingProfileState)
                                    LinearProgressIndicator(),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            if (cubit.userCover != null)
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: MaterialButton(
                                      onPressed: ()
                                      {
                                        cubit.updateCover(
                                            name: nameController.text,
                                            bio: bioController.text,
                                            phone: phoneController.text,
                                            imagePath: cubit.userCover);
                                      },
                                      child: Text(
                                        'UPLOAD COVER',
                                        style: TextStyle(
                                            color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  if(state is LayoutLoadingCoverState)
                                    LinearProgressIndicator(),
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: defaultForm(
                              controler: nameController,
                              title: 'Name',
                              prefix: IconBroken.Add_User,
                              type: TextInputType.text,
                              isPass: false,
                              validate: (value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'name must be not null';
                                }
                                return null;
                              }),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: defaultForm(
                              controler: bioController,
                              title: 'Bio',
                              prefix: IconBroken.Info_Circle,
                              type: TextInputType.text,
                              isPass: false,
                              validate: (value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'Bio must be not null';
                                }
                                return null;
                              }),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          child: defaultForm(
                              controler: phoneController,
                              title: 'Phone',
                              prefix: IconBroken.Call,
                              type: TextInputType.text,
                              isPass: false,
                              validate: (value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'Phone must be not null';
                                }
                                return null;
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          );
        },

      );


  }
}
