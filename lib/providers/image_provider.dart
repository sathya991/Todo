import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class RandomImageProvider extends ChangeNotifier {
  String _imageUrl = "";
  String get imageUrl => _imageUrl;

  getRandomImage() async {
    _imageUrl = "";
    var url = Uri.parse(
        "https://api.unsplash.com/photos/random/?client_id=c-T-bWkQO_WyhmghtbNv0-vzSksGScug73oAYjMEHdE");
    final res = await http.get(url);
    var urlData = jsonDecode(res.body);
    if (urlData['width'] > urlData['height']) {
      _imageUrl = urlData['urls']['full'];
    } else {
      getRandomImage();
    }
    notifyListeners();
  }
}
