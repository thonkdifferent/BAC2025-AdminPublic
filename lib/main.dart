import 'package:carspace/tabs/MapTab.dart';
import 'package:carspace/tabs/ProfileTab.dart';
import 'package:carspace/tabs/ReservationsTab.dart';
import 'package:carspace/tabs/SearchTab.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


const supabaseUrl = 'https://uhzijekgkovmjahcpvdf.supabase.co';
const supabaseKey = String.fromEnvironment('SUPABASE_KEY');
Future<void> main() async {
  await Supabase.initialize(
    url: 'https://uhzijekgkovmjahcpvdf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVoemlqZWtna292bWphaGNwdmRmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIxMjQzMTIsImV4cCI6MjA1NzcwMDMxMn0.Ohwbhcz9Ew-EiVE6q3EKjMVEv4597aFRTBmRmjxGxtg',
  );

  runApp(MyApp());
}
final supabase = Supabase.instance.client;
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CarSpace',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Carsa'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin {
  int _currentIndex = 0;


  late TabController _tabController;

  static List<Widget> widgets = [
    MapTab(),
    ReservationTab(),
    SearchTab(),
    ProfileTab()
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: widgets.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: widgets.length,
            child: Scaffold(
                body: TabBarView(
                  controller:_tabController,
                  children: widgets,
                ),
                bottomNavigationBar: SalomonBottomBar(
                  currentIndex: _currentIndex,
                  onTap: (i) => setState(() => _tabController.index = _currentIndex = i ),
                  items: [
                    /// Home
                    SalomonBottomBarItem(
                      icon: Icon(Icons.map),
                      title: Text("Home"),
                      selectedColor: Colors.purple,
                    ),

                    /// Likes
                    SalomonBottomBarItem(
                      icon: Icon(Icons.beenhere),
                      title: Text("Reservations"),
                      selectedColor: Colors.pink,
                    ),

                    /// Search
                    SalomonBottomBarItem(
                      icon: Icon(Icons.search),
                      title: Text("Search"),
                      selectedColor: Colors.orange,
                    ),

                    /// Profile
                    SalomonBottomBarItem(
                      icon: Icon(Icons.person),
                      title: Text("Profile"),
                      selectedColor: Colors.teal,
                    ),
                  ],
                )
            )
        )
    );
  }
}