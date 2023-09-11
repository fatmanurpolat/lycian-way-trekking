import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_project/core/utils/app_config.dart';
import 'package:restart_project/core/widgets/custom_elevadet_button.dart';
import 'package:restart_project/core/widgets/custom_textfield.dart';
import 'package:restart_project/view/authetication/login/login_view_model.dart';
import 'package:restart_project/view/authetication/register/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.checkCurrentUser(context);
    }); // viewModel.loc
  }

  LoginViewModel viewModel = LoginViewModel(); //nesne oluşturduk
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.LOGINREGISTERCOLOR,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.hiking,
                  size: 45,
                ),
                SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Hello Again!",
                  style: GoogleFonts.bebasNeue(fontSize: 38),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Welcome back, you 've been missed!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                customTextField(
                  hintext: 'Username',
                  isObsecure: false,
                  controller: viewModel.emailTextController,
                ),
                customTextField(
                    hintext: 'Password',
                    isObsecure: true,
                    inputType: TextInputType.number,
                    controller: viewModel.passwordTextController),
                customElevatedButton(
                  buttonText: 'Login',
                  onPressed: () {
                    viewModel.login(context);
                  },
                  buttonColor: CustomColors.ORANGE_BUTTON,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterView()));
                    },
                    child: Text(
                      "Don't have an account?",
                      style: TextStyle(color: CustomColors.DARK_GREEN),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
