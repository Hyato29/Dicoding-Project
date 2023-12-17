import 'package:flutter/material.dart';
import 'package:restaurant_v2/common/text_theme.dart';
import 'package:restaurant_v2/ui/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: myTextTheme,
      ),
      home: const SplashScreen(),
    );
  }
}
