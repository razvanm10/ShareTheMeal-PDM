import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pdm_project/model/user.dart';
import 'package:pdm_project/service/auth_service.dart';
import 'package:pdm_project/types/user_roles.dart';
import 'package:pdm_project/views/courier_view.dart';
import 'package:pdm_project/views/login_view.dart';
import 'package:pdm_project/views/restaurant_view.dart';
import 'firebase_options.dart';

var acs = ActionCodeSettings(
    // URL you want to redirect back to. The domain (www.example.com) for this
    // URL must be whitelisted in the Firebase Console.
    url: 'ws://127.0.0.1:61591/imshwwvr0Ag=/ws',
    // This must be true
    handleCodeInApp: true,
    androidPackageName: 'com.example.pdm_project',
    // installIfNotAvailable
    androidInstallApp: true,
    // minimumVersion
    androidMinimumVersion: '21');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.dark,
          primaryColor: Colors.amber,

          // Define the default font family.
          fontFamily: 'Georgia',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme()),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserRecord>(
        future: authService.currentUserDetails(),
        builder: (BuildContext context, AsyncSnapshot<UserRecord> response) {
          UserRecord currentUser = response.data ?? UserRecord();
          if (currentUser.isSignedIn == true) {
            switch (currentUser.role) {
              case UserRoles.Courier:
                {
                  return const CourierView();
                }
              case UserRoles.Restaurant:
                {
                  return const RestaurantView();
                }
              case null:
                {
                  return const LoginView();
                }
            }
          } else {
            return const LoginView();
          }
        });
  }
}
