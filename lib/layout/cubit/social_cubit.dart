import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_final_app/layout/cubit/social_state.dart';

import '../../models/Chat_Model.dart';
import '../../models/Posts_Model.dart';
import '../../models/comment_Model.dart';
import '../../models/social_model.dart';
import '../../moduls/Chat/chat_screen.dart';
import '../../moduls/Home/home_screen.dart';
import '../../moduls/Posts/post_screen.dart';
import '../../moduls/Settings/setting_screen.dart';
import '../../moduls/Users/users_screen.dart';
import '../../shared/end_points.dart';


class LayoutCubit extends Cubit<LayoutState>
{
  LayoutCubit():super(LayoutInitState());

  static LayoutCubit get(context)=> BlocProvider.of(context);
  XFile? imageFile;
  XFile? postImageFile;
  var postImage;
  var userImage;
  XFile? coverFile;
  var userCover;

  XFile? chatImageFile;
  var chatImage;
  var helperChatImage;

  List<PostDataModel> allPost=[];
  List<String> posts_id=[];
  List<int> postLikeCount=[];
  List<int> postCommentCount=[];

  int length=0;
  void changeCommentLength({
  required int index,
})
  {
    length=index;
    emit(LayoutWriteCommentChange());
  }

  List<Widget> screens=
  [
    HomeScreen(),
    ChatScreen(),
    PostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles=
  [
    'Home',
    'Chats',
    'Create Post',
    'Users',
    'Settings'
  ];

   int currentIndex=0;
   void changeBottomNav({
  required int index,
})
   {
     if(index == 2)
       {

         emit(LayoutOpenPostState());
       }
     else
     {
       currentIndex = index;
       emit(LayoutChangeBottomNavState());
     }
   }


 UsersDataModel? usersDataModel;

  void getUserData()
  {
    emit(LayoutLoatUserData());
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value){
          print(value.data());
      usersDataModel=UsersDataModel.fromJson(value.data()!);
      emit(LayoutGetUserData());

    }).catchError((error){
     print('error when get user data ${error.toString()}');
     emit(LayoutErrorUserData());
    });
  }


  Future<void> PickPostImage() async
  {

    postImageFile= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(postImageFile != null)
    {
      postImage=postImageFile!.path.toString();
      emit(LayoutPickImagePostSuccessState());
    }
    else
    {
      print('no image chosed');
      emit(LayoutPickImagePostErrorState());
    }
  }

  Future<void> PickChatImage() async
  {

    chatImageFile= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(chatImageFile != null)
    {
      chatImage=chatImageFile!.path.toString();
      helperChatImage=chatImage;
      emit(LayoutPickImageChatSuccessState());
    }
    else
    {
      print('no image chosed');
      emit(LayoutPickImageChatErrorState());
    }
  }
  void closePostImage()
  {
    postImage=null;
    emit(LayoutClosePostImage());
  }
  void closeChatImage()
  {
    chatImage=null;
    helperChatImage=null;
    emit(LayoutCloseChatImage());
  }


  Future<void> PickImage() async
  {

    imageFile= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(imageFile != null)
    {
      userImage=imageFile!.path.toString();
      emit(LayoutSettingUpdateImageSuccess());
    }
    else
    {
      print('no image chosed');
      emit(LayoutSettingUpdateImageError());
    }
  }
  Future<void> PickCover() async
  {

    coverFile= await ImagePicker().pickImage(source: ImageSource.gallery);
    if(coverFile != null)
    {
      userCover=coverFile!.path.toString();
      emit(LayoutSettingUpdateCoverSuccess());
    }
    else
    {
      print('no cover chosed');
      emit(LayoutSettingUpdateCoverError());
    }
  }

  void uploadImages()
  {
    if(userCover !=null)
      {
        FirebaseStorage.instance
            .ref('Users/Images')
            .child('Covers/${userCover.toString().split('/').last}')
            .putFile(File(userCover))
            .then((value)
        {
          print('cover save success');
          value.ref.getDownloadURL().then((value)
          {
            print('image url :');
            print(value);
          }).catchError((error)
          {
            print('error when get image url ${error.toString()}');
          });
        }).catchError((error)
        {
          print('error when save cover ${error.toString()}');
        });

      }

  }

  Future<void> updateCover({
  required String name,
    required String bio,
    required String phone,
    required String imagePath,
}) async
  {
    if (imagePath != null)
      {
        emit(LayoutLoadingCoverState());
        FirebaseStorage.instance
            .ref('Users/Images/Covers')
            .child(imagePath.split('/').last)
            .putFile(File(imagePath))
            .then((value)
        {
          value.ref.getDownloadURL().then((value)
          {
            emit(LayoutSuccessSaveCoverState());
            updateUserData(
                name: name,
                bio: bio,
                phone: phone,
              cover: value,
            );
          }).catchError((error)
          {
            print('error when update cover ${error.toString()}');
          });
        }).catchError((error)
        {
            print('error when save cover ${error.toString()}');
        });
      }
  }

  Future<void> updateProfile({
    required String name,
    required String bio,
    required String phone,
    required String profilePath,
  }) async
  {
    if (profilePath != null)
    {
      emit(LayoutLoadingProfileState());
      FirebaseStorage.instance
          .ref('Users/Images/Profiles')
          .child(profilePath.split('/').last)
          .putFile(File(profilePath))
          .then((value)
      {
        value.ref.getDownloadURL().then((value)
        {
          emit(LayoutSuccessSaveProfileState());
          updateUserData(
            name: name,
            bio: bio,
            phone: phone,
            image: value,
          );
        }).catchError((error)
        {
          print('error when update profile ${error.toString()}');
        });
      }).catchError((error)
      {
        print('error when save profile ${error.toString()}');
      });
    }
  }

  Future<void> updateUserData({
  required String name,
    required String bio,
    required String phone,
    String? image,
    String? cover,

}) async
  {

     UsersDataModel userModel=UsersDataModel(
         name: name,
         email: usersDataModel?.email,
         password: usersDataModel?.password,
         phone: phone,
         image:image??usersDataModel?.image,
         bio: bio,
         cover:cover??usersDataModel?.cover,
         isEmailVerfied: false,
         uId: uId);
     emit(LayoutSettingLoadUpdate());
     FirebaseFirestore.instance
         .collection('users')
         .doc(uId)
         .update(userModel.toMap())
         .then((value)
     {
       print('update done success');
       getUserData();
       emit(LayoutSettingUpdateUserDataSuccess());
     }).catchError((error){
       print('error when update data ${error.toString()}');
       emit(LayoutSettingUpdateUserDataError());
     });
  }

  void uploadPostImage({
  required String text,
    required String date,
})
  {
    if(postImage != null)
      {
        emit(LayoutUploadPostImageLoading());
        FirebaseStorage
            .instance
            .ref('Posts/PostImages')
            .child('${postImage.toString().split('/').last}')
            .putFile(File(postImage))
            .then((value)
        {
          print('upload post image success');

          value.ref.getDownloadURL().then((value)
          {
            print(value);
           createPost(
               text: text,
               pos_Image: value,
               dateTime: date,
           );
          }).catchError((error)
          {
           print('error when get image post url ${error.toString()}');
          });
        }).catchError((error)
        {
         print('error when upload image post ${error.toString()}');
        });
      }
    else
      {

      }
  }


  PostDataModel? postDataModel;

  Future<void> createPost({
  required String text,
    required String dateTime,
    String? pos_Image,
})async
  {
    emit(LayoutCreatePostLoading());
    PostDataModel postModel=PostDataModel(
        name: usersDataModel!.name.toString(),
        uerId: uId.toString(),
        image: usersDataModel!.image.toString(),
        posImage: pos_Image??'',
        text: text,
        time: dateTime);
       print(pos_Image);
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value)
    {
      print('Post Create Successfully');
      emit(LayoutCreatePostSuccess());
      getAllPost();
    }).catchError((error)
    {
      print('error when create post');
      emit(LayoutCreatePostError());
    });

  }

  Map<String,bool> isLiked={};
  void getAllPost()
  {

     emit(LayoutGetAllPostLoading());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .get()
        .then((value)
    {
      allPost.clear();
      posts_id.clear();
      postLikeCount.clear();
      postCommentCount.clear();

      value.docs.forEach((element)
      {

        element.reference
            .collection('likes')
            .get()
            .then((like_value)
        {

          element.reference
              .collection('Comments')
              .get()
              .then((value)
          {
            postCommentCount.add(value.docs.length);
            posts_id.add(element.id);
            postLikeCount.add(like_value.docs.length);
            allPost.add(PostDataModel.fromJson(element.data()));
            emit(LayoutGetAllPostSuccess());
          }).catchError((error)
          {
            print('error when get comments count ${error.toString()}');
          });

        }).catchError((error)
        {

        });



      });
      print('all post get success');

      emit(LayoutGetAllPostSuccess());
    }).catchError((error)
    {
     print('error when get all posts ${error.toString()}');
     emit(LayoutGetAllPostError());
    });
  }



  // void getAll_Post()
  // {
  //
  //   emit(LayoutGetAllPostLoading());
  //   FirebaseFirestore.instance
  //       .collection('posts').orderBy('dateTime')
  //       .snapshots().listen((event)
  //   {
  //     print('-=-=-=-ad-sa=-d=a-sd');
  //     allPost.clear();
  //     posts_id.clear();
  //     postLikeCount.clear();
  //     postCommentCount.clear();
  //
  //     event.docs.forEach((element)
  //     {
  //       posts_id.add(element.id);
  //
  //       allPost.add(PostDataModel.fromJson(element.data()));
  //       element.reference.collection('likes').snapshots().listen((like_value)
  //       {
  //        // postLikeCount.clear();
  //         postLikeCount.add(like_value.docs.length);
  //         print(like_value.docs.length);
  //         print('post: ${element.id}');
  //         print('likes listen');
  //         emit(LayoutListenFromLike());
  //
  //       });
  //       element.reference.collection('Comments').snapshots().listen((value)
  //       {
  //
  //         postCommentCount.add(value.docs.length);
  //
  //        emit(LayoutListenFromComment());
  //       });
  //       emit(LayoutListenFromPost());
  //     });
  //   emit(LayoutGetAllPostSuccess());
  //   });
  //
  // }

  void makeLike({
  required String postID,
})
  {

   FirebaseFirestore.instance
       .collection('posts')
       .doc(postID)
       .collection('likes')
       .doc(usersDataModel!.uId.toString())
       .set({
     'is_like':true
   })
       .then((value)
   {
     print('like done success ');
     emit(LayoutMakeLikeSuccess());
   }).catchError((error)
   {
     print('error when make like ${error.toString()}');
     emit(LayoutMakeLikeError());
   });
  }

  void addComment({
  required String postID,
    required String comment,
    required String date_Time,
})
  {
    CommentDataModel commentDataModel=CommentDataModel(
        u_image:usersDataModel!.image.toString(),
        u_name:usersDataModel!.name.toString(),
        u_comment: comment,
        time: date_Time,
        uId: usersDataModel!.uId.toString(),
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postID)
        .collection('Comments')
        .add(commentDataModel.toMap())
        .then((value)
    {

        emit(LayoutAddCommentSuccessState());
    //    getAllComment(post_ID: postID);
    })
        .catchError((error)
    {
      print('error when add comment ${error.toString()}');
      emit(LayoutAddCommentErrorState());

    });
  }

  List<CommentDataModel> commentsList=[];
