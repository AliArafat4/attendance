import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

getFoldersSnapshots() {
  final folders = firestore.collection("folders").snapshots();
  return folders;
}

Future getFoldersNames() async {
  final folders = await firestore.collection("folders");
  final names = await folders.get().then((querySnapshot) => {querySnapshot.docs[0]['folders']});

  final filteredNames = names.toString().substring(2, names.toString().length - 2).split(',');
  return filteredNames;
}

Future putFoldersNames(String name) async {
  String docID = '';
  final x = await firestore
      .collection("folders")
      .get()
      .then((querySnapshot) => {docID = querySnapshot.docs[0].id});

  await firestore.collection("folders").doc(docID).update({
    'folders': FieldValue.arrayUnion([name])
  });
}
