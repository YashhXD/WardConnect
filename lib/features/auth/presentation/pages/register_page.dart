import 'package:authenapp/features/auth/presentation/components/my_button.dart';
import 'package:authenapp/features/auth/presentation/components/my_textfield.dart';
import 'package:authenapp/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;
  const RegisterPage({super.key, required this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final pwController = TextEditingController();
  final confimrpwController = TextEditingController();

  void register(){
    final String name = nameController.text;
    final String email = emailController.text;
    final String pw = pwController.text;
    final String confirmpw = confimrpwController.text;

    final authCubit = context.read<AuthCubit>();

    if(email.isNotEmpty && name.isNotEmpty && pw.isNotEmpty && confirmpw.isNotEmpty){
      if(pw == confirmpw){
        authCubit.register(name, email, pw);
      } else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all fields")));
    }

  }

  @override
  void dispose(){
    nameController.dispose();
    confimrpwController.dispose();
    pwController.dispose();
    emailController.dispose();
    super.dispose(); 
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
          
              Text("Lets's create a new account",
              style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.inversePrimary),),
          
              const SizedBox(height: 25,),
          
              MyTextfield(
                controller: nameController,
                hintText: "Name",
                obscureText: false,
              ),

              const SizedBox(height: 10,),
          
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
              SizedBox(height: 10,),

              MyTextfield(
                controller : confimrpwController,
                hintText: "Confirm password",
                obscureText: true,
              ),

              const SizedBox(height: 25,),

              MyButton(
                onTap: register,
                text: "Sign Up",
              ),

              const SizedBox(height: 25,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account ?",style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),),
                  GestureDetector(
                    onTap: widget.togglePages,
                    child: Text(" Login now",style: TextStyle(
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