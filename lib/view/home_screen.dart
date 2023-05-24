import 'package:flutter/material.dart';

import '../model/file_operations.dart';
import '../user_permissions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _counter;
  UserPermissions permissions = UserPermissions();
  FileOperations excelFiles = ExcelFiles();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 60,
              child: DrawerHeader(
                child: Column(
                  children: [
                    Flexible(
                      child: Text(
                        "\t\t_auth.currentUser?.displayName}",
                        style: TextStyle(fontSize: 20, color: Colors.red[700]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Attendance",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                // Navigator.pushReplacement(
                //     context, MaterialPageRoute(builder: (context) => browse()));
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await checkPermission();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> checkPermission() async {
    await permissions.storagePermission();
    if (permissions.storageStatus.toString().contains('granted')) {
      final file = await excelFiles.selectFile();

      // _counter =
      await excelFiles.readContent(file);
    }
  }
}
