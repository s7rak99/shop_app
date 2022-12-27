import 'package:shop_app/model/login_model.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState{}

class RegisterLoadingState extends RegisterState{}

class RegisterSuccessState extends RegisterState{
  final LoginModel loginModel;

  RegisterSuccessState(this.loginModel);

}

class RegisterErrorState extends RegisterState{
  final String err;

  RegisterErrorState(this.err);

}

class RegisterChangePasswordVisibilityState extends RegisterState{}
