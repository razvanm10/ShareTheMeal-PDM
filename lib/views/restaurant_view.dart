import 'package:flutter/material.dart';

class RestaurantView extends StatelessWidget {
  const RestaurantView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CourierView"),
      ),
      body: Container(
        child: Text("Restaurant View"),
      ),
    );
  }
}
