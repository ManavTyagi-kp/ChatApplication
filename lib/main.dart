import 'package:firebase_chat_app/UserAuth/registration.dart';
import 'package:firebase_chat_app/pages/homePage.dart';
import 'package:firebase_chat_app/firebase_options.dart';
import 'package:firebase_chat_app/templates/headingTemplates/h1.dart';
import 'package:firebase_chat_app/templates/pageTemplate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});
  final title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: RootPage(),
    );
  }

  // Widget _resizableColumnWidth() {
  //   return Row(
  //     children: [ActionPage(), ActionPage()],
  //   );
}
