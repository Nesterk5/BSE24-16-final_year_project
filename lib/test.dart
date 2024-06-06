import 'package:final_year/functions/functions.dart';
import 'package:flutter/material.dart';

class TestConnection extends StatefulWidget {
  const TestConnection({super.key});

  @override
  State<TestConnection> createState() => _TestConnectionState();
}

class _TestConnectionState extends State<TestConnection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          
          children: [
            FutureBuilder(
                future: Functions.process_image(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return Center(child: Text('Data: ${snapshot.data}'));
                  } else {
                    return Center(child: Text('No data available'));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
