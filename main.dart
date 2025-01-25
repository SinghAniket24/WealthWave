// main.dart
import 'package:flutter/material.dart';
import 'pages/home_page.dart'; // Import the HomePage widget
import 'pages/watchlist_page.dart'; // Import the WatchlistPage widget
import 'pages/trends_page.dart'; // Import the TrendsPage widget
import 'pages/news_page.dart'; // Import the NewsPage widget

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // List of pages
  final List<Widget> _pages = [
    const HomePage(), // HomePage widget imported from home_page.dart
    const WatchlistPage(), // WatchlistPage widget imported from watchlist_page.dart
    const TrendsPage(), // TrendsPage widget imported from trends_page.dart
    const NewsPage(), // NewsPage widget imported from news_page.dart
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 28, 255),
        title: const Text('Stock app'),
      ),
      body: _pages[_selectedIndex], // Dynamically change body based on selected index
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle, // Profile icon
                    color: Colors.white,
                    size: 40, // Icon size
                  ),
                  SizedBox(width: 10), // Space between icon and text
                  Text(
                    'App', // Text label
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          // Apply custom theme for BottomNavigationBar
          canvasColor: Colors.black, // Background color
          primaryColor: Colors.blue, // Selected item color
          textTheme: Theme.of(context).textTheme.copyWith(
                bodySmall: const TextStyle(color: Colors.white), // Text color for items
              ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Watchlist',
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              label: 'Trends',
              icon: Icon(Icons.trending_up),
            ),
            BottomNavigationBarItem(
              label: 'News',
              icon: Icon(Icons.new_releases),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
