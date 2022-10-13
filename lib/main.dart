import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/login.dart';
import 'package:news_app/screens/myhomepage.dart';
import 'package:news_app/screens/signup.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MyHomePage();
                } else {
                  return FirstScren();
                }
              }),
        ),
      );
}

class FirstScren extends StatefulWidget {
  @override
  State<FirstScren> createState() => _FirstScrenState();
}

class _FirstScrenState extends State<FirstScren>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text('SocialX'),
            bottom: TabBar(
              indicatorWeight: 5,
              indicatorColor: Colors.white,
              controller: _tabController,
              tabs: [Tab(text: "LOGIN"), Tab(text: "SIGN UP")],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBarView(
              controller: _tabController,
              children: [
                Login(tabController: _tabController),
                SignUp(tabController: _tabController),

                // FirstScreen(),
                // SecondScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
