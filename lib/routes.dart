import 'package:flutter/material.dart';
import 'package:edumarshal/screens/home/home_screen.dart';
import 'package:edumarshal/screens/login/login_screen.dart';
import 'package:edumarshal/screens/welcome/welcome_screen.dart';


final routes = {
  '/login':         (BuildContext context) => new LoginScreen(),
  '/home':         (BuildContext context) => new HomeScreen(),
  '/welcome':        (BuildContext context) => new WelComeScreen(),
  '/' :          (BuildContext context) => new LoginScreen(),
};