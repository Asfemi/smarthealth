import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);
  static String id = 'contact us';

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us', style: TextStyle(color: kPrimaryColor)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse('https//www.github.com/Asfemi'));
                },
                child: bigText('GitHub')),
            const SizedBox(height: 5),
            // smallText('github.com/Asfemi'),
            // const SizedBox(height: 20),
            const Divider(thickness: 2),
            GestureDetector(
                onTap: () {
                  launchUrl(
                      Uri.parse('https://www.stackoverflow.com/users/13132398/asfemi'));
                },
                child: bigText('StackOverflow')),

            const SizedBox(height: 20),
            const Divider(thickness: 2),
            GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse(
                      'https://www.linkedin.com/in/ayodele-s-a0162116a/'));
                },
                child: bigText('LinkedIn')),

            const SizedBox(height: 20),
            const Divider(thickness: 2),
            bigText('Whatsapp'),
            const SizedBox(height: 5),
            smallText('08148429834'),
            const SizedBox(height: 20),
            const Divider(thickness: 2),
            GestureDetector(
                onTap: () {
                  launchUrl(
                      Uri.parse('https://www.instagram.com/ayodele_samuell/'));
                },
                child: bigText('Instagram')),
            const SizedBox(height: 20),
            const Divider(thickness: 2),
            bigText('twitter'),
            const SizedBox(height: 5),
            smallText('AyodeleSamuelOF'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

Widget bigText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget smallText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  );
}
