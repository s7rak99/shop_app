import 'package:shop_app/model/login_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState{}

class LoginLoadingState extends LoginState{}

class LoginSuccessState extends LoginState{
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);

}

class LoginErrorState extends LoginState{
  final String err;

  LoginErrorState(this.err);

}

class LoginChangePasswordVisibilityState extends LoginState{}

class LoginRememberState extends LoginState{}

