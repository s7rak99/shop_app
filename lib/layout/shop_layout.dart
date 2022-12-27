import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';

import '../modules/shop_app/search/search_screen.dart';
import '../shared/component/component.dart';

class ShopLayout extends StatelessWidget {

   ShopLayout({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                title:  Text('Salla'),
                actions: [
                 IconButton(onPressed: (){
                   navigateTo(context, SearchScreen());
                 }, icon:const Icon(Icons.search))
              ]),
              body: cubit.bottomScreens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeBottom(index);
                },
                currentIndex: cubit.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.category_outlined), label: 'Categories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border), label: 'Favorite'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings_outlined), label: 'Setting'),
                ],
              ));
        },
        listener: (context, state) {});
  }
}
