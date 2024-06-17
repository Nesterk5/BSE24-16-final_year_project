import 'package:final_year/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:final_year/screens/account.dart';
import 'package:final_year/screens/faq.dart';
import 'package:final_year/screens/privacy_policy.dart';
import 'package:final_year/screens/support.dart';
import 'package:final_year/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  child: Image.asset('images/app_logo.png'),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eramyo calvin',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'calvineromio@gmail.com',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            headerText('Acount Setting', 20.0),
            settingsTile(const AccountPage(), 'Account'),
            settingsTile(const Settings(), 'Notifications'),
            const SizedBox(
              height: 15,
            ),
            headerText('App Setting', 20.0),
            settingsTile(FAQPage(), 'FAQ'),
            settingsTile(const SupportPage(), 'Support'),
            settingsTile(const PrivacyPolicy(), 'Privacy Policy'),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.appGreen,
                  fixedSize: const Size(double.maxFinite, 45),
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(LogoutUserEvent());
                },
                child: const Text('Logout')),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  Widget settingsTile(Widget redirectPage, text) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => redirectPage));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.greenBg,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.now_widgets,
                    color: AppColors.appGreen,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: const TextStyle(fontSize: 15),
                )
              ],
            ),
            const Icon(Icons.arrow_forward_ios_sharp)
          ],
        ),
      ),
    );
  }

  Widget headerText(text, size) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 5),
      child: Text(
        text,
        style: TextStyle(fontSize: size, fontWeight: FontWeight.w600),
      ),
    );
  }
}
