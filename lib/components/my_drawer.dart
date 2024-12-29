import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // logout user
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // drawer header
              const DrawerHeader(child: Icon(Icons.favorite)),

              const SizedBox(
                height: 25,
              ),

              // home tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.dashboard),
                  title: const Text('D A S H B O A R D'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),


              // users tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text('M I J O Z L A R'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/client_page');
                  },
                ),
              ),
              
              // homes tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.home_filled),
                  title: const Text('U Y L A R'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/home_page');
                  },
                ),
              ),
              
              // contracts tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.payment_rounded),
                  title: const Text('S H A R T N O M A'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/contract_page');
                  },
                ),
              ),
            ],
          ),

          // users tile
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('L O G O U T'),
              onTap: () {
                Navigator.pop(context);
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
