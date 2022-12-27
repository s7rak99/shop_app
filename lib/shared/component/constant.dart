import 'package:shop_app/shared/cubit/cubit.dart';

import '../../modules/shop_app/login/cubit/cubit.dart';
import '../../modules/shop_app/login/login.dart';
import '../network/remote/cache_helper.dart';
import 'component.dart';

void signOut(context){
  CacheHelper.clearData(key: 'token').then((value) {
    if(value){

      token = '';
      ShopCubit.get(context).currentIndex = 0;
      navigatePush(context, ShopLoginScreen());
      print('doneee');
    }
  });
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=> print(match.group(0)));
}

String? token='';