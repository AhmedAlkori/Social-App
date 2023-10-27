


import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';


import '../../layout/cubit/social_cubit.dart';
import '../../layout/cubit/social_state.dart';
import '../../models/Chat_Model.dart';
import '../../models/social_model.dart';
import '../../shared/end_points.dart';
import '../../shared/service/local/dio_helper.dart';
import '../../shared/styles/icon_broken.dart';

class UserChatScreen extends StatelessWidget {

  UsersDataModel model;

  UserChatScreen(this.model);

  var messageController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context)
      {
        LayoutCubit.get(context).getMessages(
            reciverId: model.uId.toString(),
        );
        return BlocConsumer<LayoutCubit,LayoutState>(
          listener: (context,state)
          {
            if (state is LayoutUploadChatImageLoading)
              {
                LayoutCubit.get(context).isImageLoading=true;
              }
            else
              {
                LayoutCubit.get(context).isImageLoading=false;
              }
          },
          builder: (context,state)
          {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(

                  children:
                  [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${model.image}'),
                      radius: 20.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '${model.name}',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              body:  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 20.0,
                      right: 20.0,
                      bottom: 50.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children:
                      [
                         ConditionalBuilder(
                              condition: LayoutCubit.get(context).allMessage.length>0,
                              builder: (context)=> Expanded(
                                child: ListView.separated(
                                    itemBuilder: (context,index)
                                    {
                                       var message=LayoutCubit.get(context).allMessage[index];
                                        if(message.senderId == LayoutCubit.get(context).usersDataModel!.uId)
                                          return myMessageItem(message, context);
                                       return MessageItem(message, context);
                                    },
                                    separatorBuilder: (context,index)=>SizedBox(
                                      height: 10.0,
                                    ),
                                   itemCount:LayoutCubit.get(context).allMessage.length
                                ),
                              ),
                              fallback: (context)=>Center(child: CircularProgressIndicator())),






                      ],
                    ),
                  ),

              
              bottomSheet:  Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    if(LayoutCubit.get(context).chatImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150.0,
                          decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(4.0),
                              image: DecorationImage(
                                image: FileImage(File(LayoutCubit.get(context).chatImage)),
                                fit: BoxFit.cover,
                                  colorFilter: LayoutCubit.get(context).isImageLoading ? ColorFilter.linearToSrgbGamma():null,
                              )
                          ),
                        ),
                        if(state is LayoutUploadChatImageLoading)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 5.0,
                            ),
                            child: LinearProgressIndicator(),
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
                               // cubit.closePostImage();
                                LayoutCubit.get(context).closeChatImage();
                              },
                              icon: Icon(
                                Icons.close,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if(LayoutCubit.get(context).chatImage != null)
                      SizedBox(
                        height: 5.0,
                      ),
                    Container(
                      padding: EdgeInsetsDirectional.only(
                        start: 5.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadiusDirectional.circular(10.0),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(

                        children:
                        [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'type your message here',
                                suffixIcon: IconButton(
                                  onPressed: ()
                                  {
                                    LayoutCubit.get(context).PickChatImage();
                                  },
                                  icon: Icon(
                                    Icons.link
                                  ),
                                ),

                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            color: Colors.lightBlue,
                            child: MaterialButton(
                              onPressed: ()
                              {
                                String dateTime=DateTime.now().toString();
                               //  print(dateTime);
                               // var kk= processTime(dateTime: dateTime);
                               // print(kk);

                                if(LayoutCubit.get(context).chatImage != null)
                                  {
                                    LayoutCubit.get(context).uploadChatImage(
                                        reciver: model.uId.toString(),
                                        msg: messageController.text,
                                        dateTime: dateTime,
                                    );
                                    messageController.clear();
                                  }
                                else
                                  {
                                    LayoutCubit.get(context).sendMessage(
                                        reciver: model.uId.toString(),
                                        msg:messageController.text ,
                                        dateTime: dateTime);
                                    messageController.clear();
                                  }

                                // LayoutCubit.get(context).sendMessage(
                                //     reciver: model.uId.toString(),
                                //     msg:messageController.text ,
                                //     dateTime: dateTime);
                                // messageController.clear();

                              },
                              minWidth: 1.0,
                              child: Icon(
                                IconBroken.Send,
                                size: 16.0,
                                color: Colors.white,

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },

        );
      }
    );
  }

  Widget myMessageItem(ChatModel model,context)
  {
    var time=processTime(dateTime: model.dateTime.toString());
    // var date=time.split(' ').last;
    // bool res=isLastDate(data: date);
    return Column(
      children:
      [
        // if(res == true)
        //   Container(
        //     child: Text(
        //       '${date}',
        //       style: Theme.of(context).textTheme.subtitle2,
        //     ),
        //   ),
         Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(

                padding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(.3,),
                  borderRadius:BorderRadiusDirectional.only(
                    topStart: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0),
                    bottomStart: Radius.circular(10.0),

                  ),

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(model.img.toString() != '')
                    Image(
                      image: NetworkImage('${model.img.toString()}'),
                      width: 300,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    if(model.img.toString() != '')
                    SizedBox(
                      height: 5.0,
                    ),
                    if(model.message != null)
                    Text(
                      '${model.message}',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ),

            Text(
              '${time.split(' ').first}',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.caption?.copyWith(
                fontSize: 10.0,
              ),
            ),
          ],
        ),
      ],
    );
  }



  Widget MessageItem(ChatModel model,context)
  {

    var time=processTime(dateTime: model.dateTime.toString());
    // var date=time.split(' ').last;
    // bool res=isLastDate(data: date);

   return  Column(

     children: [
       // if(res == true)
       //   Container(
       //   child: Text(
       //     '${date}',
       //     style: Theme.of(context).textTheme.subtitle2,
       //   ),
       // ),
       Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(

                padding: EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 10.0
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius:BorderRadiusDirectional.only(
                    topStart: Radius.circular(10.0),
                    topEnd: Radius.circular(10.0),
                    bottomEnd: Radius.circular(10.0),

                  ),

                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(model.img.toString() != '')
                      Image(
                        image: NetworkImage('${model.img.toString()}'),
                        width: 300,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    if(model.img.toString() != '')
                      SizedBox(
                        height: 5.0,
                      ),
                    if(model.message != null)
                      Text(
                        '${model.message}',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                  ],
                ),
              ),
            ),
            Text(
              '${time.split(' ').first}',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.caption?.copyWith(
                fontSize: 10.0,
              ),
            ),
          ],
        ),
     ],
   );
  }
  String processTime({
  required String dateTime,
})
  {
    // convert time from string to DateTime
    var toDateFormat=DateFormat.yMMMd().format(DateTime.parse(dateTime)).toString();
    var dateOnly=toDateFormat.split(',').first;
    var getTime=dateTime.split(' ').last;
   // var helperIndex=getTime.lastIndexOf(':');
    var finalTime=getTime.substring(0,getTime.lastIndexOf(':'));

    String returnTime='${finalTime} ${dateOnly}';
    return returnTime;
  }

  bool isLastDate({
  required String data,
})
  {

    if( lastDate != null )
      {
        if (data != lastDate)
          {
            return true;
          }
        else
          {
            return false;
          }
      }
    else
      {
        CashHelper.saveCash(key: 'isLastDate', value: data);
        lastDate=CashHelper.getCash(key: 'isLastDate');
        return true;
      }
   // if(ls == null)
   // {
   //   CashHelper.saveCash(key: 'isLastDate', value: data);
   //
   // }
   //
   // return false;
  }
}
