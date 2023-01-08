import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:easypeasy_sdk/src/utils/directory_utils.dart';

import '../utils/file_utils.dart';

class FilePath {
  final String name;
  final String relativePath;
  final List<String> paths;
  final RegExp regExp;
  final bool useFinder;
  final bool deleteOldPath;
  final String? fileName;
  FilePath({
    required this.name,
    required this.relativePath,
    required List<String> paths,
    required this.regExp,
    this.fileName,
    this.useFinder = false,
    this.deleteOldPath = false,
  }) : paths = paths.map((path) {
          return path.replaceAll('//', '/');
        }).toList();

  String fileNameByPath(String path) => path.split('/').last;

  factory FilePath.fromFinder({
    required String name,
    required String path,
    required String fileFinder,
    required RegExp regExp,
    bool deleteOldPath = false,
  }) {
    var dir = Directory(path);
    List<String> paths = dir
        .listSync(recursive: true)
        .where((f) => f.path.contains(fileFinder))
        .map((f) => f.path.replaceAll('\\', '/'))
        .toList();
    return FilePath(
      name: name,
      relativePath: path,
      paths: paths,
      regExp: regExp,
      fileName: fileFinder,
      deleteOldPath: deleteOldPath,
    );
  }

  Future<void> run(String newValue) async {
    // await Future.forEach(paths, (path) async {
    //   String? content = await FileUtils.readFileAsString(path.toString());
    //   if (content != null) {
    //     String? oldValue = regExp.firstMatch(content)?.group(1);
    //     await FileUtils.replaceInFile(path, newValue, oldValue);
    //     await Future.delayed(const Duration(seconds: 3));
    //   }
    // });
    await Future.forEach(paths, (path) async {
      String? content = await FileUtils.readFileAsString(path);
      if (content != null) {
        String? oldValue = regExp.firstMatch(content)?.group(1);
        if (deleteOldPath) {
          await FileUtils.replaceInFile(path, newValue, oldValue);
          String? newPath =
              DirectoryUtils.replacePath(path, oldValue, newValue);
          createDir(newPath!, recursive: true);
          copy(path, newPath, overwrite: true);
          deleteDir(path.replaceFirst(fileName!, ''));
        } else {
          await FileUtils.replaceInFile(path, newValue, oldValue);
        }
      }
    });
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'relativePath': relativePath,
        'paths': paths,
        'useFinder': useFinder,
        'deleteOldPath': deleteOldPath
      };

  FilePath copyWith({
    String? name,
    String? relativePath,
    List<String>? paths,
    RegExp? regExp,
    bool? useFinder,
    bool? deleteOldPath,
    String? fileName,
  }) {
    return FilePath(
      name: name ?? this.name,
      relativePath: relativePath ?? this.relativePath,
      paths: paths ?? this.paths,
      regExp: regExp ?? this.regExp,
      useFinder: useFinder ?? this.useFinder,
      deleteOldPath: deleteOldPath ?? this.deleteOldPath,
      fileName: fileName ?? this.fileName,
    );
  }
}
