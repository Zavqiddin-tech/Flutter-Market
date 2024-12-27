import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market/components/my_list_tile.dart';
import 'package:market/database/firestore.dart';

class ClientPage extends StatelessWidget {
  ClientPage({super.key});

  // firestore databse
  final FirestoreClient database = FirestoreClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mijozlar'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/client_add_page');
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
              stream: database.getClientStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // get all posts
                final clients = snapshot.data!.docs;

                // no data?
                if (snapshot.data == null || clients.isEmpty) {
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
                        itemCount: clients.length,
                        itemBuilder: (context, index) {
                          // get each individual posts
                          final post = clients[index];

                          // get data from each post
                          String message = post['FullName'];
                          String userEmail = post['UserEmail'];
                          Timestamp timestamp = post['TimeStamp'];
                          // return as a list tile
                          return MyListTile(
                              title: message, subtitle: userEmail);
                        }));
              }),
        ],
      ),
    );
  }
}
