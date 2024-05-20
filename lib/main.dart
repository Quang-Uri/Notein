import 'package:app_notein/Screens/calendar/meeting_provider.dart';
import 'package:app_notein/Screens/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/schedulePage.dart';
import 'Screens/Menu_Page.dart';
import 'providers/notes_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    print("bbbbbbbbbbb");
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyA5v92TiQzlwB1HSrcWsX7I57GICW0hFL4",
        appId: "1:908261622512:android:72ea888007cab2ac4fb835",
        messagingSenderId: "908261622512",
        projectId: "app-notes-26289",
        // Your web Firebase config options
      ),
    );
  } else {
    print("aaaaaaaa");
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => NotesProvider(),
          ),
          ChangeNotifierProvider(
            create: (content) => MeetingProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    HomePageN(),
    SchedulePage(),
    Menu_Page(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions
          .elementAt(_selectedIndex), // Update body based on selected index
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.scoreboard_sharp),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Separate content widget for HomePage to avoid the infinite loop
class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Content'),
    );
  }
}
