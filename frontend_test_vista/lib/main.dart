import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/company_list_screen.dart';
import 'providers/company_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CompanyProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vista Company App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: CompanyListScreen(),
    );
  }
}
