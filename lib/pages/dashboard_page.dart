import 'package:market/components/my_drawer.dart';
import 'package:market/components/tile/my_list_tile.dart';
import 'package:market/components/my_post_button.dart';
import 'package:market/components/my_textfield.dart';
import 'package:market/database/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  // firestore database
  final FireStoreDatabase database = FireStoreDatabase();

  // text controller
  final TextEditingController newPostController = TextEditingController();

  // post message
  void postMessage() {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);

      // clear the controller
      newPostController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('W A L L'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                // textfiled
                Expanded(
                  child: MyTextfield(
                      hintText: 'Say something..',
                      obscureText: false,
                      controller: newPostController),
                ),

                // post button
                PostButton(onTap: postMessage)
              ],
            ),
          ),
          // Posts
          StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // get all posts
                final posts = snapshot.data!.docs;

                // no data?
                if (snapshot.data == null || posts.isEmpty) {
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
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          // get each individual posts
                          final post = posts[index];

                          // get data from each post
                          String message = post['PostMessage'];
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
