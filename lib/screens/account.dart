import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('User Account'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            const Text(
              'Profile Information',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Name'),
              subtitle: const Text('John Doe'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _editName(context);
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('johndoe@example.com'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Implement edit email functionality
                  _editEmail(context);
                },
              ),
            ),
            const Divider(),
            const Text(
              'Security',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  // Navigate to change password screen
                },
              ),
            ),
            const Divider(),
            const SizedBox(height: 20.0),
            const Text(
              'Preferences',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Push Notifications'),
              trailing: Switch(
                value: true, // Example value, replace with actual state
                onChanged: (value) {
                  // Implement toggle notification functionality
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Location Tracking'),
              trailing: Switch(
                value: false, // Example value, replace with actual state
                onChanged: (value) {
                  // Implement toggle location tracking functionality
                },
              ),
            ),
            const Divider(),
            const SizedBox(height: 20.0),
            // TextButton(
            //   onPressed: () {
            //     // Implement sign out functionality
            //   },
            //   child: const Text(
            //     'Sign Out',
            //     style: TextStyle(color: Colors.red),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _editName(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newName = ''; // Placeholder for new name
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Edit Name'),
          content: TextField(
            onChanged: (value) {
              newName = value;
            },
            decoration: InputDecoration(hintText: 'Enter your new name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // Save the new name and update UI as needed
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editEmail(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newEmail = ''; // Placeholder for new email
        return AlertDialog(
          title: Text('Edit Email'),
          content: TextField(
            onChanged: (value) {
              newEmail = value;
            },
            decoration: InputDecoration(hintText: 'Enter your new email'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Save'),
              onPressed: () {
                // Save the new email and update UI as needed
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
