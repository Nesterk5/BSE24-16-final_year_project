//import 'package:final_year/screens/home.dart';
import 'package:camera/camera.dart';
import 'package:final_year/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:final_year/features/Auth/presentation/pages/login.dart';
import 'package:final_year/screens/Landingpage.dart';
import 'package:final_year/screens/bottombar.dart';
import 'package:final_year/screens/home.dart';
//import 'package:final_year/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_year/dependency_injector.dart' as di;
//import 'package:google_fonts/google_fonts.dart';

late List<CameraDescription> cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await di.init();

  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthBloc>(
      create: (context) => di.sl<AuthBloc>(),
    ),
  ], child: MyApp()));
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
      home: const Login(),
    );
  }
}
