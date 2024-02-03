import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smarthealth/services/authentication.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier userCredential = ValueNotifier('');
    //late final authProvider = Provider.of<AuthProvider>(context).userCredential;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile Screen',
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: kPrimaryColor,
              minRadius: 60.0,
              child: (userCredential == '' || userCredential == null)
                  ? CircleAvatar(
                      radius: 50.0,
                      backgroundImage: NetworkImage(
                        authProvider.user!.photoURL.toString(),
                        // 'https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'
                      ),
                    )
                  : const CircleAvatar(
                      radius: 50.0,
                      child: Icon(Icons.person),
                    ),
            ),
            const Center(child: Text('Coing soon')),
          ],
        ),
      ),
    );
  }
}
