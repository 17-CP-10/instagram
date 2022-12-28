import 'package:flutter/material.dart';
import 'package:instagramclone/resources/auth_methods.dart';

import '../models/user.dart';
class UserProvider with ChangeNotifier{
User? _user;
final AuthMethods authMethods=AuthMethods();
User get getUser =>_user!;
Future<void> refreshUser() async {
User user=await authMethods.getUserDetails();
_user=user;
notifyListeners();
}
}