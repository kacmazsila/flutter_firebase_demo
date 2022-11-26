import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'UI/homeView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter fireBase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
      // home: Scaffold(
      //   body: StreamBuilder(
      //     stream: FirebaseFirestore.instance
      //         .collection('TodoAppDB')
      //         .snapshots(),
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       } else {
      //         final documents = snapshot.data!.docs;
      //         return ListView.builder(
      //           itemBuilder: (context, index) {
      //             return Padding(
      //               padding: const EdgeInsets.all(8),
      //               child:
      //                Text(documents[index]['sehir']),

      //             );
      //           },
      //           itemCount: documents.length,
      //         );
      //       }
      //       return Center();
      //     },
      //   ),
      // ),
    );
  }
}
