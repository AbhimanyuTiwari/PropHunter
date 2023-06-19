import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prophunter/provider/basicDataProvider.dart';
import 'package:prophunter/provider/propertyProvider.dart';
import 'package:prophunter/provider/unitProvider.dart';
import 'package:prophunter/provider/userProvider.dart';
import 'package:prophunter/routes.dart';
import 'package:prophunter/screens/landing_page.dart';
import 'package:prophunter/screens/login_page.dart';
import 'package:provider/provider.dart';

import 'constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PropertyProvider>(create: (context) => PropertyProvider()),
        ChangeNotifierProvider<BasicDataProvider>(create: (context) => BasicDataProvider()),
        ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
        ChangeNotifierProvider<UnitProvider>(create: (context) => UnitProvider()),
      ],
      child: MaterialApp(
        title: 'PropHunter',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeClass.darkTheme,
        darkTheme: ThemeClass.darkTheme,
        initialRoute: CheckLanding.routeName,
        // home: CustomAnimation(),
        routes: routes,
      ),
    );
  }
}

class CheckLanding extends StatefulWidget {
  static String routeName = '/';

  const CheckLanding({Key? key}) : super(key: key);

  @override
  State<CheckLanding> createState() => _CheckLandingState();
}

class _CheckLandingState extends State<CheckLanding> {
  Future<String> check() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        if (value.exists) {
          return "home";
        } else {
          try {
            await FirebaseAuth.instance.signOut();
          } finally {}
          return "signin";
        }
      });
    } else {
      return "signin";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // versionCheck(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: check(),
      builder: (context, snapshot) {
        if (snapshot.data == "home") {
          return LandingPage();
        }
        if (snapshot.data == "signin") {
          return LoginPage();
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
