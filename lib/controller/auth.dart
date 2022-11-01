import 'package:cybehawks/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';

class AuthController extends ChangeNotifier {
  final googleSignin = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  GoogleSignInAccount? _user = null;
  GoogleSignInAccount? get user => _user;

  Future loginWithGoogle() async {
    try {
      final googleUser = await googleSignin.signIn();
      if (googleUser != null) {
        _user = googleUser;
        notifyListeners();
      } else {
        return;
      }
      final googleAuth = await googleUser.authentication;
      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credentials);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> logoutGoogleAcc() async {
    await googleSignin.disconnect();
    _auth.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> logoutPhoneUser() async {
    _auth.signOut();
  }

  Future<void> loginWithPhone(String phone) async {
    await _auth.signInWithPhoneNumber(
      phone,
      // RecaptchaVerifier(
      //   container: 'recaptcha',
      //   size: RecaptchaVerifierSize.compact,
      //   theme: RecaptchaVerifierTheme.dark,
      //   auth: FirebaseAuth.instanceFor(app: Firebase.app())
      // ),
    );
  }

  String? _verificationCode;
  String get verificationCode => _verificationCode!;

  Future<void> verifyPhone(String phoneno) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneno,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential).then((value) async {
          if (value.user != null) {
            debugPrint('User Logged in');
          }
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          debugPrint('The provided phone number is not valid.');
        }
        debugPrint(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationCode = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> addUserDetails(
      String email, String username, String password, User user) async {
    await user.updateDisplayName(username);
    await user.updateEmail(email);
    await user.updatePassword(password);
  }
//
//   Future<User> signInWithApple({List<Scope> scopes = const []}) async {
//     // 1. perform the sign-in request
//     final result = await AppleS.performRequests(
//         [AppleIdRequest(requestedScopes: scopes)]);
//     // 2. check the result
//     switch (result.status) {
//       case AuthorizationStatus.authorized:
//         final appleIdCredential = result.credential!;
//         final oAuthProvider = OAuthProvider('apple.com');
//         final credential = oAuthProvider.credential(
//           idToken: String.fromCharCodes(appleIdCredential.identityToken!),
//           accessToken:
//           String.fromCharCodes(appleIdCredential.authorizationCode!),
//         );
//         final userCredential =
//         await _firebaseAuth.signInWithCredential(credential);
//         final firebaseUser = userCredential.user!;
//         if (scopes.contains(Scope.fullName)) {
//           final fullName = appleIdCredential.fullName;
//           if (fullName != null &&
//               fullName.givenName != null &&
//               fullName.familyName != null) {
//             final displayName = '${fullName.givenName} ${fullName.familyName}';
//             await firebaseUser.updateDisplayName(displayName);
//           }
//         }
//         return firebaseUser;
//       case AuthorizationStatus.error:
//         throw PlatformException(
//           code: 'ERROR_AUTHORIZATION_DENIED',
//           message: result.error.toString(),
//         );
//
//       case AuthorizationStatus.cancelled:
//         throw PlatformException(
//           code: 'ERROR_ABORTED_BY_USER',
//           message: 'Sign in aborted by user',
//         );
//       default:
//         throw UnimplementedError();
//     }
//   }
// }
}
