import 'package:briskit/getit.dart';
import 'package:briskit/screens/auth/signup_screen.dart';
import 'package:briskit/utils/base_view_modal.dart';
import 'package:briskit/utils/color_util.dart';
import 'package:briskit/utils/form_decoration_util.dart';
import 'package:briskit/utils/image_utils.dart';
import 'package:briskit/utils/text_style.dart';
import 'package:briskit/viewModel/auth_view_model.dart';
import 'package:briskit/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                        height: MediaQuery.of(context).size.height * 0.4,
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
                        controller: aVm.loginEmailContoller,
                        keyboardType: TextInputType.emailAddress,
                        validator: aVm.customValidator.emailValidator,
                        decoration: borderTextInputDecoration.copyWith(
                            hintText: 'EMAIL'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: aVm.loginPasswordContoller,
                        validator: aVm.customValidator.passwordValidator,
                        decoration: borderTextInputDecoration.copyWith(
                            hintText: 'PASSWORD'),
                        obscureText: true,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          child: Transform.translate(
                              offset: const Offset(10, 0),
                              child: const Text(
                                'FORGOT PASSWORD?',
                                style: TextStyle(color: Colors.black87),
                              )),
                          onPressed: () {
                            //TODO: Route to forgort password screen
                            print('Pressed');
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      CustomButtonWidget(
                          callback: () {
                            if (!formKey.currentState!.validate()) return;
                            aVm.signinUser(context);
                          },
                          title: 'SIGN IN'),
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: 30,
                        child: RichText(
                          text: TextSpan(
                              text: "Don't  have an account? ",
                              children: [
                                TextSpan(
                                    text: 'Sign Up',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context)
                                            .pushNamed(SignupScreen.routeName);
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
