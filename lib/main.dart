import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:enabled_app/providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'User Screens/enabled_location_details.dart';
import 'User Screens/map_home.dart';
import 'User Screens/map_page.dart';
import 'User Screens/user_home.dart';
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
  int _counter = 0;
  final FirebaseService firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    // List<Map<String, dynamic>> locations = [
    //   {
    //     'name': 'Cebu Milktea Depot',
    //     'description': 'Tea wholesaler',
    //     'contactNumber': '',
    //     'location': GeoPoint(10.287369757788667, 123.86039089751957),
    //     'accessibility': [],
    //     'overallRating': 4.0,
    //   },
    //   {
    //     'name': '7-Eleven',
    //     'description': 'Supermarket',
    //     'contactNumber': '',
    //     'location': GeoPoint(10.289986663196729, 123.85894347083034),
    //     'accessibility': [
    //       'Wheelchair accessible entrance',
    //       'Wheelchair accessible parking lot'
    //     ],
    //     'overallRating': 4.0,
    //   },
    //   {
    //     'name': 'New Apostolic Church',
    //     'description': 'Apostolic church',
    //     'contactNumber': '',
    //     'location': GeoPoint(10.28642627690953, 123.85768386556002),
    //     'accessibility': [],
    //     'overallRating': 4.0,
    //   },
    //   {
    //     'name': 'Jumalon Butterfly Sanctuary And Art Gallery',
    //     'description': 'Art gallery',
    //     'contactNumber': '0322616884',
    //     'location': GeoPoint(10.290669786488776, 123.86448755148963),
    //     'accessibility': [
    //       'Wheelchair accessible entrance',
    //       'Wheelchair accessible parking lot',
    //       'Wheelchair accessible restroom'
    //     ],
    //     'overallRating': 4.0,
    //   },
    //   {
    //     'name': 'San Jose Residences',
    //     'description': 'Student dormitory',
    //     'contactNumber': '',
    //     'location': GeoPoint(10.291525910943857, 123.86061769950861),
    //     'accessibility': [
    //       'Wheelchair accessible entrance',
    //       'Wheelchair accessible parking lot',
    //       'Wheelchair accessible restroom'
    //     ],
    //     'overallRating': 4.0,
    //   },
    //   {
    //     'name': 'Lance Computer Repair',
    //     'description': 'Apartment building',
    //     'contactNumber': '',
    //     'location': GeoPoint(10.291293683975496, 123.85845047130336),
    //     'accessibility': [
    //       'Wheelchair accessible entrance',
    //       'Wheelchair accessible parking lot'
    //     ],
    //     'overallRating': 4.0,
    //   },
    //   {
    //     'name': 'Rainbow Connection Child Learning Center',
    //     'description': 'School',
    //     'contactNumber': '0323456972',
    //     'location': GeoPoint(10.28642627690953, 123.85768386556002),
    //     'accessibility': [
    //       'Wheelchair accessible entrance',
    //       'Wheelchair accessible parking lot'
    //     ],
    //     'overallRating': 4.0,
    //   },
    //   {
    //     'name': 'James Fitness Gym',
    //     'description': 'Fitness center',
    //     'contactNumber': '',
    //     'location': GeoPoint(10.291399066710365, 123.86806388615076),
    //     'accessibility': [
    //       'Wheelchair accessible entrance',
    //       'Wheelchair accessible parking lot',
    //       'Wheelchair accessible restroom'
    //     ],
    //     'overallRating': 4.0,
    //   },
    //   {
    //     'name': 'RoadStar',
    //     'description': 'Repair service',
    //     'contactNumber': '0322380254',
    //     'location': GeoPoint(10.28628596394535, 123.86154837238495),
    //     'accessibility': ['Wheelchair accessible entrance'],
    //     'overallRating': 4.0,
    //   },
    // ];

    // for (var location in locations) {
    //   List<String> accessibilityList =
    //       List<String>.from(location['accessibility']);
    //   firebaseService.createLocation(
    //     name: location['name'],
    //     description: location['description'],
    //     contactNumber: location['contactNumber'],
    //     location: location['location'],
    //     accessibility: accessibilityList,
    //     overallRating: location['overallRating'],
    //   );
    // }
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
                color: tBlack,
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
                    PageRouteUtils.createSlidePageRoute(MapHome()),
                  );
                },
                child: Container(
                  child: Text(
                    'Go to Map Home',
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
        onPressed: () {
          //
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
