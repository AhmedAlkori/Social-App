
abstract class LayoutState {}

class LayoutInitState extends LayoutState{}

class LayoutGetUserData extends LayoutState{}
class LayoutLoatUserData extends LayoutState{}
class LayoutErrorUserData extends LayoutState{}

class LayoutChangeBottomNavState extends LayoutState{}
class LayoutOpenPostState extends LayoutState{}


class LayoutUpdateSettingLoad extends LayoutState{}
class LayoutSettingUpdateImageSuccess extends LayoutState{}
class LayoutSettingUpdateImageError extends LayoutState{}

class LayoutSettingUpdateCoverSuccess extends LayoutState{}
class LayoutSettingUpdateCoverError extends LayoutState{}

class LayoutSettingLoadUpdate extends LayoutState{}
class LayoutSettingUpdateUserDataSuccess extends LayoutState{}
class LayoutSettingUpdateUserDataError extends LayoutState{}

class LayoutLoadingCoverState extends LayoutState{}
class LayoutSuccessSaveCoverState extends LayoutState{}

class LayoutLoadingProfileState extends LayoutState{}
class LayoutSuccessSaveProfileState extends LayoutState{}

class LayoutPickImagePostSuccessState extends LayoutState{}
class LayoutPickImagePostErrorState extends LayoutState{}
class LayoutClosePostImage extends LayoutState{}

// Post State==>
class LayoutUploadPostImageLoading extends LayoutState{}
class LayoutCreatePostLoading extends LayoutState{}
class LayoutCreatePostSuccess extends LayoutState{}
class LayoutCreatePostError extends LayoutState{}


// get post state
class LayoutGetAllPostLoading extends LayoutState{}
class LayoutGetAllPostSuccess extends LayoutState{}
class LayoutGetAllPostError extends LayoutState{}

// likes states==>>
class LayoutMakeLikeSuccess extends LayoutState{}
class LayoutMakeLikeError extends LayoutState{}
class LayoutGetPostCountSuccess extends LayoutState{}
class LayoutGetPostCountError extends LayoutState{}

class LayoutWriteCommentChange extends LayoutState{}

// comments state==>>
class LayoutAddCommentSuccessState extends LayoutState{}
class LayoutAddCommentErrorState extends LayoutState{}

class LayoutGetAllCommentLoadingState extends LayoutState{}
class LayoutGetAllCommentSuccessState extends LayoutState{}
class LayoutGetAllCommentErrorState extends LayoutState{}

// get all users state==>>
class LayoutGetAllUsersLoadState extends LayoutState{}
class LayoutGetAllUsersSuccessState extends LayoutState{}
class LayoutGetAllUsersErrorState extends LayoutState{}


// send message state==>>
class LayoutSendMessageSuccess extends LayoutState{}
class LayoutSendMessageError extends LayoutState{}

// get message
class LayoutGetAllMessageState extends LayoutState{}

class LayoutPickImageChatSuccessState extends LayoutState{}
class LayoutPickImageChatErrorState extends LayoutState{}
class LayoutCloseChatImage extends LayoutState{}

class LayoutUploadChatImageLoading extends LayoutState{}

class LayoutListenFromPost extends LayoutState{}
class LayoutListenFromLike extends LayoutState{}
class LayoutListenFromComment extends LayoutState{}

class LayoutGetAll_PostSuccess extends LayoutState{}
