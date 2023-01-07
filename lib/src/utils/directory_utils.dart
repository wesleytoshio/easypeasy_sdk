import 'package:dcli/dcli.dart';

class DirectoryUtils {
  static String create(String parent, {String? path}) {
    if (exists(parent)) return parent;
    return createDir(parent, recursive: true);
  }

  static String replacePath(baseDir, current, replace) {
    String rootDir = rootKtDir(baseDir);
    String subDir = resolvePath(replace);
    print('''
    rootDir: $rootDir;
    subDir:  $subDir;
    newDir:  $rootDir/$subDir;
    ''');
    return "$rootDir/$subDir";
  }

  static String rootKtDir(String path) {
    return RegExp(r'\S*/kotlin').firstMatch(path)?.group(0) ?? path;
  }

  static String resolvePath(String path) => path.replaceAll('.', '/');
}
