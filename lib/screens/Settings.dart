import 'package:flutter/material.dart';
import 'package:smarthealth/config.dart';
import 'package:smarthealth/constants.dart';
import 'package:smarthealth/screens/ContactUs.dart';
import 'package:smarthealth/services/authentication.dart';

class SettingsScreen extends StatelessWidget {
  static String id = 'settings';
  //const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'settings',
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.brightness_4,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  title: Text(
                    'Light Theme',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  onTap: () => currentTheme.toggleTheme(),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  title: Text(
                    'contact Us',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, ContactUs.id);
                    // Navigator.pushNamed(context, SettingsScreen.id);
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  title: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  onTap: () {
                    AuthProvider().signOutFromGoogle();

                    Navigator.pop(context);
                  },
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
