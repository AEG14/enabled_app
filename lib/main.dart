import 'package:enabled_app/User%20Screens/privacy-statement.dart';
import 'package:enabled_app/User%20Screens/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:enabled_app/providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'User Screens/enabled_location_details.dart';
import 'User Screens/map_home.dart';
import 'User Screens/map_page.dart';
import 'User Screens/user_home.dart';
import 'User Screens/view_reviews.dart';
import 'User Screens/leave_review.dart';
import 'app_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import '../push_animation.dart';
import 'package:enabled_app/providers/firebaseFunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:riverpod/riverpod.dart';

import 'providers/cart_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCqauAJdD-kEg00hJo8Oz8-NxGZLuNkO90',
      appId: '1:964235381604:android:e5afe23fda86211dc18871',
      messagingSenderId: '964235381604',
      projectId: 'enabled---mobile-applica-f710b',
      storageBucket: 'enabled---mobile-applica-f710b.appspot.com',
    ),
  );
  // final firebaseService = FirebaseService();

  // firebaseService.createUser(
  //   username: 'HarleyEms',
  //   firstName: 'Harley',
  //   lastName: 'Mamalias',
  //   email: 'Harley@example.com',
  //   phoneNumber: '+1234567890',
  //   profilePicture: 'profilePictures/harls.jpg',
  //   password: 'password123',
  // );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: MaterialApp(
        home: MyApp(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    ProfilePage(userId: "kLWRVGRSwIBGE8naaBdC"), // Placeholder for Profile
    MapHome(),
    PrivacyStatementPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xff169d53),
        unselectedItemColor: tGrey3,
        unselectedLabelStyle: tPoppinsRegular.copyWith(color: tGrey3),
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
