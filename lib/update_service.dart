import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateService {
  Future<void> downloadAndInstallApk(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getExternalStorageDirectory();
        if (dir == null) {
          throw Exception('External storage directory not available');
        }
        final file = File('${dir.path}/app-release.apk');
        await file.writeAsBytes(bytes);
        
        if (await canInstallPackages()) {
          await OpenFile.open(file.path);
        } else {
          throw Exception('Install permission denied');
        }
      } else {
        throw Exception('Download failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Update failed: $e'); // Log error
      rethrow; // Allow caller to handle error
    }
  }

  Future<bool> canInstallPackages() async {
    if (!Platform.isAndroid) {
      return false;
    }
    
    final bool canInstall = await Permission.requestInstallPackages.isGranted;
    if (!canInstall) {
      final status = await Permission.requestInstallPackages.request();
      return status.isGranted;
    }
    return canInstall;
  }
}
