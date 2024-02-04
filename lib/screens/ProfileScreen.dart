import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth/constants.dart';
import 'package:smarthealth/services/authentication.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    late final authProvider = Provider.of<AuthProvider>(context).userCredential;
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
              child: ValueListenableBuilder(
                  valueListenable: authProvider,
                  builder: (context, value, child) {
                    return (authProvider.value == '' ||
                            authProvider.value == null)
                        ? Column(
                            children: [
                              CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(
                                  authProvider.value.user!.photoURL.toString(),
                                  
                                ),
                              ),
                              const SizedBox(height: 20),
                              Center(
                                  child: Text(
                                authProvider.value.user!.displayName.toString(),
                              )),
                              const SizedBox(height: 20),
                              Center(
                                  child: Text(
                                authProvider.value.user!.email.toString(),
                              )),
                            ],
                          )
                        : const CircleAvatar(
                            radius: 50.0,
                            child: Icon(Icons.person),
                          );
                  }),
            ),
            
          ],
        ),
      ),
    );
  }
}
