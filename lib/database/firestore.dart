import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreDatabase {
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // get collection of posts from firebase
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');

  // post a message
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now()
    });
  }

  // read posts from database
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('TimeStamp')
        .snapshots();

    return postsStream;
  }
}

class FirestoreClient {
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // get collection of client from firebase
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Client');

  // post a message
  Future<void> addClient(Map<String, dynamic>clientData) {
    return posts.add({
      'UserEmail': user!.email,
      'TimeStamp': Timestamp.now(),
      ...clientData
    });
  }

  // read posts from database
  Stream<QuerySnapshot> getClientStream() {
    final clientStream = FirebaseFirestore.instance
        .collection('Client')
        .orderBy('TimeStamp')
        .snapshots();

    return clientStream;
  }
}
