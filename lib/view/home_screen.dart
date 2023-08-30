import 'package:attendance/model/firebase_auth.dart';
import 'package:attendance/view/attendance.dart';
import 'package:attendance/view/login.dart';
import 'package:attendance/view/members.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/file_operations.dart';
import '../model/firebase_storage.dart';
import '../model/firestore.dart';
import '../user_permissions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserPermissions permissions = UserPermissions();
  FileOperations excelFiles = ExcelFiles();

  int? groupValue = 0;
  double textSize = 18;
  var fileContent;
  late Future getFiles;
  var getFoldersNames;
  bool flag = true;
  String selectedFolderName = '';

  @override
  void initState() {
    getFiles = getPrivateFiles();
    getFoldersNames = getFolders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      onDrawerChanged: (isOpened) {
        setState(() {
          flag = isOpened;
        });
      },
      drawer: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: Drawer(
            child: ListView(
              children: [
                SizedBox(
                  height: 70,
                  child: DrawerHeader(
                    child: Column(
                      children: [
                        Flexible(
                          child: Text(
                            "Hello ${FirebaseAuth.instance.currentUser?.displayName}",
                            style: TextStyle(fontSize: 20, color: Colors.teal[700]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    (!flag)
                        ? Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      flag = !flag;
                                    });
                                  },
                                  icon: const Icon(Icons.arrow_back)),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(height: 5),
                    (flag)
                        ? StreamBuilder<QuerySnapshot>(
                            stream: getFoldersNames,
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
                              if (snapShot.hasData) {
                                return ListView(
                                  shrinkWrap: true,
                                  children: snapShot.data!.docs.map((DocumentSnapshot document) {
                                    Map<String, dynamic> data =
                                        document.data()! as Map<String, dynamic>;
                                    return Wrap(
                                      children: List.generate(data['folders'].length, (index) {
                                        return Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                "${data['folders'][index]}",
                                                style: const TextStyle(fontSize: 18),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  selectedFolderName = data['folders'][index];
                                                  flag = !flag;
                                                });
                                              },
                                            ),
                                            Container(
                                              width: 270,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(Radius.circular(100))),
                                              child: const Divider(
                                                thickness: 2,
                                                color: Colors.pink,
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    );
                                  }).toList(),
                                );
                              } else if (snapShot.hasError) {
                                return const Text("Error");
                              } else {
                                return const CircularProgressIndicator();
                              }
                            })
                        : LoadFiles(getFiles: getFiles, folderName: selectedFolderName),
                    //LoadFiles(getFiles: getFiles),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        logout();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                      },
                      child: const Text("Logout")),
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () async {
                await excelFiles.readContent(excelFiles.selectFile());
                uploadFile(excelFiles.path);
                setState(() {});
              },
              icon: const Icon(Icons.file_copy))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 65,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: CupertinoSlidingSegmentedControl<int>(
                backgroundColor: CupertinoColors.white,
                thumbColor: CupertinoColors.systemYellow,
                padding: const EdgeInsets.all(8),
                groupValue: groupValue,
                children: {
                  0: Text(
                    "Attendance",
                    style: TextStyle(fontSize: textSize, color: Colors.black),
                  ),
                  1: Text(
                    "Members",
                    style: TextStyle(fontSize: textSize, color: Colors.black),
                  ),
                  2: Text(
                    "Statistics",
                    style: TextStyle(fontSize: textSize, color: Colors.black),
                  ),
                },
                onValueChanged: (value) {
                  setState(() {
                    groupValue = value;
                  });
                },
              ),
            ),
            (groupValue == 0)
                ? Attendance(excelFile: excelFiles)
                : const SizedBox(height: 0, width: 0),
            (groupValue == 1)
                ? Members(excelFile: excelFiles)
                : const SizedBox(height: 0, width: 0),
            (groupValue == 2) ? Text("$groupValue") : const SizedBox(height: 0, width: 0)
          ],
        ),
      ),
    );
  }

  //Used to select a files if permission granted
  Future<void> checkPermission() async {
    await permissions.storagePermission();
    if (permissions.storageStatus.toString().contains('granted')) {
      final file = await excelFiles.selectFile();

      // _counter =
      await excelFiles.readContent(file);
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      getFiles = getPrivateFiles();
    });
  }
}

class LoadFiles extends StatelessWidget {
  const LoadFiles({
    Key? key,
    required this.getFiles,
    required this.folderName,
  }) : super(key: key);

  final Future getFiles;
  final String folderName;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPrivateFiles(name: folderName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final files = snapshot.data!.items;
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          "${file.name}",
                          style: const TextStyle(fontSize: 18),
                        ),
                        onTap: () {
                          // Navigator.pushReplacement(
                          //     context, MaterialPageRoute(builder: (context) => browse()));
                        },
                      ),
                      Container(
                        width: 270,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(100))),
                        child: const Divider(
                          thickness: 2,
                          color: Colors.pink,
                        ),
                      )
                    ],
                  );
                });
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
