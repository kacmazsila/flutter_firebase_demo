import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('TodoAppDB').snapshots(),
          builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final document = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: document.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: Key('1'),
                          direction: DismissDirection.horizontal,
                          onDismissed: (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                            } else {}
                          },
                          child: document[index]['done']
                              ? Card(
                                  child: ListTile(
                                    title: Text(document[index]['task']),
                                    subtitle:
                                        Text(document[index]['description']),
                                  ),
                                )
                              : SizedBox.shrink());
                    },
                  );
                } else
                  return Card();

              default:
                return CircularProgressIndicator();
            }
          }),
    );
  }
}
