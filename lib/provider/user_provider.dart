import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      password: '',
      address: '',
      token: '',
      id: '',
      email: '',
      name: '',
      type: '',
      cart: []);

  User get user => _user;
  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
