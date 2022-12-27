import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/modules/shop_app/register/register.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/remote/cache_helper.dart';

import '../../../shared/component/constant.dart';
import 'cubit/state.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController2 = TextEditingController();
  var passwordController2 = TextEditingController();




  var formKey = GlobalKey<FormState>();
  bool isPass = true;

  bool saves = CacheHelper.getData(key: 'save')??false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel.status == true) {
              toast(
                  message: "${state.loginModel.message}",
                  states: ToastsStates.SUCCESS);
              CacheHelper.saveDate(
                      key: 'token', val: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                print('token => $token');

                ShopCubit.get(context)
                  ..getHomeData()
                  ..getCategoriesData()
                  ..getFavorite()
                  ..getUserData();
                navigatePush(context, ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              toast(
                  message: "${state.loginModel.message}",
                  states: ToastsStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      CacheHelper.clearData(key: 'onBoarding').then((value) {
                        if (value) {
                          navigatePush(context, OnBoardingScreen());
                        }
                      });
                    },
                    icon: Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                    )),
                const SizedBox(
                  width: 10.0,
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 150.0,
                          width: 150.0,
                          child: Image.asset('assets/images/cart4.png')),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: saves == true
                              ? getEmail()
                              : emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email',
                          prefixIcon: Icons.email_outlined,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'please enter your email address';
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: saves == true
                              ? getPass()
                              : passwordController,
                          type: TextInputType.number,
                          label: 'Password',
                          prefixIcon: Icons.lock_outline,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          suffixIcon: LoginCubit.get(context).suffixIcon,
                          isPassword: LoginCubit.get(context).isPasswordShown,
                          suffixPressed: () {
                            LoginCubit.get(context).changPasswordVisibility();
                          },
                          onSubmit: (val) {
                            if (formKey.currentState!.validate()) {
                              if (LoginCubit.get(context).save == true) {
                                CacheHelper.saveDate(
                                    key: 'save',
                                    val: LoginCubit.get(context).save);
                                CacheHelper.saveDate(
                                    key: 'email', val: emailController.text);
                                CacheHelper.saveDate(
                                    key: 'password',
                                    val: passwordController.text);
                              }

                              LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: saves == true
                                  ? true
                                  : LoginCubit.get(context).save,
                              onChanged: (v) {
                                if(v==false){
                                  LoginCubit.get(context).rememberMe();
                                  CacheHelper.clearData(key: 'email');
                                  CacheHelper.clearData(key: 'password');
                                  CacheHelper.clearData(key: 'save');

                                }else{
                                  LoginCubit.get(context).rememberMe();

                                }
                              }),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text('Remember me?')
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      state is! LoginLoadingState
                          ? defaultButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (LoginCubit.get(context).save == true) {
                                    CacheHelper.saveDate(
                                        key: 'save',
                                        val: LoginCubit.get(context).save);
                                    CacheHelper.saveDate(
                                        key: 'email',
                                        val: emailController.text);
                                    CacheHelper.saveDate(
                                        key: 'password',
                                        val: passwordController.text);
                                  }

                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                                // state is! LoginLoadingState?
                                //     :
                              },
                              text: 'login',
                              isUpperCase: true)
                          : const Center(child: CircularProgressIndicator()),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          defaultTextButton(
                              text: 'Register Now',
                              onPressed: () {
                                navigateTo(context, ShopRegisterScreen());
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  TextEditingController getEmail(){
    emailController.text = CacheHelper.getData(key: 'email');
    return emailController;
  }
  TextEditingController getPass(){
    passwordController.text = CacheHelper.getData(key: 'password');
    return passwordController;
  }
}
