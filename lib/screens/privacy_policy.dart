import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy for Meat Quality Inspection App',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              'Introduction',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Our Meat Quality Inspection App ("we", "us", "our") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.',
            ),
            SizedBox(height: 20.0),
            Text(
              'Information We Collect',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              "We may collect and process the following information:\n\n- Personal Information: When you create an account, we may collect your name, email address, and contact information.\n\n- Usage Data: We may collect information about how you interact with the app, including but not limited to device information, app usage metrics, and performance data.\n\n- Location Data: We may collect your device's location information if you enable location services for specific features of the app, such as identifying inspection locations.",
            ),
            SizedBox(height: 20.0),
            Text(
              'How We Use Your Information',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'The information we collect is used to:\n\n- Provide and maintain the app\'s functionality.\n- Improve and personalize your experience.\n- Communicate with you, either directly or through our support team.\n- Analyze app usage and trends to enhance our services.\n- Comply with legal obligations.',
            ),
            SizedBox(height: 20.0),
            Text(
              'Data Security',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We prioritize the security of your data and take reasonable measures to protect it from unauthorized access, alteration, disclosure, or destruction. However, please note that no method of transmission over the internet or electronic storage is completely secure.',
            ),
            SizedBox(height: 20.0),
            Text(
              'Changes to This Privacy Policy',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We may update our Privacy Policy from time to time. Any changes will be posted on this page, and you are advised to review this Privacy Policy periodically for any updates.',
            ),
            SizedBox(height: 20.0),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at:\n\nEmail: privacy@meatinspectionapp.com\nPhone: +1-XXX-XXX-XXXX',
            ),
          ],
        ),
      ),
    );
  }
}
