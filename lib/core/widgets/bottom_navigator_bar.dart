import 'package:flutter/material.dart';
import 'package:restart_project/core/utils/app_config.dart';
import 'package:restart_project/view/dashboard/dashboard_selection_route.dart';
import 'package:restart_project/view/dashboard/dashboard_view.dart';
import 'package:restart_project/view/dashboard/dashboard_view_detail_route.dart';
import 'package:restart_project/view/maps/maps_view.dart';
import 'package:restart_project/view/profile/profile_view.dart';
import 'package:restart_project/view/route/routes_selection_view.dart.dart';
import 'package:restart_project/view/route/routes_view.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    DashboardMainView(),
    DashboardSelectionView(),
    MapsView(),
    ProfileView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: CustomAppBar(),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: CustomColors.DARK_GREEN,
            icon: const Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: CustomColors.DARK_GREEN,
            icon: const Icon(Icons.route),
            label: 'Route',
          ),
          BottomNavigationBarItem(
            backgroundColor: CustomColors.DARK_GREEN,
            icon: const Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            backgroundColor: CustomColors.DARK_GREEN,
            icon: const Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: CustomColors.ORANGE_MEDIUM,
        onTap: _onItemTapped,
      ),
    );
  }
}
