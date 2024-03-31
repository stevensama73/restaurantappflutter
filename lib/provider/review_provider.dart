import 'package:flutter/material.dart';

class ReviewProvider extends ChangeNotifier {
  bool _nama = true;
  bool _review = true;

  bool get nama => _nama;
  bool get review => _review;

  void checkNama(String value) {
    if (value.length == 0) {
      _nama = false;
      notifyListeners();
    } else {
      _nama = true;
      notifyListeners();
    }
  }

  void checkReview(String value) {
    if (value.length == 0) {
      _review = false;
      notifyListeners();
    } else {
      _review = true;
      notifyListeners();
    }
  }
}