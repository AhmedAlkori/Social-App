import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/social_cubit.dart';
import '../../layout/cubit/social_state.dart';
import '../../models/Posts_Model.dart';
import '../../models/comment_Model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';
import '../../shared/styles/icon_broken.dart';

import '../../shared/styles/icon_broken.dart';

class CommentScreen extends StatelessWidget {

  PostDataModel postModel;
  String post_id;
  int likeCount;
  int commentCount;
  var commentController=TextEditingController();
  CommentScreen(this.postModel,this.post_id,this.likeCount,this.commentCount,context)
  {
    //LayoutCubit.get(context).getAllComment(post_ID: post_id);
  }
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context)
      {
        LayoutCubit.get(context).getAll_Comment(post_ID: post_id);
        return BlocConsumer<LayoutCubit,LayoutState>(
          listener: (context,state)
          {
            if(state is LayoutAddCommentSuccessState)
              {
                LayoutCubit.get(context).changeCommentLength(index: 0);
                commentController.clear();
                FocusManager.instance.primaryFocus?.unfocus();
                showMessage(
                    message: 'تم ارسال التعليق',
                    bgColor: getColor(MessageState.SUCCESS),
                );

              }
          },
          builder: (context,state)
          {

            return  Scaffold(
              appBar: AppBar(
              //  leadingWidth: double.infinity,
                centerTitle: true,
                title: Text(
                  '${postModel.userName}\'s post',
                  textAlign:TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 18.0,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                       Column (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                              [
                                CircleAvatar(
                                  backgroundImage: NetworkImage('${postModel.userImage}'),
                                  radius: 28.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:
                                    [
                                      Row(

                                        children:
                                        [
                                          Text(
                                            '${postModel.userName}',
                                            style: Theme.of(context).textTheme.subtitle1,
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Icon(
                                            Icons.check_circle,
                                            color: Colors.blue,
                                            size: 18.0,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${postModel.dateTime}',
                                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                            fontSize: 14.0,
                                            color: Colors.grey,
                                            height: 1.0
                                        ),

                                      ),
                                    ],
                                  ),
                                ),

                                IconButton(
                                    onPressed: (){},
                                    icon: Icon(
                                      Icons.more_horiz,
                                      size: 18.0,
                                    )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(

                                vertical: 10.0,
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 1.0,
                                color: Colors.grey[300],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children:
                              [
                                Text(
                                  '${postModel.postText}',
                                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                    height: 1.2,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       bottom: 10.0,
                                //       top: 2.0
                                //   ),
                                //   child: Container(
                                //     width: double.infinity,
                                //     child: Wrap(
                                //
                                //       children:
                                //       [
                                //         Padding(
                                //           padding: const EdgeInsets.only(
                                //             right: 10.0,
                                //           ),
                                //           child: Container(
                                //             height: 25.0,
                                //             child: MaterialButton(
                                //               onPressed: (){},
                                //               minWidth: 1.0,
                                //               //    height: 1.0,
                                //               padding: EdgeInsets.zero,
                                //               child:Text(
                                //                 '#software',
                                //                 style: TextStyle(
                                //                   color: Colors.blue,
                                //                   fontWeight: FontWeight.bold,
                                //                   fontSize: 15.0,
                                //                 ),
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //         Padding(
                                //           padding: const EdgeInsets.only(
                                //             right: 10.0,
                                //           ),
                                //           child: Container(
                                //             height: 25.0,
                                //             child: MaterialButton(
                                //               onPressed: (){},
                                //               minWidth: 1.0,
                                //               //    height: 1.0,
                                //               padding: EdgeInsets.zero,
                                //               child:Text(
                                //                 '#flutter',
                                //                 style: TextStyle(
                                //                   color: Colors.blue,
                                //                   fontWeight: FontWeight.bold,
                                //                   fontSize: 15.0,
                                //                 ),
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                if(postModel.postImage.toString() != '')
                                  Container(
                                    width: double.infinity,
                                    height: 300.0,

                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.circular(4.0),
                                        image: DecorationImage(
                                          image:NetworkImage(postModel.postImage.toString()),
                                          fit: BoxFit.cover,
                                        )
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0
                                  ),
                                  child: Row(
                                    children:
                                    [
                                      Expanded(
                                        child: InkWell(
                                          onTap: (){},
                                          child: Row(
                                            children:
                                            [
                                              Icon(
                                                IconBroken.Heart,
                                                color: Colors.red,
                                                size: 18.0,
                                              ),
                                              SizedBox(
                                                width: 5.0,
                                              ),


                                              Text(
                                                '${likeCount.toString()}',
                                                style: Theme.of(context).textTheme.caption?.copyWith(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),

                                            ],
                                          ) ,
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: (){},
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children:
                                            [
                                              Icon(
                                                IconBroken.Chat,
                                                color: Colors.amber,
                                                size: 18.0,
                                              ),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                '${commentCount.toString()} comment',
                                                style: Theme.of(context).textTheme.caption?.copyWith(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          ) ,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(

                                    vertical: 10.0,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 1.0,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                // ListView.separated(
                                //     itemBuilder: itemBuilder,
                                //     separatorBuilder: separatorBuilder,
                                //     itemCount: itemCount)
                                Row(
                                  children:
                                  [
                                    Text(
                                      'ALL COMMENTS',
                                      style: Theme.of(context).textTheme.subtitle1,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Icon(
                                      Icons.arrow_downward_sharp,
                                      size: 16.0,
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                ConditionalBuilder(
                                    condition: LayoutCubit.get(context).commentsList.length > 0,
                                    builder: (context)=> ListView.separated(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context,index)=>commentItem(LayoutCubit.get(context).commentsList[index],context),
                                        separatorBuilder: (context,index)=>SizedBox(
                                          height: 5.0,
                                        ),
                                        itemCount: LayoutCubit.get(context).commentsList.length),
                                    fallback: (context)=>ConditionalBuilder(
                                        condition: state is LayoutGetAllCommentLoadingState,
                                        builder: (context)=>Center(child: CircularProgressIndicator()),
                                        fallback: (context)=>Center(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:
                                            [
                                              Container(

                                                child: Icon(
                                                  Icons.comment_bank,
                                                  size: 80.0,
                                                  color: Colors.grey[500],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                'No comments yet',
                                                style: Theme.of(context).textTheme.subtitle1,
                                              ),
                                              Text(
                                                'Be the first to comment.',
                                                style: Theme.of(context).textTheme.subtitle2,
                                              ),
                                            ],
                                          ),
                                        )),
                                ),


                              ],
                            ),
                          ],
                      ),



                    ],
                  ),
                ),
              ),
              bottomSheet: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 5.0,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadiusDirectional.circular(10.0),


                  ),
                  child: TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'write your comment...',
                      border:InputBorder.none,
                      suffixIcon: IconButton(
                        onPressed: ()
                        {

                          String time=DateTime.now().toString();
                          LayoutCubit.get(context).addComment(
                              postID: post_id,
                              comment: commentController.text,
                              date_Time: time);

                        },
                        icon: LayoutCubit.get(context).length >0 ? Icon(
                          Icons.send_sharp,

                        ):Icon(
                          null,
                        ),
                      ),
                    ),
                    onChanged: (value)
                    {
                      LayoutCubit.get(context).changeCommentLength(
                          index: value.length,
                      );
                    },
                  ),
                ),
              ),


            );
          },

        );
      }
    );
  }

  Widget commentItem(CommentDataModel model,context)=>Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children:
    [
      CircleAvatar(
        backgroundImage: NetworkImage(model.userImage.toString()),
        radius: 20.0,
      ),
      SizedBox(
        width: 10.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 6.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.circular(15.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Text(
                    '${model.userName}',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,

                    ),
                  ),
                  Text(
                    '${model.userComment}',

                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: Colors.black,
                        height: 1.1
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Text(
                '${model.dateTime}',
                style: Theme.of(context).textTheme.caption,
              ),
            ),

          ],
        ),
      ),
    ],
  );

}
