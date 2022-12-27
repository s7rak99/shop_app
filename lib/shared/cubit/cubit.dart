import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/categories_model.dart';
import 'package:shop_app/model/fav_model.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/model/login_model.dart';
import 'package:shop_app/modules/shop_app/categories/categories_screen.dart';
import 'package:shop_app/modules/shop_app/favorite/favorite_screen.dart';
import 'package:shop_app/modules/shop_app/product/product_screen.dart';
import 'package:shop_app/modules/shop_app/setting/settingscreen.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/cubit/state.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../model/add_favorite_model.dart';
import '../network/end_point.dart';

import 'package:http/http.dart' as http;

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
     ProductScreen(),
     CategoriesScreen(),
     FavoriteScreen(),
    SettingScreen()
  ];

  void changeBottom(i) {
    currentIndex = i;
    if(currentIndex==0){
      getHomeData();
    } else if(currentIndex==1){
      getCategoriesData();
    }
    else if(currentIndex==2){
      getFavorite();
          }
    else if(currentIndex==3){
      getUserData();
    }
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorite = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favorite.addAll({element.id!: element.inFavorites!});
      });


      emit(ShopSuccessHomeDataState());
    }).catchError((err) {
      print(err.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(' ==> cat${categoriesModel!.data!.currentPage}');
      emit(ShopSuccessCategoriesState());
    }).catchError((err) {
      print(err.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoriteModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorite[productId] = !favorite[productId]!;

    emit(ShopChangeFavoritesLoadingState());

    DioHelper.postData(
      url: FAVORITE,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoriteModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel!.status!) {
        favorite[productId] = !favorite[productId]!;
      } else {
        getFavorite();
      }

      emit(ShopSuccessChangeFavoritesState());
    }).catchError((error) {
      favorite[productId] = !favorite[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoriteModel? favoriteModel;

  // StreamController<FavoriteModel> fav = StreamController();

  void getFavorite() {
    emit(ShopChangeFavoritesLoadingState());

    DioHelper.getData(url: FAVORITE, token: token).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      // fav.sink.add(favoriteModel!);

      print('========================================> ${favoriteModel!.data!.data![0].product!.name}');
      emit(ShopSuccessChangeFavoritesState());
      //return fav;
    }).catchError((err) {
      print(err.toString());
      emit(ShopErrorChangeFavoritesState());
    });
  }

  // FavoriteModel? getFavorites() {
  //   emit(ShopChangeFavoritesLoadingState());
  //
  //   DioHelper.getData(url: FAVORITE, token: token).then((value) {
  //     favoriteModel = FavoriteModel.fromJson(value.data);
  //     print(
  //         '===========================================================> ${favoriteModel!.data!.data![0].product!.name}');
  //
  //     emit(ShopSuccessChangeFavoritesState());
  //     return favoriteModel;
  //   }).catchError((err) {
  //     print(err.toString());
  //     emit(ShopErrorChangeFavoritesState());
  //     return null;
  //   });
  //   return favoriteModel;
  //
  // }

  LoginModel? userModel;

  void getUserData() {
    emit(ShopGetUserDataLoadingState());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print('=================> ${userModel!.data!.name}');
      emit(ShopSuccessGetUserDataState(userModel!));
    }).catchError((err) {
      print(err.toString());
      emit(ShopErrorGetUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(ShopUpdateLoadingState());

    DioHelper.putData(url: UPDATE, token: token, data: {
      'name' : name,
      'phone' : phone,
      'email': email
    }).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print('=================> ${userModel!.data!.name}');
      emit(ShopSuccessUpdateState(userModel!));
    }).catchError((err) {
      print(err.toString());
      emit(ShopErrorUpdateState());
    });
  }


  // Stream<FavoriteModel?> productsStream() async* {
  //
  //   if (getFavorites()!.status!) {
  //     await Future.delayed(Duration(milliseconds: 500));
  //     FavoriteModel? favoriteModel = getFavorites();
  //     yield favoriteModel;
  //   }
  // }


}
