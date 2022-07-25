import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/utils/basic_style_utils.dart';

class FormUtils {
  formDecoration(String hintText) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            const BorderSide(width: 3, color: Color.fromRGBO(241, 238, 249, 1)),
      ),
      hintText: hintText,
      hintStyle: GoogleFonts.rubik(fontSize: 17, fontWeight: FontWeight.w400),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: BasicStyleUtils().allColor),
          borderRadius: BorderRadius.circular(14)),
    );
  }

  elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
        textStyle: GoogleFonts.rubik(fontSize: 17),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));
  }

  emailValidation(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (email.isEmpty || !emailValid) {
      return "Please enter a valid email";
    }
    return null;
  }

  userNameValidation(String userName) {
    if (userName.isEmpty) {
      return "Please enter a valid username";
    } else if (userName.length < 4 || userName.length > 16) {
      return "Username length should be between 4 and 16";
    }
    return null;
  }

  String? passwordValidate(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Password should contain at least one upper case\nPassword should contain at least one lower case\nPassword should contain at least one digit\nPassword should contain at least one Special character\nPassword Must be at least 8 characters in length';
      } else {
        return null;
      }
    }
  }
}
