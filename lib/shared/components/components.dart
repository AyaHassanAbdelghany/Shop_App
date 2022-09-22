import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/home/product_model.dart';
import '../../layout/cubit/cubit.dart';
import '../../modules/login/login_screen.dart';
import '../../network/local/cache_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'constants.dart';

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
  return TextFormField(
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
        border: const OutlineInputBorder(),
        label: Text(label)
    ),
    validator: functionValidator,
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
        style: const TextStyle(
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
        style: const TextStyle(
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


Widget buildProductItem(ProductModel? model,BuildContext context, { bool isOldPrice = true}) =>
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                SizedBox(
                  width: 120.0,
                  height: 120.0,
                  child: CachedNetworkImage(
                    imageUrl: '${model!.image}',
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.downloading, color: Colors.grey),
                    fit: BoxFit.cover,
                  ),
                ),
                if(model.discount!=0 && isOldPrice)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      if(model.discount!=0 && isOldPrice)
                        Text(
                          '${model.oldPrice}',
                          style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough, decorationColor: Colors.cyan
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: (){
                            ShopCubit.getInstance(context).changeFavourite(model.id);
                          },
                          icon: CircleAvatar(
                            radius: 18.0,
                            backgroundColor: ShopCubit.getInstance(context).favourites[model.id] !=true ? Colors.grey :primaryColor ,
                            child: const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 18.0,
                            ),
                          )
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

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




