import 'package:final_year/Inspectionhistory.dart';
import 'package:final_year/add_meatsample.dart';
import 'package:flutter/material.dart';
import 'package:final_year/home.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  int index;
  String username;
  BottomBar({super.key, required this.index, required this.username});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int _selectedIndex;
  late String myusername;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index;
    myusername = widget.username;
    _screens = [
      Home(username: myusername),
      Home(username: myusername),
      const InspectionHistory()
    ];
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      // Show dialog for "Add Sample"
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddSampleDialog();
        },
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blueGrey,
          //backgroundColor: Color(0x00000000),
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.black,
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline), label: 'Add sample'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'View History'),
          ]),
    );
  }
}
