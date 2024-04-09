import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:enabled_app/providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'User Screens/enabled_location_details.dart';
import 'User Screens/map_page.dart';
import 'User Screens/user_home.dart';
import 'app_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import '../push_animation.dart';
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
    ),
  );

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
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: tBlack, // Assuming tWhite is equivalent to Colors.white
                fontSize: 15,
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteUtils.createSlidePageRoute(UserHome()),
                  );
                },
                child: Container(
                  child: Text(
                    'Go to Home Page',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: tBlack,
                      fontSize: 15,
                    ),
                  ),
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteUtils.createSlidePageRoute(MapPage()),
                  );
                },
                child: Container(
                  child: Text(
                    'Go to Map Page',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: tBlack,
                      fontSize: 15,
                    ),
                  ),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
