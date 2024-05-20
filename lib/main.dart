import 'package:flutter/material.dart';
import 'pages/navigation.dart';
import 'pages/login.dart';
import 'pages/register.dart';
import 'helper/database_helper.dart';

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: SplashScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => NavigationPage(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder<bool>(
          future: _checkLoginStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              if (snapshot.hasData && snapshot.data!) {
                return NavigationPage();
              } else {
                return LoginPage();
              }
            }
          },
        ),
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    bool isLoggedIn = await DatabaseHelper().isLoggedIn();
    return isLoggedIn;
  }
}
