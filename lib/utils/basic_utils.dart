import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

class BasicUtils {
  Color get allColor => const Color.fromRGBO(132, 85, 246, 1);
  String get curUserUid => FirebaseAuth.instance.currentUser!.uid;

  TextStyle get reverseButtonTextStyle =>
      GoogleFonts.rubik(fontSize: 18, color: BasicUtils().allColor);
}
