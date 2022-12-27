import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/fav_model.dart';
import 'package:shop_app/shared/component/component.dart';

import '../../../shared/cubit/cubit.dart';
import '../../../shared/cubit/state.dart';
import '../../../shared/style/color.dart';


class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  // @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        builder: (context, state) {
          return state is! ShopChangeFavoritesLoadingState?
          ListView.separated(
              itemBuilder: (context, i) {
                return buildListProduct(
                    ShopCubit.get(context).favoriteModel!.data!.data![i].product!,
                    context);
              },
              separatorBuilder: (context, i) {
                return Container(
                  color: Colors.grey,
                  height: 1.0,
                );
              },
              itemCount:
              ShopCubit.get(context).favoriteModel!.data!.data!.length): const Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (context, state) {});
  }
}
