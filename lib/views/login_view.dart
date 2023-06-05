import 'package:flutter/material.dart';
import 'package:pdm_project/views/restaurant_view.dart';

import '../service/auth_service.dart';
import '../types/user_roles.dart';
import 'courier_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  AuthService authService = AuthService();

  void showOptionsPopupAndReturnOption(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('I want to be a Courier'),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CourierView()));
                    await authService.assignRole(UserRoles.Courier);
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text('I am a restaurant and I want to help'),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RestaurantView()));
                    await authService.assignRole(UserRoles.Restaurant);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Share The Meal"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return Theme.of(context).primaryColor;
                    },
                  ),
                ),
                onPressed: () async {
                  await authService.signIn().then((value) async => {
                        if (await authService.isSignedIn() == true)
                          {
                            if (await authService.getUserRole() == null)
                              {showOptionsPopupAndReturnOption(context)}
                            else
                              {
                                if ((await authService.currentUserDetails())
                                        .role ==
                                    UserRoles.Courier)
                                  {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CourierView()))
                                  }
                                else
                                  {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RestaurantView()))
                                  }
                              }
                          }
                      });
                },
                child: const Text("Sign In")),
          ],
        ),
      ),
    );
  }
}
