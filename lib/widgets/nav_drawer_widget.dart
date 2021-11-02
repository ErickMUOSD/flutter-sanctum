import 'package:flutter/material.dart';
import 'package:flutter_laravel_sanctum/screens/post_screen.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Erick Sanabria Martinez'),
          ),
          ListTile(
            title: Text('Posts'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PostScreen()),
              );
            },
          )
        ],
      ),
    );
  }
}
