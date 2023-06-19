import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prophunter/constant.dart';
import 'package:prophunter/models/user.dart';
import 'package:prophunter/provider/userProvider.dart';
import 'package:prophunter/screens/login_page.dart';
import 'package:prophunter/services/auth.dart';
import 'package:prophunter/size_config.dart';
import 'package:prophunter/widgets/text.dart';
import 'package:prophunter/widgets/textfield.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserData user = Provider.of<UserProvider>(context).getUser;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            defaultSpace3x,
            Text(
              'PropHunter',
              style: headingWhite27,
            ),
            CircleAvatar(
              child: Icon(
                CupertinoIcons.profile_circled,
                size: getProportionateScreenHeight(150),
              ),
              radius: getProportionateScreenHeight(100),
            ),
            TextFormField(
              readOnly: true,
              decoration: inputDecoration.copyWith(labelText: "Name"),
              initialValue: user.name,
              style: TextStyle(color: Colors.white),
            ),
            defaultSpace3x,

            TextFormField(
              readOnly: true,
              decoration: inputDecoration.copyWith(labelText: "Phone"),
              initialValue: user.phoneNo,
              style: TextStyle(color: Colors.white),
            ),
            defaultSpace3x,

            TextFormField(
              readOnly: true,
              style: TextStyle(color: Colors.white),
              decoration: inputDecoration.copyWith(labelText: "Email"),
              initialValue: user.email,
            ),
            defaultSpace3x,
            OutlinedButton(
                onPressed: () async {
                  await AuthenticationHelper().signOut();
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return LoginPage();
                      },
                    ),
                    (_) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                    side: BorderSide(color: kSecondaryColor),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50)),
                child: Text(
                  'LOGOUT',
                  style: TextStyle(color: kSecondaryColor, fontSize: 20),
                )),
            defaultSpace3x,
            Divider(
              color: fadeWhite,
              thickness: 0.5,
            ),
            // ListTile(
            //   title: Text(
            //     'Settings',
            //     style: titleWhite20,
            //   ),
            //   trailing: Icon(CupertinoIcons.right_chevron),
            // ),
            // Divider(
            //   color: fadeWhite,
            //   thickness: 0.5,
            // ),
            // ListTile(
            //   title: Text(
            //     'What\'s New',
            //     style: titleWhite20,
            //   ),
            //   trailing: Icon(CupertinoIcons.right_chevron),
            // ),
            // Divider(
            //   color: fadeWhite,
            //   thickness: 0.5,
            // ),
            // ListTile(
            //   title: Text(
            //     'Frequently Asked Question',
            //     style: titleWhite20,
            //   ),
            //   trailing: Icon(CupertinoIcons.right_chevron),
            // ),
          ],
        ),
      ),
    );
  }
}
