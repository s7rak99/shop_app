import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/fav_model.dart';
import '../../model/search_model.dart';
import '../cubit/cubit.dart';
import '../style/color.dart';

BuildContext? contextForStream;

void navigateTo(context , widget) => Navigator.push(context,
    MaterialPageRoute(builder: (context) => widget));


void navigatePush(context , widget) => Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context) => widget) , (route) => false);



Widget defaultFormField(
    {required TextEditingController controller,
      TextInputType? type,
      VoidCallback? onPressed,
      String? Function(String?)? onChange,
      String? Function(String?)? onSubmit,

      VoidCallback? onTab,
      String? Function(String?)? validator,
      required String label,
      bool isPassword = false,
      bool isClickable = true,
      required IconData prefixIcon,
      IconData? suffixIcon,
      VoidCallback? suffixPressed}) {
  return TextFormField(
    onTap: onTab,
    controller: controller,
    validator: validator,
    onFieldSubmitted: onSubmit,

    onChanged: onChange,
    enabled: isClickable,
    keyboardType: type,
    obscureText: isPassword == true ? true : false,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: suffixIcon != null
          ? IconButton(
        icon: Icon(suffixIcon),
        onPressed: suffixPressed,
      )
          : null,
      border: const OutlineInputBorder(),
    ),
  );
}



Widget defaultButton(
    {double width = double.infinity,
      bool isUpperCase = true,
      required VoidCallback onPressed,
      String text = 'press'}) =>
    MaterialButton(
      onPressed: onPressed,
      color: Colors.orange.shade400,
      minWidth: width,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Text(
        isUpperCase ? text.toUpperCase() : text,
        style: const TextStyle(color: Colors.white, fontSize: 25.0),
      ),
    );

Future<bool?> toast({
  required String message,
 required ToastsStates states

}){
  return  Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(states),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastsStates{
  SUCCESS,
  ERROR,
  WARNING

}

Color chooseToastColor(ToastsStates states){
  Color color;
  switch(states){
    case ToastsStates.SUCCESS: color = Colors.green;
    break;
    case ToastsStates.ERROR: color = Colors.red;
    break;
    default:
      color = Colors.amber;
    break;
  }
  return color;
}

Widget buildListProduct(Product? model, context, {bool oldPrice = true}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: SizedBox(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model!.image}'),
              width: 120,
              height: 120,
            ),
            if (model.discount != 0)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(
                    vertical: 3, horizontal: 10.0),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
          ],
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${model.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, height: 1.3),
              ),
              Row(
                children: [
                  Text(
                    '${model.price!.round()}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: defaultColor),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if (model.discount != 0 && oldPrice)
                    Text(
                      '${model.oldPrice!.round()}',
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id!);
                      },
                      icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                          ShopCubit.get(context).favorite[model.id]!
                              ? defaultColor
                              :
                          Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          )))
                ],
              )
            ],
          ),
        )
      ],
    ),
  ),
);
