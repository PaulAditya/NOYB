import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("Result $result");
      FirebaseUser user = result.user;
      print("User $user");
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<FirebaseUser> signInWithGoogle() async {
    FirebaseUser user;

    bool isSignedIn = await _googleSignIn.isSignedIn();

    if (isSignedIn) {
      user = await _auth.currentUser();
    } else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      // get the credentials to (access / id token)
      // to sign in via Firebase Authentication
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      user = (await _auth.signInWithCredential(credential)).user;

      return user;
    }
  }

  Future<FirebaseUser> createUser(
      String email, String password, String username) async {
    FirebaseUser user;

    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(result);
      user = result.user;
      print(user);

      UserUpdateInfo userInfo = new UserUpdateInfo();
      userInfo.displayName = username;
      user.updateProfile(userInfo);
    }catch (error) {
          switch (error.code) {
            case "ERROR_EMAIL_ALREADY_IN_USE":
              {
                print("ERROR_EMAIL_ALREADY_IN_USE");
              }
              break;
            case "ERROR_WEAK_PASSWORD":
              {
                print("ERROR_WEAK_PASSWORD");
              }
              break;
            default:
              {
                print("Try Again");
              }
          }
        }
    return user;
  }
}
