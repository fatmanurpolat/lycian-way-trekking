import 'package:flutter/material.dart';
import 'package:restart_project/core/widgets/bottom_navigator_bar.dart';
import 'package:restart_project/view/dashboard/dashboard_view.dart';
import 'package:restart_project/view/route/routes_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashboardMainView(),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
