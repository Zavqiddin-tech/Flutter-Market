import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market/components/tile/home_list_tile.dart';
import 'package:market/components/tile/my_list_tile.dart';
import 'package:market/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // firestore databse
  final FirestoreHome database = FirestoreHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Uy'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/home_add_page');
              },
              child: Container(
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.primary, // Oqroq fon rangi
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8), // Icon uchun bo'sh joy
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Posts
          StreamBuilder(
              stream: database.getHomeStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // get all posts
                final homes = snapshot.data!.docs;
                // no data?
                if (snapshot.data == null || homes.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text('No posts.. Post something'),
                    ),
                  );
                }

                // return as a list
                return Expanded(
                    child: ListView.builder(
                        itemCount: homes.length,
                        itemBuilder: (context, index) {
                          // get each individual posts
                          final post = homes[index];

                          // get data from each post
                          String id = post.id;
                          String homeName = post['HomeName'];
                          String count = post['HomeCount'];
                          bool busy = post['Busy'];
                          String other = post['Other'];
                          String userEmail = post['UserEmail'];
                          Timestamp timestamp = post['TimeStamp'];
                          // return as a list tile
                          return HomeListTile(
                            home: homeName,
                            count: count,
                            busy: busy,
                            other: other,
                            userEmail: userEmail,
                          );
                        }));
              }),
        ],
      ),
    );
  }
}
