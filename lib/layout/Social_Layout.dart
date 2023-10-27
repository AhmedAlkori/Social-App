import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../moduls/Feeds/Feeds_Screen.dart';
import '../moduls/Posts/post_screen.dart';
import '../shared/styles/icon_broken.dart';
import 'cubit/social_cubit.dart';
import 'cubit/social_state.dart';

class SocialLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<LayoutCubit,LayoutState>(
        listener: (context,state)
        {
          if(state is LayoutOpenPostState)
            {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context)=>PostScreen()
                  )
              );
            }
        },
        builder: (context,state)
        {
          LayoutCubit cubit=LayoutCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              title: Text(
                '${cubit.titles[cubit.currentIndex]}'
              ),
              actions:
              [
               IconButton(
                   onPressed: (){},
                   icon: Icon(
                     IconBroken.Notification,
                   ),

               ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(
                    IconBroken.Search,
                  ),

                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
                cubit.changeBottomNav(index: index);
              },
              items:
              [
                BottomNavigationBarItem(
                  label: 'Home',
                    icon: Icon(
                      IconBroken.Home,
                    ),
                ),
                BottomNavigationBarItem(
                  label: 'Chats',
                  icon: Icon(
                    IconBroken.Chat,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Post',
                  icon: Icon(
                    IconBroken.Paper_Upload,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Users',
                  icon: Icon(
                    IconBroken.User,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Settings',
                  icon: Icon(
                    IconBroken.Setting,
                  ),
                ),
              ],
            ),
          );
        },

    );
  }
}
