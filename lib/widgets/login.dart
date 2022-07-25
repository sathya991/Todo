import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/screens/dashboard.dart';
import 'package:todo/utils/form_utils.dart';
import 'package:todo/utils/security_utils.dart';

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
        SecureStorage.setUserName(value.get('userName'));
      });
    }

    loginFunction() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password)
            .then((value) {
          storeUserName(value.user!.uid);
          SecureStorage.setPassword(_password);
          Navigator.of(context).pushNamedAndRemoveUntil(
              Dashboard.dashboardRoute, (route) => false);
        });
      }
    }

    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: FormUtils().formDecoration("Email"),
              validator: (txt) => FormUtils().emailValidation(txt!),
              onSaved: (emailText) {
                _email = emailText!;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: FormUtils().formDecoration("Password"),
              validator: (txt) => FormUtils().passwordValidate(txt!),
              onSaved: (passwordText) {
                _password = passwordText!;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                style: FormUtils().elevatedButtonStyle(),
                onPressed: loginFunction,
                child: const Text("Login")),
          ],
        ));
  }
}
