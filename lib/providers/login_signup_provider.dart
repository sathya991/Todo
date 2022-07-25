import 'package:flutter/material.dart';
import 'package:todo/widgets/login.dart';
import 'package:todo/widgets/signup.dart';

class LoginSignupProvider extends ChangeNotifier {
  Widget _widget = LoginWidget();

  Widget get curWidget => _widget;
  String _curText = "Sign up here";

  String get curText => _curText;
  loginOrSignupChange(bool isLogin) {
    if (isLogin) {
      _widget = SignupWidget();
      _curText = "Login here";
    } else {
      _widget = LoginWidget();
      _curText = "Sign up here";
    }
    notifyListeners();
  }
}
