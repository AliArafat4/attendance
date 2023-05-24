import 'package:permission_handler/permission_handler.dart';

class UserPermissions {
  PermissionStatus _storageStatus = PermissionStatus.denied;

  Future<String> storagePermission() async {
    _storageStatus = await Permission.storage.status;
    _storageStatus = await Permission.storage.request();
    if (_storageStatus.toString().contains("granted")) {
      return "granted";
    } else {
      return "not granted";
    }
  }

  get storageStatus => _storageStatus;
}
