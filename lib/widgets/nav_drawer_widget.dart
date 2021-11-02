import 'package:flutter/material.dart';
import 'package:flutter_laravel_sanctum/providers/auth.dart';
import 'package:flutter_laravel_sanctum/screens/login_screen.dart';
import 'package:flutter_laravel_sanctum/screens/post_screen.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Consumer<Auth>(builder: (context, auth, child) {
      if (auth.authenticated) {
        return ListView(
          children: [
            const ListTile(
              title: Text('Name here'),
            ),
            ListTile(
              title: const Text('Posts'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Log out'),
              onTap: () {
                Provider.of<Auth>(
                  context,
                  listen: false,
                ).logout();
                Navigator.of(context).pop();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => PostScreen()),
                // );
              },
            )
          ],
        );
      } else {
        return ListView(children: [
          ListTile(
            title: const Text('Login'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Register'),
            onTap: () {},
          ),
        ]);
      }
    }));
  }
}
