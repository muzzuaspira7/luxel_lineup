import 'package:luxel_lineup/view/addtocart.dart';

import 'myhomescreen.dart';
import 'package:flutter/material.dart';

class MyNavigationDrawer extends StatelessWidget {
  const MyNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[buildHeader(context), buildMenuItems(context)],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        color: Color(0xFFE2E5DE),
        padding: EdgeInsets.only(
          top: 24 + MediaQuery.of(context).padding.top,
          bottom: 24,
        ),
        child: const Column(
          children: [
            CircleAvatar(
              radius: 52,
              backgroundImage:
                  NetworkImage('https://wallpapercave.com/dwp1x/wp5977491.jpg'),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Arjun Das',
              style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'SecondaryFont',
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'arjundas7@gmail.com',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            )
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const MyHomePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Cart'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const addToCartPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.update_sharp),
              title: const Text('Updates'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
            ),
          ],
        ),
      );
}
