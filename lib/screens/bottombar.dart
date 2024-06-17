import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:final_year/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:final_year/features/Auth/presentation/pages/login.dart';
import 'package:final_year/screens/Inspectionhistory.dart';
import 'package:final_year/screens/add_meatsample.dart';
import 'package:final_year/screens/predict.dart';
import 'package:final_year/screens/settings.dart';
import 'package:final_year/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:final_year/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      Aidetector(),
      InspectionHistory(),
      Settings()
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedOutUser) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        }
      },
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            //backgroundColor: Color(0x00000000),
            selectedItemColor: Colors.black,
            unselectedItemColor: AppColors.greyColor,
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
                  icon: Icon(Icons.document_scanner_outlined),
                  label: 'Add sample'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: 'History'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'settings'),
            ]),
      ),
    );
  }
}
