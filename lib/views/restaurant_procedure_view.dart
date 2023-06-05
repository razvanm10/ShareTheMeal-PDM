import "package:flutter/material.dart";

class RestaurantProcedureView extends StatefulWidget {
  const RestaurantProcedureView({Key? key}) : super(key: key);

  @override
  State<RestaurantProcedureView> createState() => _RestaurantProcedureViewState();
}

class _RestaurantProcedureViewState extends State<RestaurantProcedureView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("CourierView"),
        ),
        body: Container()
    );
  }
}
