import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class LoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar:  AppBar(),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit,LoginStates>(
          listener: (context,state) {
          if(state is LoginSuccessState){
            defultToast(
                message: state.loginModel.message ?? "",
                background: LoginCubit.getInstance(context).backgroundToast
            );
          }
          },
          builder: (context,state){
            var loginCubit = LoginCubit.getInstance(context);
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
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 35.0,
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
                            isPassword: loginCubit.isPassword,
                            sufix: loginCubit.iconPassword,
                            sufixOnPressed: (){
                              loginCubit.changePasswordVisibility();
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
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                         condition: state is ! LoginLoadingState,
                          builder: (context) =>
                            defualtButton(
                              function: (){
                                if(formKey.currentState!.validate()){
                                  loginCubit.userLogin(emailController.text,passwordController.text);
                                }
                              },
                              text: 'Login',
                              background: primaryColor,
                            ),
                          fallback: (context) =>const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 20.0 ,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have account ?',
                              style: Theme.of(context).textTheme.bodyText1 !.copyWith(
                                  color: Colors.black
                              ),
                            ),
                            defultTextButton(
                                function: (){
                                  navigatTo(context, const RegisterScreen());
                                },
                                text: 'register'
                            )
                          ],
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
