import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

getFolders() {
  final folders = firestore.collection("folders").snapshots();
  return folders;
}
