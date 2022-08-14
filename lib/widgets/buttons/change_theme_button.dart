import 'package:finalmade/components/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

//button to change theme, uses provider
// ignore: use_key_in_widget_constructors
class ChangeThemeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
        showSnackBar(
            context,
            themeProvider.isDarkMode
                ? 'Theme changed to dark mode'
                : 'Theme changed to light mode');
      },
    );
  }
}
