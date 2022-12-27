import 'package:briskit/screens/auth/login_screens.dart';
import 'package:briskit/screens/email_verification_screen.dart';
import 'package:briskit/screens/nav_page.dart';
import 'package:briskit/utils/basic_utils.dart';
import 'package:briskit/utils/custom_validator.dart';
import 'package:briskit/utils/error_code.dart';
import 'package:briskit/utils/flushbar_util.dart';
import 'package:briskit/viewModel/base_view_model.dart';
import 'package:briskit/widgets/custom_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

class AuthViewModel extends BaseViewModel {
  bool verifyEmailSent = false;

  //Initialize all clogin controller
  final loginEmailContoller = TextEditingController();
  final loginPasswordContoller = TextEditingController();

  //Initialize all singup controller
  final signUpEmailContoller = TextEditingController();
  final userNameContoller = TextEditingController();
  final signUpPasswordContoller = TextEditingController();
  final phoneNumberContoller = TextEditingController();

  //Get all controller custom validator
  final CustomValidator customValidator = CustomValidator();

  //Sign up user with firebase
  Future<void> signupUser(BuildContext context, [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
    try {
      progressDialog.show();
      final credential =
          await firebaseAuthInstance.createUserWithEmailAndPassword(
              email: signUpEmailContoller.text,
              password: signUpPasswordContoller.text);
      if (credential.user != null) {
        if (!mounted) return;
        //Call user add function on succesull signup
        await addUser(context, credential.user!.uid);

        // logger.d(credential);
      }
    } on FirebaseAuthException catch (error) {
      firebaseErrorCode(context, error.code);
      progressDialog.dismiss();
      setState();
      logger.d(error);
    } catch (e) {
      otherExeption(context, e);
      progressDialog.dismiss();
      setState();
      logger.d(e);
    }
  }

  //Add user after sunccessful sign up
  Future<void> addUser(BuildContext context, String uid) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
    final data = <String, dynamic>{
      'userId': uid,
      'username': userNameContoller.text,
      'email': signUpEmailContoller.text,
      'phone': phoneNumberContoller.text,
      'profilePic': profilePic,
      'favorite': []
    };
    logger.d(data);

    await firestore.collection('user').doc(uid).set(data).then((value) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          EmailVerificationScreen.routeName, (route) => false,
          arguments: signUpEmailContoller.text);
      progressDialog.dismiss();
    }).onError((error, stackTrace) {
      progressDialog.dismiss();
      flushbar(
          context: context,
          title: 'Failed',
          message: error.toString(),
          isSuccess: false);
    });
  }

//Sign in user
  Future<void> signinUser(BuildContext context, [bool mounted = true]) async {
    CustomProgressDialog progressDialog = CustomProgressDialog(context,
        blur: 2, loadingWidget: const CustomLoader(), dismissable: false);
    try {
      logger.d(loginPasswordContoller.text);
      progressDialog.show();
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: loginEmailContoller.text,
              password: loginPasswordContoller.text);

      progressDialog.dismiss();

      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          if (!mounted) return;
          Navigator.of(context)
              .pushNamedAndRemoveUntil(NavPageView.routeName, (route) => false);
        } else {
          if (!mounted) return;
          Navigator.of(context).pushNamedAndRemoveUntil(
              EmailVerificationScreen.routeName, (route) => false,
              arguments: userCredential.user!.email);
        }
      }
    } on FirebaseAuthException catch (error) {
      progressDialog.dismiss();
      firebaseErrorCode(context, error.code);
      logger.d(error);
    } catch (e) {
      logger.d(e);
      otherExeption(context, e);
      progressDialog.dismiss();
    }
  }

//Verify user with firebase email link service
  Future<void> verifyUserEmail(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    verifyEmailSent = false;
    setState();
    try {
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        verifyEmailSent = true;
        setState();
      }
    } on FirebaseAuthException catch (error) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
      firebaseErrorCode(context, error.code);
    } catch (e) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
      otherExeption(context, e);
    }
  }

  //Route user to specific screen base on login state
  Future<void> getInitScreen(BuildContext context,
      [bool mounted = true]) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
      } else if (user.emailVerified) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(NavPageView.routeName, (route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            EmailVerificationScreen.routeName, (route) => false,
            arguments: user.email);
      }
    });
  }
}
