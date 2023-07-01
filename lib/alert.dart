import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Modal Bottom Sheet Example'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Main Content',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 200,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text('Option 1'),
                                  onTap: () {
                                    Navigator.pop(context, 'Option 1');
                                  },
                                ),
                                ListTile(
                                  title: Text('Option 2'),
                                  onTap: () {
                                    Navigator.pop(context, 'Option 2');
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text('Open Bottom Sheet'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
