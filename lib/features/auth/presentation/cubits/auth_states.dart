import 'package:authenapp/features/auth/domain/entities/app_user.dart';

// Auth states
abstract class AuthState {

}

// Initial
class AuthInitial extends AuthState{

}

// Loading
class AuthLoading extends AuthState{
  
}

// Authenticated
class Authenticated extends AuthState{
  final AppUser user;
  Authenticated(this.user);
}

// Unauthenticated
class Unauthenticated extends AuthState{

}

// Error
class AuthError extends AuthState{
  final String message;
  AuthError(this.message); 
}