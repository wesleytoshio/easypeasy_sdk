import 'package:easypeasy_sdk/src/identifier/file_path.dart';

class PlatformAndroidPathUtils {
  static List<FilePath> identifier(String path) => [
        FilePath.fromFinder(
          name: 'Build Gradle',
          path: '$path/app/',
          fileFinder: 'build.gradle',
          regExp: RegExp(r'applicationId "(.*)"', caseSensitive: true),
        ),
        FilePath.fromFinder(
          name: 'AndroidManifest',
          path: '$path/app/src/',
          fileFinder: 'AndroidManifest.xml',
          regExp: RegExp(r'package="(.*)"', caseSensitive: true),
        ),
        FilePath.fromFinder(
          name: 'MainActivity',
          path: '$path/app/src/main/',
          fileFinder: 'MainActivity.kt',
          regExp: RegExp(r'package (.*)', caseSensitive: true),
          deleteOldPath: true,
        )
      ];
}

class PlatformIOSPathUtils {
  static List<FilePath> identifier(String path) => [
        FilePath.fromFinder(
          name: 'Runner',
          path: '$path/Runner.xcodeproj/',
          fileFinder: 'project.pbxproj',
          regExp: RegExp(
            r'PRODUCT_BUNDLE_IDENTIFIER = (.*);',
            caseSensitive: true,
          ),
        ),
      ];
}
