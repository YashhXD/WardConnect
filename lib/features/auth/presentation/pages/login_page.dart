/*
  Login page ui
*/
import 'package:authenapp/features/auth/presentation/components/google_sign_in_button.dart';
import 'package:authenapp/features/auth/presentation/components/my_button.dart';
import 'package:authenapp/features/auth/presentation/components/my_textfield.dart';
import 'package:authenapp/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;
  const LoginPage({super.key , required this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  late final authCubit = context.read<AuthCubit>();

  void login(){
    final String email = emailController.text;
    final String pw = pwController.text;


    if ( email.isNotEmpty && pw.isNotEmpty){
      authCubit.login(email, pw);
    } else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter both email and password"))); 
    }
  }

  void openForgotPasswordBox(){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("Forgot Password?"),
      content: MyTextfield(controller: emailController, hintText: "Enter email", obscureText: false),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),

        TextButton(onPressed: () async{
          String message = await authCubit.forgetPassword(emailController.text);
          if ( message == "Password reset email sent! Check your inbox"){
            Navigator.pop(context);
            emailController.clear();
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
        }, child: const Text("Reset"))
      ],
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('lib/assets/logo.png',height: 100,),
              const SizedBox(height: 25,),
          
              Text("LOG IN",
              style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.inversePrimary),),
          
              const SizedBox(height: 25,),
          
              MyTextfield(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),

              SizedBox(height: 10,),

              MyTextfield(
                controller : pwController,
                hintText: "Password",
                obscureText: true,
              ),

              const SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => openForgotPasswordBox(),
                    child:
                   Text("Forgot Password",style: TextStyle(color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),)),
                ],
              ),

              const SizedBox(height: 25,),

              MyButton(
                onTap: login,
                text: "Login",
              ),

              const SizedBox(height: 25,),

              Row(
                children: [
                  Expanded(child: Divider(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text("Or sign in with"),
                  ),
                  Expanded(child: Divider(
                    color: Theme.of(context).colorScheme.tertiary,
                  ))
                ],
              ),
              const SizedBox(height: 25,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyGoogleSignInButton(
                    onTap : () async {
                      authCubit.signInWithGoogle();
                    },
                  )
                ],
              ),

              const SizedBox(height: 25,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?",style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),),
                  GestureDetector(
                    onTap: widget.togglePages,
                    child: Text(" Register now",style: TextStyle(
                      fontWeight: FontWeight.bold, 
                    ),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}