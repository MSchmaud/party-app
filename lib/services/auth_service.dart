import 'package:firebase_auth/firebase_auth.dart';

// Class of functions to be used by other dart files
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // When a state change of user, stream returns value to change look of app
  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map((
    FirebaseUser user) => user?.uid,
  );

  // Email and Password sign up
  Future<String> createUserWithEmailAndPassword(String email, String password, String username) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password,);

    // Update the username
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = username;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
    return currentUser.uid;
  }

  // Email and password sign in
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).uid;
  }

  // Sign out
  signOut() {
    return _firebaseAuth.signOut();
  }

}

// CLASSES FOR VALIDATION OF FORM FIELDS
class EmailValidator {
  static String validate(String value) {
    if(value.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}

class UsernameValidator {
  static String validate(String value) {
    if(value.isEmpty) {
      return "Username can't be empty";
    }
    if(value.length < 4){
      return "Username must be at least 4 characters long";
    }
    if(value.length > 50){
      return "Username must be less than 50 characters long";
    }
    return null;
  }
}

class PasswordValidator {
  static String validate(String value) {
    if(value.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }
}