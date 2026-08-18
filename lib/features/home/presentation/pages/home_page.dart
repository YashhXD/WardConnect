import 'package:authenapp/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Welcome"),
            actions: [
                IconButton(onPressed: (){
                    final authCubit = context.read<AuthCubit>();
                    authCubit.logout();
                }, icon: const Icon(Icons.logout),)
            ],
        ),
        body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Successfulyy logged in",style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary,fontSize: 30,fontWeight: FontWeight.bold),),
                ],
            
            ),
          ],
        ),
    );
  }
}