//   void getAllComment({
//   required String post_ID,
// })
//   {
//     commentsList.clear();
//     emit(LayoutGetAllCommentLoadingState());
//     FirebaseFirestore.instance
//         .collection('posts')
//         .doc(post_ID)
//         .collection('Comments')
//         .get()
//         .then((value)
//     {
//
//        value.docs.forEach((element)
//        {
//          commentsList.add(CommentDataModel.fromJson(element.data()));
//        });
//
//        emit(LayoutGetAllCommentSuccessState());
//     }).catchError((error)
//     {
//       print('error when get post comments ${error.toString()}');
//       emit(LayoutGetAllPostError());
//     });
//   }

  //ffff
  //<CommentDataModel> commentsList=[];
  void getAll_Comment({
    required String post_ID,
  })
  {

    emit(LayoutGetAllCommentLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(post_ID)
        .collection('Comments').snapshots().listen((event)
    {
      commentsList.clear();
      event.docs.forEach((element)
      {
        commentsList.add(CommentDataModel.fromJson(element.data()));
      });

      emit(LayoutGetAllCommentSuccessState());
    });

  }

  List<UsersDataModel> allUsers=[];

  void getAllUsers()
  {
    allUsers.clear();
    emit(LayoutGetAllUsersLoadState());
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value)
    {
      value.docs.forEach((element)
      {
        if(element.id != uId)
        allUsers.add(UsersDataModel.fromJson(element.data()));
      });
      emit(LayoutGetAllUsersSuccessState());
    }).catchError((error)
    {
      print('error when get all users ${error.toString()}');
      emit(LayoutGetAllUsersErrorState());
    });
  }
          bool isImageLoading=false;
  void uploadChatImage({
    required String reciver,
    required String msg,
    required String dateTime,
  })
  {
    if(helperChatImage != null)
    {
      emit(LayoutUploadChatImageLoading());
      FirebaseStorage
          .instance
          .ref('Media/ChatImages')
          .child('${helperChatImage.toString().split('/').last}')
          .putFile(File(helperChatImage))
          .then((value)
      {
        print('upload chat image success');

        value.ref.getDownloadURL().then((value)
        {
          closeChatImage();
          print(value);
          sendMessage(
              reciver: reciver,
              msg: msg,
              dateTime: dateTime,
            image: value,
          );

        }).catchError((error)
        {
          print('error when get image chat url ${error.toString()}');
        });
      }).catchError((error)
      {
        print('error when upload image chat ${error.toString()}');
      });
    }
    else
    {

    }
  }

  void sendMessage({
    required String reciver,
  required String msg,
    required String dateTime,
    String? image,
})
  {
    ChatModel chatModel=ChatModel(
        sender: usersDataModel!.uId.toString(),
        reciver: reciver,
        msg: msg,
        Time: dateTime,
        pic:image??'',
    );
   FirebaseFirestore.instance
       .collection('users')
       .doc(usersDataModel!.uId)
       .collection('chats')
       .doc(reciver)
       .collection('messages')
       .add(chatModel.toMap())
       .then((value)
       {
         print('send message success ');
         emit(LayoutSendMessageSuccess());
       }).catchError((error)
   {
     print('error when send message ${error.toString()}');
     emit(LayoutSendMessageError());
   });

    FirebaseFirestore.instance
        .collection('users')
        .doc(reciver)
        .collection('chats')
        .doc(usersDataModel!.uId)
        .collection('messages')
        .add(chatModel.toMap())
        .then((value)
    {
      print('send message success ');
      emit(LayoutSendMessageSuccess());
    }).catchError((error)
    {
      print('error when send message ${error.toString()}');
      emit(LayoutSendMessageError());
    });

  }

  List<ChatModel> allMessage=[];
  void getMessages({
  required String reciverId,
})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(usersDataModel!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      allMessage.clear();
      event.docs.forEach((element)
      {
        allMessage.add(ChatModel.fromJson(element.data()));
      });
      emit(LayoutGetAllMessageState());
    });
  }


}