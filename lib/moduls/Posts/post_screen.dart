import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/social_cubit.dart';
import '../../layout/cubit/social_state.dart';
import '../../models/Posts_Model.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';

class PostScreen extends StatelessWidget {

  var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
      listener: (context,state)
      {
        if (state is LayoutCreatePostLoading)
          textController.clear();
        if(state is LayoutCreatePostSuccess)
          {
            Navigator.pop(context);
          }
        else
          {

          }
      },
      builder: (context,state)
      {

        LayoutCubit cubit=LayoutCubit.get(context);
        return  Scaffold(
          appBar: AppBar(
            title: Text(
              'Create Post',
            ),

            actions:
            [


              defaultTextButton(
                  text: 'POST',
                  onClick: ()
                  {
                    var time=DateTime.now();
                    print(time.toString());
                    if(cubit.postImage != null)
                      {
                        cubit.uploadPostImage(
                            text: textController.text,
                            date: time.toString(),
                        );
                      }
                    else
                      {
                        cubit.createPost(
                            text: textController.text,
                            dateTime: time.toString(),
                        );
                      }
                  }),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                if(state is LayoutCreatePostLoading || state is LayoutUploadPostImageLoading)
                  LinearProgressIndicator(),
                if(state is LayoutCreatePostLoading || state is LayoutUploadPostImageLoading)
                  SizedBox(
                    height: 5.0,
                  ),
                Row(
                  children:
                  [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${cubit.usersDataModel?.image}') ,
                      radius: 28.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        '${cubit.usersDataModel?.name}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    maxLines: null,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'What is in your mind...',

                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
               if(cubit.postImage != null)
               Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image: FileImage(File(cubit.postImage)),
                            fit: BoxFit.cover,
                          )
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
                             cubit.closePostImage();
                            },
                            icon: Icon(
                                Icons.close,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                Row(
                  children:
                  [
                    Expanded(
                      child: TextButton(
                        onPressed: ()
                        {
                            cubit.PickPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Icon(
                              IconBroken.Image,
                              size: 18.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'add photo',
                              style: TextStyle(

                                fontWeight: FontWeight.bold,


                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: defaultTextButton(
                          text: '# tags',
                          font_size: 16.0,
                          onClick: (){}),
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
