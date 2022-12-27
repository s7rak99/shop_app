import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/modules/shop_app/register/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/register/cubit/state.dart';
import 'package:shop_app/shared/component/component.dart';

import '../../../shared/component/constant.dart';
import '../../../shared/cubit/cubit.dart';
import '../../../shared/network/remote/cache_helper.dart';

// ignore: must_be_immutable
class ShopRegisterScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPass = true;

  ShopRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state){
          if(state is RegisterSuccessState){
            if(state.loginModel.status ==true){
              print(state.loginModel.message);
              print(state.loginModel.data!.token);


              toast(message: "${state.loginModel.message}", states: ToastsStates.SUCCESS);

              CacheHelper.saveDate(key: 'token', val: state.loginModel.data!.token).then((value) {
                token = state.loginModel.data!.token;
                ShopCubit.get(context)..getHomeData()..getCategoriesData()..getFavorite()..getUserData();

                navigatePush(context, ShopLayout());
              });
            }
            else{
              print(state.loginModel.message);
              toast(message: "${state.loginModel.message}", states: ToastsStates.ERROR);

            }}
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
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
                        'Register',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Register now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'Full Name',
                          prefixIcon: Icons.person,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'please enter your name address';
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: emailController,
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
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone Number',
                          prefixIcon: Icons.phone,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'please enter your phone number address';
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          controller: passwordController,
                          type: TextInputType.number,
                          label: 'Password',
                          prefixIcon: Icons.lock_outline,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'password is too short';
                            }
                          },
                          suffixIcon: Icons.visibility_outlined,
                          isPassword: true),
                      const SizedBox(
                        height: 20,
                      ),
                      state is! RegisterLoadingState
                          ? defaultButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                }
                              },
                              text: 'Register',
                              isUpperCase: true)
                          : const Center(child: CircularProgressIndicator()),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Do you have an account? ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          defaultTextButton(
                              text: 'Login Now', onPressed: () {}),
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
}
