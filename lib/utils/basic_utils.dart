import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

class BasicUtils {
  Color get allColor => const Color.fromRGBO(132, 85, 246, 1);

  Color get urgentColor => const Color.fromRGBO(199, 52, 69, 1);
  Color get mediumColor => const Color.fromRGBO(240, 240, 58, 1);
  Color get leisureColor => const Color.fromRGBO(59, 169, 237, 1);
  String get curUserUid => FirebaseAuth.instance.currentUser!.uid;

  TextStyle get buttonTextStyle =>
      GoogleFonts.rubik(fontSize: 18, color: Colors.white);

  TextStyle get mediumButtonTextStyle =>
      GoogleFonts.rubik(fontSize: 18, color: Colors.black);
}
