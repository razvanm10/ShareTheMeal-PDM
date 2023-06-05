import 'package:flutter/material.dart';
import 'package:pdm_project/widgets/timisoara_map.dart';

class CourierView extends StatefulWidget {
  const CourierView({Key? key}) : super(key: key);

  @override
  State<CourierView> createState() => _CourierViewState();
}

class _CourierViewState extends State<CourierView> {
  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void mapResize() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CourierView"),
      ),
      body: TimisoaraMap(resize: mapResize),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              label: "Restaurants",
              icon: Icon(Icons.restaurant_rounded)),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              label: "Locations",
              icon: Icon(Icons.place_outlined))
        ],
      ),
    );
  }
}
