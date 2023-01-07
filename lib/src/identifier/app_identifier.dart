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

  Future<bool> runAsync() async {
    for (FilePath file in replacementFiles) {
      await file.run(value);
    }

    return true;
  }
}

class PackageName extends AppIdentifier {
  PackageName({
    required String path,
    required List<FilePath> replacementFiles,
    required value,
  }) : super(
          path: path,
          replacementFiles: replacementFiles,
          value: value,
        );
}

class BundleIdentifier extends AppIdentifier {
  BundleIdentifier({
    required String path,
    required List<FilePath> replacementFiles,
    required value,
  }) : super(
          path: path,
          replacementFiles: replacementFiles,
          value: value,
        );
}
