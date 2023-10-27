import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_final_app/moduls/Chat/user_chat_Screen.dart';

import '../../layout/cubit/social_cubit.dart';
import '../../layout/cubit/social_state.dart';
import '../../models/social_model.dart';


class ChatScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
      listener: (context,state){},
      builder: (context,state)
      {
        LayoutCubit cubit=LayoutCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ConditionalBuilder(
              condition: cubit.allUsers.length>0,
              builder: (context)=> ListView.separated(
                  itemBuilder: (context,index)=>allUsersItem(cubit.allUsers[index],context),
                  physics: BouncingScrollPhysics(),

                  separatorBuilder: (context,index)=>Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                  ),
                  itemCount: cubit.allUsers.length),
              fallback: (context)=>Center(child: CircularProgressIndicator())),
        );
      },

    );
  }

  Widget allUsersItem(UsersDataModel model,context)=>InkWell(
    onTap: ()
    {
      LayoutCubit.get(context).allMessage.clear();
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=>UserChatScreen(model)));
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children:
      [
        CircleAvatar(
          backgroundImage: NetworkImage('${model.image}'),
          radius: 28.0,
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Text(
            '${model.name}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ],
    ),
  );
}
