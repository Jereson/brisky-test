import 'package:briskit/getit.dart';
import 'package:briskit/screens/auth/login_screens.dart';
import 'package:briskit/utils/base_view_modal.dart';
import 'package:briskit/utils/color_util.dart';
import 'package:briskit/utils/form_decoration_util.dart';
import 'package:briskit/utils/image_utils.dart';
import 'package:briskit/utils/text_style.dart';
import 'package:briskit/viewModel/auth_view_model.dart';
import 'package:briskit/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = 'signup-screen';
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcEEEEEE,
      appBar: AppBar(
        backgroundColor: kcEEEEEE,
        elevation: 0.0,
      ),
      body: BaseViewBuilder<AuthViewModel>(
          model: getIt(),
          builder: (aVm, _) {
            return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        imgLogo,
                                      ),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        controller: aVm.userNameContoller,
                        validator: aVm.customValidator.nameValidator,
                        decoration: borderTextInputDecoration.copyWith(
                            hintText: 'USERNAME'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: aVm.signUpEmailContoller,
                        validator: aVm.customValidator.emailValidator,
                        keyboardType: TextInputType.emailAddress,
                        decoration: borderTextInputDecoration.copyWith(
                            hintText: 'EMAIL'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: aVm.phoneNumberContoller,
                        keyboardType: TextInputType.phone,
                        validator: aVm.customValidator.phoneNumberValidator,
                        decoration: borderTextInputDecoration.copyWith(
                            hintText: 'PHONE NUMBER'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: aVm.signUpPasswordContoller,
                        validator: aVm.customValidator.passwordValidator,
                        decoration: borderTextInputDecoration.copyWith(
                            hintText: 'PASSWORD'),
                        obscureText: true,
                      ),
                      const SizedBox(height: 60),
                      CustomButtonWidget(
                          callback: () {
                            if (!formKey.currentState!.validate()) return;
                            aVm.signupUser(context);
                          },
                          title: 'SIGN UP'),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 30,
                        child: RichText(
                          text: TextSpan(
                              text: "Already have an account? ",
                              children: [
                                TextSpan(
                                    text: 'Sign In',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context)
                                            .pushNamed(LoginScreen.routeName);
                                      },
                                    style: st000D0940013.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: kc14390246)),
                              ],
                              style: st000D0940013),
                        ),
                      ),
                    ],
                  ),
                ));
          }),
    );
  }
}


