import 'package:briskit/model/user_model.dart';
import 'package:briskit/widgets/custom_loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

enum ViewState { busy, done, error, none, noInternet }

class BaseViewModel with ChangeNotifier {
  UserModel? cachedUserModel;
  ViewState viewState = ViewState.none;
  String viewMessage = '';
  String errorMessage = '';
  bool _disposed = false;

  //Firebase Instance
  final firebaseAuthInstance = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  CustomProgressDialog progressDialog(BuildContext context) =>
      CustomProgressDialog(context,
          blur: 2, loadingWidget: const CustomLoader(), dismissable: false);

  bool get hasEncounteredError =>
      viewState == ViewState.error || viewState == ViewState.noInternet;
  bool get isBusy => viewState == ViewState.done;

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }

  void setState({ViewState? viewState, String? viewMessage}) {
    if (viewState != null) this.viewState = viewState;
    if (viewMessage != null) this.viewMessage = viewMessage;
    if (!_disposed) notifyListeners();
  }

//Geting user details function
  Future<void> userDetail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final vendorDoc =
          await firestore.collection('vendor').doc(user.uid).get();
      
      final result = UserModel.fromJson(vendorDoc.data()!);
      cachedUserModel = result;
      setState();
    }
  }
}
