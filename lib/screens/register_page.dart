import 'package:flutter/material.dart';
import 'package:prophunter/constant.dart';
import 'package:prophunter/screens/landing_page.dart';
import 'package:prophunter/screens/login_page.dart';
import 'package:prophunter/services/auth.dart';
import 'package:prophunter/size_config.dart';
import 'package:prophunter/utils/validator.dart';
import 'package:prophunter/widgets/buttons.dart';
import 'package:prophunter/widgets/text.dart';

import '../widgets/loading_dialog.dart';
import '../widgets/textfield.dart';

class RegisterPage extends StatefulWidget {
  static String routeName = '/register_page';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? name, phoneNo, email, password;
  final _formKey = GlobalKey<FormState>();
  String error = "";

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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/transparent_logo.png',
                      width: SizeConfig.screenWidth * 0.8,
                    ),
                    defaultSpace3x,
                    defaultSpace3x,
                    TextFormField(
                      onSaved: (val) => name = val,
                      validator: (val) => validateString(val, "Name"),
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white),
                      decoration: inputDecoration.copyWith(labelText: 'Name'),
                    ),
                    defaultSpace3x,
                    TextFormField(
                      onSaved: (val) => email = val,
                      validator: (val) => validateEmail(val),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white),
                      decoration: inputDecoration.copyWith(labelText: 'Email'),
                    ),
                    defaultSpace3x,
                    TextFormField(
                      onSaved: (val) => phoneNo = val,
                      validator: (val) => validatePhone(val),
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: Colors.white),
                      decoration: inputDecoration.copyWith(labelText: 'Phone'),
                    ),
                    defaultSpace3x,
                    TextFormField(
                      onSaved: (val) => password = val,
                      validator: (val) => validatePassword(val),
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
                    defaultSpace3x,
                    defaultSpace3x,
                    DefaultButton(
                      text: "REGISTER",
                      press: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          showLoaderDialog(context);
                          String? result = await AuthenticationHelper().signUp(
                              email: email!, password: password!, name: name!, phoneNo: phoneNo!);
                          Navigator.of(context).pop();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have account?",
                          style: titleWhite18,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, LoginPage.routeName);
                            },
                            child: Text('Sign In'))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
