import '../utils/platforms_path_utils.dart';
import 'file_path.dart';

class AppIdentifier {
  final String path;
  final List<FilePath> replacementFiles;
  final String value;
  AppIdentifier({
    required this.path,
    required this.replacementFiles,
    required this.value,
  });

  Future<void> runAsync() async {
    await Future.forEach(replacementFiles, (file) async {
      await file.run(value);
    });
  }
}

class PackageName extends AppIdentifier {
  PackageName({
    required String path,
    required value,
  }) : super(
          path: path,
          replacementFiles: PlatformAndroidPathUtils.identifier(path),
          value: value,
        );
}

class BundleIdentifier extends AppIdentifier {
  BundleIdentifier({
    required String path,
    required value,
  }) : super(
          path: path,
          replacementFiles: PlatformIOSPathUtils.identifier(path),
          value: value,
        );
}
