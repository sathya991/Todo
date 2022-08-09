import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/providers/login_signup_provider.dart';
import 'package:todo/screens/dashboard.dart';
import 'package:todo/utils/form_utils.dart';
import 'package:todo/utils/security_utils.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _email = "";
    String _password = "";

    storeUserName(String uid) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value) {
        SecureStorage.setUserName(value.get('userName')).then((value) {
          SecureStorage.setPassword(_password);
          Navigator.of(context).pushNamedAndRemoveUntil(
              Dashboard.dashboardRoute, (route) => false);
        });
      });
    }

    loginFunction() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _email.trim(), password: _password.trim())
            .then((value) {
          storeUserName(value.user!.uid);
        });
      }
    }

    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration:
                  FormUtils().formDecoration("Email", false, () {}, true),
              validator: (txt) => FormUtils().emailValidation(txt!),
              onSaved: (emailText) {
                _email = emailText!;
              },
            ),
            SizedBox(
              height: 1.5.h,
            ),
            TextFormField(
              decoration: FormUtils().formDecoration(
                  "Password",
                  true,
                  () => context.read<LoginSignupProvider>().toggleVisibility(),
                  context.watch<LoginSignupProvider>().passwordNotVisibile),
              validator: (txt) => FormUtils().passwordValidate(txt!),
              obscureText:
                  context.watch<LoginSignupProvider>().passwordNotVisibile
                      ? true
                      : false,
              onSaved: (passwordText) {
                _password = passwordText!;
              },
            ),
            SizedBox(
              height: 1.5.h,
            ),
            ElevatedButton(
                style: FormUtils().elevatedButtonStyle(),
                onPressed: loginFunction,
                child: const Text("Login")),
          ],
        ));
  }
}
