import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController taskName = TextEditingController();
  TextEditingController taskDesc = TextEditingController();

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
            Center(child: Text('Tasks')),
            Center(
              child: Text('Done'),
            )
          ]),
        ));
  }
}
