
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../layout/cubit/social_cubit.dart';
import '../../layout/cubit/social_state.dart';
import '../../shared/styles/icon_broken.dart';
import 'edit_screen.dart';

class SettingsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
      listener: (context,state){},
      builder: (context,state)
      {
        var model=LayoutCubit.get(context).usersDataModel;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:
            [
              Container(
                height: 180.0,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children:
                  [
                    Align(

                      child: Container(
                        width: double.infinity,
                        height: 150.0,
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(model!.cover.toString()),
                              fit: BoxFit.cover,
                            )
                        ),
                      ),
                      alignment: Alignment.topCenter,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 65.0,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(model.image.toString()) ,
                        radius: 60.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Column(
                children:
                [
                  Text(
                    '${model.name}',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: 24.0,
                    ),
                  ),
                  Text(
                    '${model.bio}',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                        fontSize: 14.0
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                ),
                child: Row(
                  children:
                  [
                    Expanded(
                      child: InkWell(
                        child: Column (
                          children:
                          [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column (
                          children:
                          [
                            Text(
                              '265',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column (
                          children:
                          [
                            Text(
                              '10k',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column (
                          children:
                          [
                            Text(
                              '64',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.caption?.copyWith(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children:
                [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: (){},
                        child: Text(
                          'Add Photos',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  OutlinedButton(
                    onPressed: ()
                    {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder:(context)=>EditScreen(context)));
                    },
                    child: Icon(
                      IconBroken.Edit,
                      size: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children:
                [
                  OutlinedButton(
                      onPressed: ()
                      {
                        FirebaseMessaging.instance.subscribeToTopic('AhmedTopic');
                      },
                      child: Text
                        (
                        'Subscribe',
                      )
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  OutlinedButton(
                      onPressed: ()
                      {
                        FirebaseMessaging.instance.subscribeToTopic('AhmedTopic');
                      },
                      child: Text
                        (
                        'UnSubscribe',
                      )
                  ),
                ],
              ),

            ],
          ),
        );
      },

    );
  }
}
