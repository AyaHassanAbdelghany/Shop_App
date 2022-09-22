import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state) {
        var model = ShopCubit.getInstance(context).loginModel;
        emailController.text = model!.data!.email!;
        phoneController.text = model!.data!.phone!;
        nameController.text = model!.data!.name!;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if(state is ShopUpdateProfileLoadingState)
                   LinearProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                defultTextFormField(
                    controller: nameController,
                    type: TextInputType.text,
                    label: 'Name',
                    prefix: Icons.person,
                    functionValidator: (value) {
                      if (value.isEmpty) {
                        return ' name must not be empty';
                      }
                      return null;
                    }
                ),
                SizedBox(
                  height: 20.0,
                ),
                defultTextFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Email',
                    prefix: Icons.email,
                    functionValidator: (value) {
                      if (value.isEmpty) {
                        return ' email must not be empty';
                      }
                      return null;
                    }
                ),

                SizedBox(
                  height: 20.0,
                ),
                defultTextFormField(
                    controller: phoneController,
                    type: TextInputType.number,
                    label: 'Phone',
                    prefix: Icons.phone,
                    functionValidator: (value) {
                      if (value.isEmpty) {
                        return ' phone must not be empty';
                      }
                      return null;
                    }
                ),
                SizedBox(
                  height: 20.0,
                ),
                defualtButton(
                    function: () {
                    signOut(context);
                    },
                    background: primaryColor,
                    text: 'logout'
                ),
                SizedBox(
                  height: 20.0,
                ),
                defualtButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        ShopCubit.getInstance(context).updateProfile(
                            email: emailController.text,
                            phone: phoneController.text,
                            name: nameController.text);
                      }
                    },
                    background: primaryColor,
                    text: 'update'
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
