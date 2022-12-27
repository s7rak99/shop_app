import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/login_model.dart';
import 'package:shop_app/modules/shop_app/login/cubit/state.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {'email': email, 'password': password})
        .then((value) {
      print(value.data);

      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((err) {
      print(err.toString());
      emit(LoginErrorState(err.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPasswordShown = true;

  void changPasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffixIcon = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }

  bool save = false;

  void rememberMe() {
    save = !save;
    emit(LoginRememberState());
  }

  // var emailController = TextEditingController();
  // var passwordController = TextEditingController();

  // void setCon(){
  //   if(CacheHelper.getData(key: 'save')){
  //     emailController.text =  CacheHelper.getData(key: 'email');
  //     print('on state@@@@ ${emailController.text}');
  //     passwordController.text =  CacheHelper.getData(key: 'password');
  //     print('on state@@@@ ${passwordController.text}');
  //   }
  //   else{
  //     CacheHelper.clearData(key: 'email');
  //     CacheHelper.clearData(key: 'password');
  //   }
  // }
}
