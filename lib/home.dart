import 'package:flutter/material.dart';

class Todo {
  String title, description;
  int deadline;
  bool isDone;
  Todo(this.title, this.description, this.deadline, this.isDone);
}
class CenterRightFabLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = scaffoldGeometry.scaffoldSize.width - 56.0;
    final double fabY = scaffoldGeometry.contentTop + 325.0;
    return Offset(fabX, fabY);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleControl = TextEditingController();
  final TextEditingController _desControl = TextEditingController();
  final TextEditingController _daysControl = TextEditingController();

  List<Todo> todos = [];
  GlobalKey<FormState> todoForm = GlobalKey<FormState>();
  bool _sheetOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Task Management'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showAddTaskDialog(context);
            },
            child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: _sheetOpen ? CenterRightFabLocation() : FloatingActionButtonLocation.endFloat,
        body: ListView.separated(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return ListTile(
              onLongPress: () {
                setState(() {
                  _sheetOpen = true;
                });
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Task Details',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text('Title: ${todos[index].title.toString()}'),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  'Description: ${todos[index].description.toString()}'),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  'Days required: ${todos[index].deadline.toString()}'),
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    todos.removeAt(index);
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: const Text('Delete')),
                            ],
                          ),
                        ),
                      );
                    }).then((value){
                      setState(() {
                        _sheetOpen = false;
                      });
                });
              },
              title: Text(todos[index].title),
              subtitle: Text(todos[index].description),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 0,
            );
          },
        ));

  }
  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: Form(
            key: todoForm,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _titleControl,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    maxLines: 4,
                    controller: _desControl,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: _daysControl,
                    decoration: const InputDecoration(
                      labelText: 'Days Required',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a deadline';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (todoForm.currentState!.validate()) {
                  todos.add(Todo(_titleControl.text, _desControl.text,
                      int.parse(_daysControl.text), false));
                  setState(() {});
                  _titleControl.clear();
                  _desControl.clear();
                  _daysControl.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
