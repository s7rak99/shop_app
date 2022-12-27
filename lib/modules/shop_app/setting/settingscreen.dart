import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constant.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/state.dart';

import '../login/cubit/cubit.dart';

class SettingScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(builder: (context, state) {
      var model = ShopCubit.get(context).userModel;
      nameController.text = model!.data!.name!;
      emailController.text = model.data!.email!;
      phoneController.text = model.data!.phone!;
      var formKey = GlobalKey<FormState>();

      return ShopCubit.get(context).userModel != null
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is ShopUpdateLoadingState)
                      LinearProgressIndicator(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                        controller: nameController,
                        label: 'user',
                        type: TextInputType.name,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'name must be empty!';
                          }
                          return null;
                        },
                        prefixIcon: Icons.person),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                        controller: emailController,
                        label: 'email',
                        type: TextInputType.emailAddress,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'email must be empty!';
                          }
                          return null;
                        },
                        prefixIcon: Icons.email),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultFormField(
                        controller: phoneController,
                        label: 'phone',
                        type: TextInputType.phone,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'phone must be empty!';
                          }
                          return null;
                        },
                        prefixIcon: Icons.phone),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(onPressed: (){
                      if(formKey.currentState!.validate()){
                        ShopCubit.get(context).updateUserData(name: nameController.text, phone: phoneController.text, email: emailController.text);

                      }

                      }
                        , text: 'UPDATE'),
                    const SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(onPressed: (){
                      signOut(context);} , text: 'LOGOUT')
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator());
    }, listener: (context, state) {
      if (state is ShopSuccessGetUserDataState) {}
    });
  }
}
