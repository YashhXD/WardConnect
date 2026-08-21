import 'package:authenapp/features/auth/data/firebase_auth_repo.dart';
import 'package:authenapp/features/auth/presentation/components/loading.dart';
import 'package:authenapp/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:authenapp/features/auth/presentation/cubits/auth_states.dart';
import 'package:authenapp/features/auth/presentation/pages/auth_page.dart';
import 'package:authenapp/features/home/presentation/pages/home_page.dart';
import 'package:authenapp/firebase_options.dart';
import 'package:authenapp/themes/dark_mode.dart';
import 'package:authenapp/themes/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // firebase setup
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final firebaseAuthRepo = FirebaseAuthRepo();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create:(context) => AuthCubit(authRepo: firebaseAuthRepo)..checkAuth(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightmode,
        // darkTheme: darkMode,
        home: BlocConsumer<AuthCubit, AuthState>(builder: (context,state){
          print(state);
          if(state is Unauthenticated){
            return const AuthPage();
          }

          if (state is Authenticated){
            return const HomePage();
          } else {
            return const LoadingScreen();
          }

        }, listener: (context,state){
          if(state is AuthError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        }
        ),
      ),
    );
  }
}