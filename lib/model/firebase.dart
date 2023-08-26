import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
final user = FirebaseFirestore.instance.collection('users');

signup(String name, email, password) async {
  // context.loaderOverlay.show();
  // setState(() {
  //   loading = context.loaderOverlay.visible;
  // });
  try {
    final newUser = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (newUser != null) {
      _auth.currentUser!.updateDisplayName(name);

      //create user doc in Firestore DB
      final user = FirebaseFirestore.instance.collection('users');
      user.doc("${_auth.currentUser?.email}").set({
        'email': _auth.currentUser?.email,
        'level': 0,
        'xp': 0.0,
        'disabled': false,
        'userID': null,
        'public': true,
        'selected interests': [],
        'dob': DateTime.now(),
      });
    }
  } catch (e) {
    // context.loaderOverlay.hide();
    // setState(() {
    //   loading = context.loaderOverlay.visible;
    // });
    // );
  }
}

Future deleteAccount({required String password, required String email}) async {
  try {
    final reAuthUser = await _auth.currentUser?.reauthenticateWithCredential(
      EmailAuthProvider.credential(
        email: email.trim(),
        password: password.trim(),
      ),
    );

    user.doc(_auth.currentUser?.email).update({'disabled': true});
    await reAuthUser?.user?.delete();

    return "correct";
  } on FirebaseAuthException catch (e) {
    print("Failed with error code : ${e.code}");
    print(e.message);
    return "wrong";
  }
}

Future resetPassword({required String currentPassword, required String newPassword}) async {
  try {
    final reAuthUser = await _auth.currentUser?.reauthenticateWithCredential(
      EmailAuthProvider.credential(
        email: _auth.currentUser!.email.toString(),
        password: currentPassword.trim(),
      ),
    );

    await reAuthUser?.user?.updatePassword(newPassword.trim());

    return "correct";
  } on FirebaseAuthException catch (e) {
    print("Failed with error code : ${e.code}");
    print(e.message);
    return "wrong";
  }
}

Future updateEmail({required String currentPassword}) async {
  try {
    final reAuthUser = await _auth.currentUser?.reauthenticateWithCredential(
      EmailAuthProvider.credential(
        email: _auth.currentUser!.email.toString(),
        password: currentPassword.trim(),
      ),
    );

    return "correct";
  } on FirebaseAuthException catch (e) {
    print("Failed with error code : ${e.code}");
    print(e.message);
    return "wrong";
  }
}
