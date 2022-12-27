import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/shop_app/login/login.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/network/remote/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/style/color.dart';
import 'package:shop_app/shared/style/themes.dart';
import 'package:shop_app/task/on_boarding_task.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  if (onBoarding != null) {
    if (token != null) {
      widget =  ShopLayout();
    }
    else {
      widget = ShopLoginScreen();
    }
  }
  else {
    widget = OnBoardingScreen();
  }
  print(onBoarding);

  runApp(MyApp(startWidget: widget));
}
class MyApp extends StatelessWidget {
   final Widget? startWidget;
  MyApp({super.key,this.startWidget});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>
        ShopCubit()..getHomeData()..getCategoriesData()..getFavorite()..getUserData()),
      ],
      child: BlocConsumer<ShopCubit, ShopState>(
          listener: (context, state) {},
          builder: (context, state) {

            return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: startWidget,
                theme: lightTheme,
                darkTheme: darkMode);
          }),
    );
  }
}

Widget defaultTextButton({
  String? text,
  VoidCallback? onPressed
}) {
  return TextButton(
      onPressed: onPressed,
      child: Text('$text'));
}
