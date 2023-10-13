import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_project/core/utils/app_config.dart';
import 'package:restart_project/core/widgets/custom_elevadet_button.dart';
import 'package:restart_project/core/widgets/custom_textfield.dart';
import 'package:restart_project/view/authetication/register/register_view_model.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel viewModel = RegisterViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.LOGINREGISTERCOLOR,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 58.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.hiking,
                size: 45,
              ),
              const SizedBox(
                height: 30,
              ),
              //Hello Again!
              Text(
                "Hello There!",
                style: GoogleFonts.bebasNeue(fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Register below with your details!",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              customTextField(
                hintext: 'Name',
                isObsecure: false,
                controller: viewModel.nameTextController,
              ),
              customTextField(
                hintext: 'Surname',
                isObsecure: false,
                controller: viewModel.surnameTextController,
              ),
              customTextField(
                hintext: 'Email',
                isObsecure: false,
                controller: viewModel.emailTextController,
              ),
              customTextField(
                  hintext: 'Password',
                  isObsecure: true,
                  inputType: TextInputType.number,
                  controller: viewModel.passwordTextController),
              customTextField(
                hintext: 'Confirm Password',
                isObsecure: false,
                controller: viewModel.confirmTextController,
              ),
              customElevatedButton(
                buttonText: 'Register',
                onPressed: () {
                  viewModel.signUp(context);
                },
                buttonColor: CustomColors.ORANGE_BUTTON,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Do you already have an account?',
                    style: TextStyle(color: CustomColors.DARK_GREEN),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
