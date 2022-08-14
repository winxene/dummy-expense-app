import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  //logic to trigger dark ode
  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  //toggle theme
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    //playing with the theme using the themeMode
    notifyListeners();
  }
}

//define each specs needed for the Available theme, all of the colors are defined in here
class AvailableTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.teal,
    primarySwatch: Colors.teal,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
  );
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.teal,
    primarySwatch: Colors.teal,
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
    iconTheme: const IconThemeData(color: Colors.black, opacity: 0.8),
  );
}
