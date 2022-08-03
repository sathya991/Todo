import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo/utils/basic_utils.dart';
import 'package:todo/utils/security_utils.dart';

class DashboardUtils {
  ListTile listTileStyle(String text, dynamic func) {
    return ListTile(
      title: Text(
        text,
        style: GoogleFonts.rubik(fontSize: 18.5.sp),
      ),
      trailing: const FaIcon(
        FontAwesomeIcons.angleRight,
      ),
      onTap: func,
    );
  }

  logoutFunction(BuildContext context) {
    FirebaseAuth.instance.signOut().then((value) {
      SecureStorage.delete();
      Navigator.of(context).pushNamed('/');
    });
  }
}
