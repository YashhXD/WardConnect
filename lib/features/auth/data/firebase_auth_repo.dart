// firebase is our backend - you can swap out any backend here 
import 'package:authenapp/features/auth/domain/entities/app_user.dart';
import 'package:authenapp/features/auth/domain/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthRepo implements AuthRepo{
  // access to firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // google sign-in (7.x API: singleton, must be initialized once)
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  bool _googleSignInInitialized = false;

  // LOGIN : email and password
  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async{
    try{
      //attempt to sign in
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      //check if user is null
      final firebaseUser = userCredential.user;
      if (firebaseUser == null) return null;

      //create user
      AppUser user = AppUser(uid: firebaseUser.uid, email: email);

      //return user
      return user;
    }
    catch(e){
      throw Exception('Login Failed : $e');
    }
  }
  
  //DELETE ACCOUNT
  @override
  Future<void> deleteAccount() async{
    try{
      //get current user
      final user = firebaseAuth.currentUser; 

      //check if there is a logged in user
      if (user==null) throw Exception('No user logged in');

      //delete account
      await user.delete();

      //logout
      await logout();
    }
    catch(e){
      throw Exception('Failed to delete account : $e');
    }
  }
  
  //GET CURRENT USER
  @override
  Future<AppUser?> getCurrentUser() async{
    // get current logged in user from firebase
    final firebaseUser = firebaseAuth.currentUser;

    //no logged in user
    if (firebaseUser == null) return null;

    //logged in user exists
    final email = firebaseUser.email ?? '';
    return AppUser(uid: firebaseUser.uid, email: email);

  }
  
  //LOGOUT 
  @override
  Future<void> logout() async{
    await firebaseAuth.signOut();
  }

  //REGISTER email and password
  @override
  Future<AppUser?> registerWithEmailPassword(String name, String email, String password) async{
    try{
      // attempt to sign in
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      //check if user is null
      final firebaseUser = userCredential.user;
      if (firebaseUser == null) return null;

      //update display name
      await firebaseUser.updateDisplayName(name);

      //create user
      AppUser user = AppUser(uid: firebaseUser.uid, email: email);

      //return user
      return user;

    }
    catch(e){
      throw Exception('Registration failed: $e');
    }
  }
  
  // RESET PASSWORD
  @override
  Future<String> sendPasswordResetEmail(String email) async{
    try{
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "Password reset email sent! Check your inbox";
    }
    catch(e){
      throw Exception('An error occured : $e');
    }
  }
  
  //Sign in with google
  // ... inside FirebaseAuthRepo class

// Sign in with google
@override
Future<AppUser?> signInWithGoogle() async {
  try {
    // initialize once (7.x contract) with serverClientId
    if (!_googleSignInInitialized) {
      await googleSignIn.initialize(
        serverClientId: '1093646522685-0o2a8b4gnt5tkrnru4dnpi1pa6maun9d.apps.googleusercontent.com',
      );
      _googleSignInInitialized = true;
    }

    // interactive sign-in
    final GoogleSignInAccount gUser = await googleSignIn.authenticate();

    // synchronous getter — no await
    final GoogleSignInAuthentication gAuth = gUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: gAuth.idToken,
    );

    UserCredential userCredential =
        await firebaseAuth.signInWithCredential(credential);
    print("Current Firebase User: ${FirebaseAuth.instance.currentUser?.email}");
    final firebaseUser = userCredential.user;

    if (firebaseUser == null) return null;

    AppUser appUser = AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
    );
    return appUser;
  } catch (e) {
    print(e);
    return null;
  }
}
}