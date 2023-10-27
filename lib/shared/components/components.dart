import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultForm({
  required TextEditingController controler,
  required String title,
  required IconData prefix,
  required TextInputType type,
  required bool isPass,
  bool isVisibale=true,
  required FormFieldValidator<String>? validate,
  VoidCallback? onPress,
  ValueChanged<String>? onSubmit,
})=> TextFormField(
  controller:controler,
  obscureText: isPass ?  isVisibale : false,
  keyboardType: type,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: title,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: isPass != true ? Icon(
      null,
    ) :IconButton(
      onPressed:onPress,
      icon:  Icon(
        isVisibale ?Icons.visibility_off : Icons.visibility ,
      ),

    ),
  ),
  validator:validate,
  onFieldSubmitted: onSubmit,

);

void nextWidget({
  required context,
  required Widget screen,
})
{
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context)=>screen),
          (route) => false);
}


Widget defaultTextButton({
  required String text,
  required VoidCallback? onClick,
  double? font_size,

})=>TextButton(
    onPressed: onClick,
    child: Text(
      '${text}',
      style: TextStyle(
        fontSize: font_size??18.0,
        fontWeight: FontWeight.bold,

      ),
    ));

void showMessage({
  required String message,
  required Color bgColor,
})=> Fluttertoast.showToast(
    msg: message,
  gravity: ToastGravity.BOTTOM,
  toastLength: Toast.LENGTH_LONG,
  backgroundColor: bgColor,
  textColor: Colors.white,
  fontSize: 16.0,
);
