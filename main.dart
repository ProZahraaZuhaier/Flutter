import 'package:fitnessapp/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:fitnessapp/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool seen = prefs.getBool('seen');
  Widget _screen;
  if (seen == null || seen == false) {
    _screen = OnBoarding();
  } else {
    _screen = HomeScreen();
  }

  runApp(FitnessApp(_screen));
}

class FitnessApp extends StatelessWidget {
  final Widget _screen;
  FitnessApp(this._screen);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: this._screen,
    );
  }
}
