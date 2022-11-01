import 'package:country_code_picker/country_code_picker.dart';
import 'package:cybehawks/auth/auth_bloc.dart';
import 'package:cybehawks/components/primary_button.dart';
import 'package:cybehawks/controller/auth.dart';
import 'package:cybehawks/pages/pin_code_verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? dialCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: Alignment.center,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              const Text(
                'Sign in',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text('Sign in now to access latest news.'),
              const SizedBox(
                height: 24,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: CountryCodePicker(
                        onChanged: (code) {
                          setState(() {
                            dialCode = code.dialCode;
                          });
                        },
                        padding: EdgeInsets.zero,
                        showDropDownButton: true,
                        initialSelection: 'IN',
                        showFlagDialog: false,
                        onInit: (code) {
                          dialCode = dialCode = code!.dialCode;
                        },
                      ),
                    ),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.50),
                        ),
                      ),
                      validator: (value) {
                        bool phoneValid = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                            .hasMatch(value!);

                        if (value.isEmpty) {
                          return 'Please Enter Phone Number';
                        }
                        if (!phoneValid) {
                          return 'Please Enter Valid Phone Number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        text: 'Login',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => PinCodeVerificationScreen(
                                  dialCode!.trim() + _phoneController.text,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 54,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 4,
                  children: [
                    ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        minimumSize: MaterialStateProperty.all(
                          const Size(300, 40),
                        ),
                      ),
                      onPressed: () async {
                        await Provider.of<AuthController>(context,
                                listen: false)
                            .loginWithGoogle();
                      },
                      icon: SizedBox(
                        height: 30,
                        child: Image.asset('assets/images/google.png'),
                      ),
                      label: const Text(
                        'Sign in with Google',
                        style: TextStyle(color: Color(0xff81868B)),
                      ),
                    ),
                    // SizedBox(
                    //   height: 30,
                    //   width: 300,
                    //   child: SignInWithAppleButton(onPressed: () async {
                    //     final credentials =
                    //         await SignInWithApple.getAppleIDCredential(scopes: [
                    //       AppleIDAuthorizationScopes.email,
                    //       AppleIDAuthorizationScopes.fullName
                    //     ]);
                    //     debugPrint(credentials.email);
                    //     debugPrint(credentials.state);
                    //     OAuthProvider oAuthProvider =
                    //         OAuthProvider("apple.com");
                    //     final AuthCredential credential =
                    //         oAuthProvider.credential(
                    //       idToken: String.fromCharCodes(
                    //           credentials.identityToken!.codeUnits),
                    //       accessToken: String.fromCharCodes(
                    //           credentials.authorizationCode.codeUnits),
                    //     );
                    //     await FirebaseAuth.instance
                    //         .signInWithCredential(credential);

//                       try {
//
//                         // final AuthorizationResult result = await AppleSignIn.performRequests([
//                         //   AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
//                         // ]);
//                         // result=credentials.
//                         AuthorizationCredentialAppleID
//
//                         switch (result.status) {
//                           case AuthorizationStatus.authorized:
//                             try {
//                               print("successfull sign in");
//                               final AppleIdCredential appleIdCredential = result.credential;
//
//                               OAuthProvider oAuthProvider =
//                               new OAuthProvider(providerId: "apple.com");
//                               final AuthCredential credential = oAuthProvider.getCredential(
//                                 idToken:
//                                 String.fromCharCodes(appleIdCredential.identityToken),
//                                 accessToken:
//                                 String.fromCharCodes(appleIdCredential.authorizationCode),
//                               );
//
//                               final AuthResult _res = await FirebaseAuth.instance
//                                   .signInWithCredential(credential);
//
//                               FirebaseAuth.instance.currentUser().then((val) async {
//                                 UserUpdateInfo updateUser = UserUpdateInfo();
//                                 updateUser.displayName =
//                                 "${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}";
//                                 updateUser.photoUrl =
//                                 "define an url";
//                                 await val.updateProfile(updateUser);
//                               });
//
//                             } catch (e) {
//                               print("error");
//                             }
//                             break;
//                           case AuthorizationStatus.error:
//                           // do something
//                             break;
//
//                           case AuthorizationStatus.cancelled:
//                             print('User cancelled');
//                             break;
//                         }
//                       } catch (error) {
//                         print("error with apple sign in");
//                       }
                    // }),
                    // ),

                    // ElevatedButton.icon(
                    //   style: ButtonStyle(
                    //     backgroundColor:
                    //         MaterialStateProperty.all(Colors.white),
                    //     minimumSize: MaterialStateProperty.all(
                    //       const Size(240, 40),
                    //     ),
                    //   ),
                    //   onPressed: () {},
                    //   icon: SizedBox(
                    //     height: 30,
                    //     child: Image.asset('assets/images/apple.png'),
                    //   ),
                    //   label: const Text(
                    //     'Sign in with Apple',
                    //     style: TextStyle(color: Color(0xff81868B)),
                    //   ),
                    // ),
                    // ],
                    // ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
