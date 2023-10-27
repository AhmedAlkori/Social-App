import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/social_cubit.dart';
import '../../layout/cubit/social_state.dart';
import '../../models/Posts_Model.dart';
import '../../shared/styles/icon_broken.dart';
import 'comment_screen.dart';


class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context)
      {
        LayoutCubit.get(context).getAllPost();
        return BlocConsumer<LayoutCubit,LayoutState>(
          listener: (context,state)
          {

          },
          builder: (context,state)
          {
            LayoutCubit cubit=LayoutCubit.get(context);
            return ConditionalBuilder(
                condition: LayoutCubit.get(context).allPost.length >0 && LayoutCubit.get(context).usersDataModel !=null,
                builder: (context)=> SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children:
                    [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0
                        ),
                        elevation: 20.0,
                        child: Stack(

                          alignment: AlignmentDirectional.bottomEnd,
                          children:
                          [
                            Image(
                              image: AssetImage('assets/images/logo.jpg'),
                              fit: BoxFit.cover,

                              height: 250.0,
                              width: double.infinity,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                  'communicate with friend',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index)=>tweetItem(cubit.allPost[index],context,index),
                          separatorBuilder: (context,index)=>SizedBox(
                            height: 8.0,
                          ),
                          itemCount: cubit.allPost.length),

                    ],
                  ),
                ),
                fallback: (context)=> Center(child: CircularProgressIndicator()));
          },

        );
      }
    );
  }

  Widget tweetItem(PostDataModel model,context,index)=>  Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    margin: EdgeInsets.symmetric(
        horizontal: 10.0

    ),
    elevation: 10.0,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              CircleAvatar(
                backgroundImage: NetworkImage('${model.userImage}'),
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
                          '${model.userName}',
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
                      '${model.dateTime}',
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
                '${model.postText}',
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
              if(model.postImage.toString() != '')
              Container(
                width: double.infinity,
                height: 140.0,

                decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(4.0),
                    image: DecorationImage(
                      image:NetworkImage(model.postImage.toString()),
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
                                '${LayoutCubit.get(context).postLikeCount[index]}',
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
                              '${LayoutCubit.get(context).postCommentCount[index]} comment',
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
              Row(
                children:
                [
                  Expanded(
                    child: InkWell(
                      onTap: ()
                      {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context)=>CommentScreen(
                                    model,
                                    LayoutCubit.get(context).posts_id[index],
                                    LayoutCubit.get(context).postLikeCount[index],
                                    LayoutCubit.get(context).postCommentCount[index],
                                  context,
                                )
                            )
                        );
                      },
                      child:  Row(
                        children:
                        [
                          CircleAvatar(
                            backgroundImage: NetworkImage(LayoutCubit.get(context).usersDataModel!.image.toString()) ,
                            radius: 20.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'write a comment ...',
                            style: Theme.of(context).textTheme.caption?.copyWith(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: ()
                    {
                      LayoutCubit.get(context).makeLike(
                          postID:LayoutCubit.get(context).posts_id[index],
                      );
                    },
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
                          'Like',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),

            ],
          ),

        ],
      ),
    ),
  );
}
