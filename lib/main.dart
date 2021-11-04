import 'package:flutter/material.dart';
import 'package:flutter_laravel_sanctum/providers/auth.dart';
import 'package:flutter_laravel_sanctum/widgets/nav_drawer_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => Auth(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
