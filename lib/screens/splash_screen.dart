import 'package:briskit/getit.dart';
import 'package:briskit/utils/base_view_modal.dart';
import 'package:briskit/viewModel/auth_view_model.dart';
import 'package:briskit/widgets/custom_loader.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: BaseViewBuilder<AuthViewModel>(
            model: getIt(),
            initState: (init) {
              //Route the specific screen on user auth condition
              init.getInitScreen(context);
            },
            builder: (aVm, _) {
              return const CustomLoader();
            }));
  }
}

