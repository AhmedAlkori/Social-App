import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/social_cubit.dart';
import '../../layout/cubit/social_state.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constant.dart';


class FeedsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutState>(
      listener: (context,state){},
      builder: (context,state)
      {
        LayoutCubit cubit=LayoutCubit.get(context);

        return Container(
          color: Colors.amber.withOpacity(.6),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Row(
              children:
              [
                Icon(
                  Icons.info_outline,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: Text(
                    'Please verify your email',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.0,
                        fontFamily: 'Janna',
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                TextButton(
                    onPressed: ()
                    {
                      FirebaseAuth.instance.currentUser?.sendEmailVerification()
                          .then((value) {
                        showMessage(message: 'Check your email',
                            bgColor: getColor(MessageState.SUCCESS));
                      });
                    },
                    child: Text(
                      'SEND',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ))
              ],
            ),
          ),
        );
      },

    );
  }
}
