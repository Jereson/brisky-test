import 'package:briskit/screens/auth/login_screens.dart';
import 'package:briskit/screens/auth/signup_screen.dart';
import 'package:briskit/screens/email_verification_screen.dart';
import 'package:briskit/screens/nav_page.dart';
import 'package:briskit/screens/post_over_view.dart';
import 'package:flutter/material.dart';

final routes = <String, WidgetBuilder>{
  LoginScreen.routeName: (_) => const LoginScreen(),
  SignupScreen.routeName: (_) => const SignupScreen(),
  PostOverviewScreen.routeName: (_) => const PostOverviewScreen(),
  EmailVerificationScreen.routeName: (_) => const EmailVerificationScreen(),
  NavPageView.routeName: (_) => const NavPageView(),
  
};
