import 'package:flutter/material.dart';
import 'package:flutter_laravel_sanctum/providers/auth.dart';
import 'package:flutter_laravel_sanctum/widgets/nav_drawer_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => Auth(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Sanctum auth'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final storage = const FlutterSecureStorage();

  void _attemptAuth() async {
    final key = await storage.read(key: 'auth');
    if (key != null) {
      Provider.of<Auth>(context, listen: false).attempt(key);
    }
  }

  @override
  Widget build(BuildContext context) {
    _attemptAuth();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const NavDrawer(),
      body: Center(child: Consumer<Auth>(builder: (context, auth, child) {
        if (auth.authenticated) {
          return const Text('Logged ing');
        } else {
          return const Text('Not logged in');
        }
      })),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
