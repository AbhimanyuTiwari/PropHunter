import 'package:flutter/widgets.dart';
import 'package:prophunter/custom_animation.dart';
import 'package:prophunter/main.dart';
import 'package:prophunter/screens/home_screen/home_screen.dart';
import 'package:prophunter/screens/landing_page.dart';
import 'package:prophunter/screens/login_page.dart';
import 'package:prophunter/screens/register_page.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  // SplashScreen.routeName: (context) => SplashScreen(),

  // OnboardingScreen.routeName: (context) => const OnboardingScreen(),
  LoginPage.routeName: (context) => LoginPage(),
  RegisterPage.routeName: (context) => RegisterPage(),
  CheckLanding.routeName: (context) => CheckLanding(),
  CustomAnimation.routeName: (context) => CustomAnimation(),
  // OtpScreen.routeName: (context) => OtpScreen(),
  // PropertyList.routeName:(context)=>PropertyList(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  LandingPage.routeName: (context) => const LandingPage(),
  // Statistics.routeName:(context)=>Statistics()
  // DetailsScreen.routeName: (context) => DetailsScreen(),
  // ProfileScreen.routeName: (context) => ProfileScreen(),
};
