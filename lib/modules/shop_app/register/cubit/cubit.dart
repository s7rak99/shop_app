import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/login_model.dart';
import 'package:shop_app/modules/shop_app/login/cubit/state.dart';
import 'package:shop_app/modules/shop_app/register/cubit/state.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) =>BlocProvider.of(context);

  LoginModel? loginModel ;

  void userRegister({
  required String email ,
    required String password,
    required String name ,
    required String phone
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'email' : email,
      'password' : password,
      "name": name,
      "phone": phone,
    }).then((value){
      print(value.data);

      loginModel = LoginModel.fromJson(value.data);
      // print(loginModel!.status);
      // print(loginModel!.data!.token);
      emit(RegisterSuccessState(loginModel!));
    }).catchError((err){
      print(err.toString());
      emit(RegisterErrorState(err.toString()));
    });
  }

  IconData suffixIcon  = Icons.visibility_outlined;
  bool isPasswordShown = true;
  void changPasswordVisibility(){
    isPasswordShown = !isPasswordShown;
    suffixIcon = isPasswordShown ?Icons.visibility_outlined:  Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());

  }



}