import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:restart_project/view/authetication/splash/splash_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashViewModel viewModel = SplashViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.initializeApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                "assets/images/way_logo.png",
              ),
              width: 200,
              height: 200,
            ),
            SizedBox(
              width: 100,
              height: 100,
            ),
            SpinKitChasingDots(
              color: Color.fromARGB(255, 11, 64, 14),
              size: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
