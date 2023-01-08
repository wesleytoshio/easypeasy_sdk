import 'package:dcli/dcli.dart';

class DirectoryUtils {
  static Future<String> create(String path) async {
    return createDir(path, recursive: true);
  }

  static String? replacePath(baseDir, current, replace) {
    try {
      String rootDir = rootKtDir(baseDir);
      String subDir = resolvePath(replace);
      return "$rootDir/$subDir";
    } catch (e) {
      print('eeeee $e');
      return null;
    }
  }

  static String rootKtDir(String path) {
    try {
      return RegExp(r'\S*/kotlin').firstMatch(path)!.group(0)!;
    } catch (e) {
      print('eeeee $e');
      return path;
    }
  }

  static String resolvePath(String path) => path.replaceAll('.', '/');
}
