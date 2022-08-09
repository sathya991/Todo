import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/utils/basic_utils.dart';
import 'package:provider/provider.dart';

class FormUtils {
  formDecoration(String hintText, bool isPassword, Function() f,
      bool passwordNotVisibile) {
    return InputDecoration(
      suffixIcon: isPassword
          ? IconButton(
              onPressed: f,
              icon: passwordNotVisibile
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility))
          : const SizedBox.shrink(),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(1.h),
        borderSide: BorderSide(
            width: 0.8.w, color: const Color.fromRGBO(241, 238, 249, 1)),
      ),
      hintText: hintText,
      hintStyle:
          GoogleFonts.rubik(fontSize: 18.sp, fontWeight: FontWeight.w400),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: BasicUtils().allColor),
          borderRadius: BorderRadius.circular(1.h)),
    );
  }

  elevatedButtonStyle() {
    return ElevatedButton.styleFrom(
        textStyle: GoogleFonts.rubik(fontSize: 18.sp),
        padding: EdgeInsets.fromLTRB(4.2.w, 1.h, 4.2.w, 1.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.h)));
  }

  mediumButtonStyle() {
    return ElevatedButton.styleFrom(
        primary: BasicUtils().mediumColor,
        padding: EdgeInsets.fromLTRB(4.2.w, 1.h, 4.2.w, 1.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.h)));
  }

  urgentButtonStyle() {
    return ElevatedButton.styleFrom(
        primary: BasicUtils().urgentColor,
        padding: EdgeInsets.fromLTRB(4.2.w, 1.h, 4.2.w, 1.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.h)));
  }

  leisureButtonStyle() {
    return ElevatedButton.styleFrom(
        primary: BasicUtils().leisureColor,
        padding: EdgeInsets.fromLTRB(4.2.w, 1.h, 4.2.w, 1.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.h)));
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
