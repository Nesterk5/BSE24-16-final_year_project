//import 'package:final_year/home.dart';
import 'package:camera/camera.dart';
import 'package:final_year/Landingpage.dart';
//import 'package:final_year/login.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';


late List<CameraDescription> cameras;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      //home: const Home(username: '',),
      title: 'Meat Quality Inspection System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          //   bodyMedium: GoogleFonts.oswald(textStyle: textTheme.bodyMedium),
          // ),
          fontFamily: 'Helvetica',
          inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              errorBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              focusedErrorBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              fillColor: Colors.white,
              filled: true,
              focusColor: Colors.black),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey.shade300),
      home: const FirstScreen(),
    );
  }
}
