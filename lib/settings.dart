import 'package:final_year/utils/app_colors.dart';
import 'package:flutter/material.dart';

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
                  child: Icon(
                    Icons.person,
                    size: 30,
                  ),
                  radius: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
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
            SizedBox(
              height: 20,
            ),
            headerText('Acount Setting', 20.0),
            settingsTile('Account'),
            settingsTile('Notifications'),
            SizedBox(
              height: 15,
            ),
            headerText('App Setting', 20.0),
            settingsTile('FAQ'),
            settingsTile('Support'),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.appGreen,
                  fixedSize: const Size(double.maxFinite, 45),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }

  Widget settingsTile(text) {
    return Container(
      margin: EdgeInsets.only(bottom: 18),
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
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          const Icon(Icons.arrow_forward_ios_sharp)
        ],
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
