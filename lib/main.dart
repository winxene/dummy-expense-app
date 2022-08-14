import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/transaction_provider.dart';

import '../screens/overview_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); //needed for the theme provider
  runApp(PersonalExpensesApp());
}

// ignore: use_key_in_widget_constructors
class PersonalExpensesApp extends StatefulWidget {
  @override
  State<PersonalExpensesApp> createState() => _PersonalExpensesAppState();
}

class _PersonalExpensesAppState extends State<PersonalExpensesApp> {
  //darkMode Light mode changer
  bool isDarkModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => TransactionProvider(),
        ),
      ],
      builder: (context, child) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          title: 'My Personal Expenses App',
          themeMode: themeProvider.themeMode,
          theme: AvailableTheme.lightTheme,
          darkTheme: AvailableTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          home: const OverviewScreen(),
        );
      },
    );
  }
}
