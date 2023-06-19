import 'package:flutter/material.dart';
import 'package:prophunter/constant.dart';
import 'package:prophunter/screens/landing_page.dart';
import 'package:prophunter/screens/register_page.dart';
import 'package:prophunter/services/auth.dart';
import 'package:prophunter/size_config.dart';
import 'package:prophunter/widgets/buttons.dart';
import 'package:prophunter/widgets/loading_dialog.dart';
import 'package:prophunter/widgets/text.dart';

import '../widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/login_page';

  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String error = "";
  String? password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Image.asset(
                    'assets/images/transparent_logo.png',
                    width: SizeConfig.screenWidth * 0.8,
                  ),
                  Spacer(),
                  TextFormField(
                    onSaved: (val) => email = val,
                    validator: (val) => validateEmail(val),
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    decoration: inputDecoration.copyWith(labelText: 'Email'),
                  ),
                  defaultSpace3x,
                  defaultSpace2x,
                  TextFormField(
                    onSaved: (val) => password = val,
                    style: TextStyle(color: Colors.white),
                    decoration: inputDecoration.copyWith(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  defaultSpace2x,
                  Text(
                    error,
                    style: titleWhite18,
                  ),
                  Spacer(),
                  DefaultButton(
                    text: "LOGIN",
                    press: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        showLoaderDialog(context);
                        String? result = await AuthenticationHelper()
                            .signIn(email: email ?? "", password: password ?? "");
                        Navigator.pop(context);
                        if (result == null) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, LandingPage.routeName, (route) => false);
                        } else {
                          error = result;
                          setState(() {});
                        }
                      }
                    },
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't have account?",
                        style: titleWhite18,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterPage.routeName);
                          },
                          child: Text('Create Account'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
