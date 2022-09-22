import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';

import '../../layout/shop_layout.dart';
import '../../network/local/cache_helper.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class RegisterScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit,RegisterStates>(
          listener: (context,state) {
            if(state is RegisterSuccessState) {
              if (state.loginModel.status) {
                CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token);
                token = state.loginModel.data!.token.toString();
                navigatAndFinish(context, ShopLayout());
              }
              else{
                defultToast(
                  message: state.loginModel.message ?? "",
                  state: ToastStates.ERROR,
                );
              }
            }
          },
          builder: (context,state){
            var registerCubit = RegisterCubit.getInstance(context);
            return  Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 35.0,
                        ),
                        defultTextFormField(
                            controller: nameController,
                            type: TextInputType.text,
                            label: 'User Name',
                            prefix: Icons.person,
                            functionValidator: (value){
                              if(value.isEmpty){
                                return ' name must not be empty';
                              }
                              return null;
                            }
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defultTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email',
                            prefix: Icons.email_outlined,
                            functionValidator: (value){
                              if(value.isEmpty){
                                return ' email must not be empty';
                              }
                              return null;
                            }
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defultTextFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            label: 'Password',
                            isPassword: registerCubit.isPassword,
                            sufix: registerCubit.iconPassword,
                            sufixOnPressed: (){
                              registerCubit.changePasswordVisibility();
                            },
                            prefix: Icons.lock_outline,
                            functionValidator: (value){
                              if(value.isEmpty){
                                return ' password must not be empty';
                              }
                              return null;
                            }
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defultTextFormField(
                            controller: phoneController,
                            type: TextInputType.number,
                            label: 'Phone',
                            prefix: Icons.phone,
                            functionValidator: (value){
                              if(value.isEmpty){
                                return ' phone must not be empty';
                              }
                              return null;
                            }
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is ! RegisterLoadingState,
                          builder: (context) =>
                              defualtButton(
                                function: (){
                                  if(formKey.currentState!.validate()){
                                    registerCubit.userRegister(
                                        emailController.text,
                                        passwordController.text,
                                        nameController.text,
                                        phoneController.text);
                                  }
                                },
                                text: 'Register',
                                background: primaryColor,
                              ),
                          fallback: (context) =>const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
