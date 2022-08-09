import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/providers/login_signup_provider.dart';
import 'package:todo/screens/dashboard.dart';
import 'package:todo/utils/form_utils.dart';
import 'package:todo/utils/security_utils.dart';

class SignupWidget extends StatelessWidget {
  SignupWidget({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String _email = "";
    String _userName = "";
    String _password = "";
    signUpFunction() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        try {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email.trim(), password: _password.trim())
              .then((value) async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(value.user!.uid)
                .set(
                    {'userName': _userName, 'email': _email, 'profPicUrl': ""});
          }).then((value) async {
            SecureStorage.setUserName(_userName);
            SecureStorage.setPassword(_password);
            Navigator.of(context).pushNamedAndRemoveUntil(
                Dashboard.dashboardRoute, (route) => false);
          });
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
        } catch (e) {
          print(e);
        }
      }
    }

    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration:
                  FormUtils().formDecoration("Email", false, () {}, true),
              onSaved: (emailText) {
                _email = emailText!;
              },
              validator: (txt) => FormUtils().emailValidation(txt!),
            ),
            SizedBox(
              height: 1.4.h,
            ),
            TextFormField(
              decoration:
                  FormUtils().formDecoration("Username", false, () {}, true),
              onSaved: (usernameText) {
                _userName = usernameText!;
              },
              validator: (txt) => FormUtils().userNameValidation(txt!),
            ),
            SizedBox(
              height: 1.4.h,
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
              height: 1.4.h,
            ),
            ElevatedButton(
                style: FormUtils().elevatedButtonStyle(),
                onPressed: signUpFunction,
                child: const Text("Sign up")),
          ],
        ));
  }
}
