import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/basic_utils.dart';

class FirebaseStorageUtils {
  final storage = FirebaseStorage.instance;
  String curUserUid = BasicUtils().curUserUid;
  uploadImage(dynamic image) async {
    if (image == null) return;
    final destination = 'profPics/$curUserUid';
    final ref = FirebaseStorage.instance.ref(destination);
    ref.putFile(image).then((p0) async {
      p0.ref.getDownloadURL().then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(curUserUid)
            .update({'profPicUrl': value});
      });
    });
  }
}
