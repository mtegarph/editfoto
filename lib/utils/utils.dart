import 'package:permission_handler/permission_handler.dart';
//fungsi untuk memberikan permission membuka gallery jika belum diizinkan
Future<bool> requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}
