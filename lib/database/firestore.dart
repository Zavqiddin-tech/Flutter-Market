import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:market/main.dart';

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
  Future<void> addClient(Map<String, dynamic> clientData) {
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

class FirestoreHome {
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // get collection of client from firebase
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Home');

  // post a message
  Future<void> addHome(Map<String, dynamic> clientData) {
    return posts.add({
      'UserEmail': user!.email,
      'TimeStamp': Timestamp.now(),
      ...clientData
    });
  }

  // read posts from database
  Stream<QuerySnapshot> getHomeStream() {
    final homeStream = FirebaseFirestore.instance
        .collection('Home')
        .orderBy('TimeStamp')
        .snapshots();

    return homeStream;
  }
}

class FirestoreContract {
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // get collection of client from firebase
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Contract');

  // post a message
  Future<void> addContract(Map<String, dynamic> contractData) {
    print('salom');
    return posts.add({
      'UserEmail': user!.email,
      'TimeStamp': Timestamp.now(),
      ...contractData
    });
  }

  // read posts from database
  Stream<QuerySnapshot> getContractStream() {
    final clientStream = FirebaseFirestore.instance
        .collection('Contract')
        .orderBy('TimeStamp')
        .snapshots();

    return clientStream;
  }
}
