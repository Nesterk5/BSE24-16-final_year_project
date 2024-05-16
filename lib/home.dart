// ignore_for_file: dead_code

import 'dart:ui';

import 'package:final_year/step_indicator.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.4, // Set the height for the Stack
            child: Stack(
              children: [
                FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  heightFactor: 1.0, // Adjust this value as needed
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/meat2.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.10,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Good morning ${widget.username},',
                        style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Welcome to our Meat Quality Inspection System!',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      // Center(child: _widgetOptions.elementAt(_selectedIndex)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Column(
            children: [
              Text(
                'To Add a new meat sample',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w200),
              ),
              SizedBox(height: 10),
              StepIndicator(), // Add the step indicator here
            ],
          ),
        ],
      ),
    )));
  }
}
