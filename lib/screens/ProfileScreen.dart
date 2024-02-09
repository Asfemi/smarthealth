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
            ValueListenableBuilder(
                valueListenable: authProvider,
                builder: (context, value, child) {
                  return (authProvider.value == '' ||
                          authProvider.value == null)
                      ? Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: kPrimaryColor,
                              minRadius: 60.0,
                              child: CircleAvatar(
                                radius: 50.0,
                                child: Icon(Icons.person),
                                // backgroundImage: NetworkImage(
                                //     'https://media.licdn.com/dms/image/D4E03AQGWJgkLLmRVzQ/profile-displayphoto-shrink_400_400/0/1703380869904?e=1712793600&v=beta&t=VWL1VDFxLqUEOw9PH8wnvk2l3AdOHf5rn__m_oljwEQ'
                                //     //authProvider.value.user!.photoURL.toString(),

                                //     ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                                child: Text("user"
                                    // authProvider.value.user!.displayName.toString(),
                                    )),
                            const SizedBox(height: 20),
                            Center(
                                child: Text("email"
                                    //authProvider.value.user!.email.toString(),
                                    )),
                          ],
                        )
                      : const CircleAvatar(
                          radius: 50.0,
                          child: Icon(Icons.person),
                        );
                }),
          ],
        ),
      ),
    );
  }
}
