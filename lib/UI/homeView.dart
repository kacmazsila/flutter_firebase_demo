import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_firebase_demo/core/services/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDesc = TextEditingController();

  FireBaseService? service;

  @override
  void initState() {
    super.initState();
    service = FireBaseService();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        content: Container(
                      width: 100,
                      height: 200,
                      child: Form(
                          // key: formKey,
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: TextField(
                              controller: taskName,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: 'Task Name'),
                            ),
                          ),
                          TextField(
                            controller: taskDesc,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Task Description'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              taskName.clear();
                              taskDesc.clear();
                            },
                            child: Text('Kaydet'),
                          )
                        ],
                      )),
                    ));
                  });
            },
            child: Icon(Icons.add),
          ),
          body: TabBarView(children: [
            FutureBuilder(
              future: service!.getTasks(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                              key: Key(snapshot.data![index].key!),
                              direction: DismissDirection.horizontal,
                              onDismissed: (direction) async {
                                if (direction == DismissDirection.startToEnd) {
                                  setState(() {
                                    service!.updateTask(snapshot.data![index]);
                                  });
                                } else {
                                  setState(() {
                                    service!.deleteTasks(
                                        snapshot.data![index].key!);
                                  });
                                }
                              },
                              child: snapshot.data![index].done!
                                  ? Card(
                                      child: ListTile(
                                        title:
                                            Text(snapshot.data![index].task!),
                                        subtitle: Text(
                                            snapshot.data![index].description!),
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
              },
            ),
            Center(child: Text('Done')),
          ]),
        ));
  }
}
