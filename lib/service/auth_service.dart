import 'package:chatapp_flutter_firebase2/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../helper/helper_function.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;


  //login
  Future loginUserWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user!;
      if(user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }



  //register
  Future registerUserWithEmailAndPassword(String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user!;
      if(user != null){
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);
        return true;
      }

    } on FirebaseAuthException catch (e) {
        return e.message;
    }
  }



  //signout
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();

    } catch (e){
      return null;
    }
  }
}































