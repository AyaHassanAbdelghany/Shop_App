import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/login/login_screen.dart';
import '../../network/local/cache_helper.dart';

void navigatTo(context,widget) {
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget
      )
  );
}

void navigatAndFinish(context, widget) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
          (route) => false,
    );
  }

Widget defultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  required FormFieldValidator functionValidator,
  ValueChanged<String>? functionOnChange,
  bool isPassword = false,
  IconData? sufix,
  VoidCallback? sufixOnPressed,
}) {
  return Container(

    child: TextFormField(
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      onChanged: functionOnChange,
      decoration: InputDecoration(
          prefixIcon: Icon(
            prefix,
          ),
          suffixIcon: sufix != null
              ? IconButton(onPressed: sufixOnPressed, icon: Icon(sufix))
              : null,
          border: OutlineInputBorder(),
          label: Text(label)
      ),
      validator: functionValidator,
    ),
  );
}

Widget defualtButton({
  Color background = Colors.grey,
  double width = double.infinity,
  required final VoidCallback  function ,
  required String text,
  bool isUppercase = true,
}){
  return Container(
    width: width,
    color: background,
    child: MaterialButton(
      onPressed: function,
      child: Text(
        isUppercase ? text.toUpperCase() : text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 20.0
        ),
      ),
    ),
  );
}

Widget defultTextButton({
  required final VoidCallback  function ,
  required String text,
}){
  return TextButton(
      onPressed: function,
      child: Text(
          text.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0
        ),
      )
  );
}


void defultToast({
    required String message,
  required ToastStates state,
   }){
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: chooseColorToast(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

void signOut(context)
{
  CacheHelper.removeData(
    key: 'token',
  ).then((value)
  {
    if (value)
    {
      navigatAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}

Color? chooseColorToast(ToastStates state){
  Color? background;
   switch(state){
     case ToastStates.SUSSUCE :
       background = Colors.green;
       break;

     case ToastStates.ERROR :
       background = Colors.red;
       break;

     case ToastStates.WARNING :
       background = Colors.amberAccent;
       break;

   }
  return background;
}
enum ToastStates{ SUSSUCE , ERROR , WARNING}




