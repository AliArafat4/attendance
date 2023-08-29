import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final storageRef = FirebaseStorage.instance.ref();
final userName = FirebaseAuth.instance.currentUser!.displayName;

Future uploadFile(String filePath) async {
  try {
    //clearing the path's format
    String clearedPath = filePath.split(": ")[1];
    clearedPath = clearedPath.substring(1, clearedPath.length - 1);

    //getting the name of the file
    List filePathSplit = clearedPath.split("/");
    String fileName = filePathSplit[filePathSplit.length - 1];

    //set the reference in Firestore storage
    final fileRef = storageRef.child("$userName/$fileName");

    //select & upload the file into Firestore storage
    File file = File(clearedPath);
    await fileRef.putFile(file);
  } catch (e) {
    return e;
  }
}

Future getFiles() async {
  ListResult storageFiles = await storageRef.root.child("$userName").listAll();
  for (var item in storageFiles.items) {
    print(item);
  }
  return storageFiles;
}

Future downloadFile(String fileName) async {
  //TODO: FIX DOWNLOAD
  final pathReference = storageRef.child("$userName/$fileName");
  final data = await pathReference.getData();
}

// final task = mountainsRef.putFile(largeFile);
//
// // Pause the upload.
// bool paused = await task.pause();
// print('paused, $paused');
//
// // Resume the upload.
// bool resumed = await task.resume();
// print('resumed, $resumed');
//
// // Cancel the upload.
// bool canceled = await task.cancel();
// print('canceled, $canceled');
