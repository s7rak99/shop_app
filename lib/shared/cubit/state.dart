import 'package:shop_app/model/login_model.dart';

import '../../model/add_favorite_model.dart';

abstract class ShopState {}

class ShopInitialState extends ShopState {}

class ShopChangeBottomNavState extends ShopState {}

class ShopLoadingHomeDataState extends ShopState {}

class ShopSuccessHomeDataState extends ShopState {}

class ShopErrorHomeDataState extends ShopState {}

class ShopSuccessCategoriesState extends ShopState {}

class ShopErrorCategoriesState extends ShopState {}

class ShopChangeFavoritesLoadingState extends ShopState {}

class ShopSuccessChangeFavoritesState extends ShopState {}

class ShopErrorChangeFavoritesState extends ShopState {}

class ShopGetUserDataLoadingState extends ShopState {}

class ShopSuccessGetUserDataState extends ShopState
{
  final LoginModel loginModel;

  ShopSuccessGetUserDataState(this.loginModel);
}

class ShopErrorGetUserDataState extends ShopState {}

class ShopUpdateLoadingState extends ShopState {}

class ShopSuccessUpdateState extends ShopState
{
  final LoginModel loginModel;

  ShopSuccessUpdateState(this.loginModel);
}

class ShopErrorUpdateState extends ShopState {}
