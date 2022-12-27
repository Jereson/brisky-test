import 'package:briskit/getit.dart';
import 'package:briskit/screens/auth/login_screens.dart';
import 'package:briskit/utils/base_view_modal.dart';
import 'package:briskit/utils/color_util.dart';
import 'package:briskit/utils/text_style.dart';
import 'package:briskit/viewModel/auth_view_model.dart';
import 'package:briskit/widgets/custom_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EmailVerificationScreen extends StatelessWidget {
  static const routeName = 'email-verification';
  const EmailVerificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        backgroundColor: kcEEEDED,
      ),
      body: BaseViewBuilder<AuthViewModel>(
          model: getIt(),
          initState: (init) {
            Future.delayed(Duration.zero, () {
              init.verifyUserEmail(context);
            });
          },
          builder: (aVm, _) {
            return aVm.verifyEmailSent
                ? Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'An email containing verification link has been sent to the account $email, please follow the link with the instruction to verify your account',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 50),
                          CustomButtonWidget(
                              title: 'I am now verified',
                              callback: () => Navigator.of(context)
                                  .pushNamed(LoginScreen.routeName)),
                          Container(
                            alignment: Alignment.bottomRight,
                            height: 30,
                            child: RichText(
                              text: TextSpan(
                                  text: "Have not gotten email? ",
                                  children: [
                                    TextSpan(
                                        text: 'Resend',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            aVm.verifyUserEmail(context);
                                          },
                                        style: textfieldStyle.copyWith(
                                            color: kc14390246)),
                                  ],
                                  style: textfieldStyle),
                            ),
                          ),
                        ]),
                  )
                : Center(
                    child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            color: kc14390246,
                            borderRadius: BorderRadius.circular(10)),
                        child: const SpinKitDualRing(
                          color: kcWhite,
                        )));
          }),
    );
  }
}
