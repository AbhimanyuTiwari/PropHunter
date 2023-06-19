import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prophunter/models/communities.dart';
import 'package:prophunter/size_config.dart';

import 'models/properties.dart';
import 'models/property_type.dart';
import 'models/status.dart';

Map<int, Status> statusMap = {};
Map<int, Community> communityMap = {};
Map<int, PropertyType> propertyTypeMap = {};
Map<int, Properties> propertyMap = {};
const kPrimaryColor = Colors.black;
const kPrimaryLightColor = Colors.white;
const kFadeBlack = Color(0xff2F2D2D);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF00706B), Color(0xFFFFCF30)],
);
const kSecondaryColor = Color(0xFFBE9961);
const kTextColor = Color(0xFF757575);
const fadeWhite = Color(0xff9a9696);

//duration
const kAnimationDuration = Duration(milliseconds: 200);
const defaultDuration = Duration(milliseconds: 250);
//Form Error
const String kInvalidPhoneError = "Please Enter Valid Phone No";
const String kOtpNullError = "Please Enter your OTP";
const String kMatchOtpError = "Wrong Otp";
const String kNameNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
final defaultHeight = SizeConfig.screenHeight * 0.008;
const backgroundColor = Color(0xffF1F3F7);
//spacing
final defaultSpace = SizedBox(height: SizeConfig.screenHeight * 0.008);
final defaultSpace2x = SizedBox(height: SizeConfig.screenHeight * 0.02);
final defaultSpace3x = SizedBox(height: SizeConfig.screenHeight * 0.03);

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(),
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
      ));

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      colorScheme: const ColorScheme.dark(),
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
      ));
}

String? validateEmail(String? value) {
  String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value))
    return 'Enter a valid email address';
  else
    return null;
}

String? validatePassword(String? value) {
  RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (value == null || value.isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Password must contain: Uppercase, LowerCase, Special Character';
    } else {
      return null;
    }
  }
}

String formatDateMMMd(DateTime date) => DateFormat.yMMMd().format(date);
