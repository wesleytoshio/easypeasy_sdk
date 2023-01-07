library easypeasy_sdk;

import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:easypeasy_sdk/src/entities/project_settings/project_settings_entity.dart';
import 'package:easypeasy_sdk/src/resources/resources.dart';
import 'package:easypeasy_sdk/src/utils/platforms_path_utils.dart';

import 'src/identifier/app_identifier.dart';
import 'src/resources/models/resource_model.dart';

export './src/entities/app/app_entity.dart';
export './src/entities/project_settings/project_settings_entity.dart';
export './src/utils/helper_url.dart';

abstract class EasypeasyBase {
  Future<void> run();
  Future<void> runAppIdentifier();
  Future<void> runKeystore();
  Future<void> runPubspec();
  Future<void> runSplash();
  Future<void> runIcon();
  Future<void> runResources();
  Future<void> runDeepLinking();
}

/// A Calculator.
class EasypeasySDK implements EasypeasyBase {
  final String directory;
  final String androidPath;
  final String iOSPath;
  final ProjectSettingsEntity data;
  final void Function(String) onChangedStage;
  final bool android;
  final bool ios;
  EasypeasySDK(
    this.directory, {
    required this.onChangedStage,
    required this.data,
    this.android = true,
    this.ios = true,
    String androidFolderName = 'android',
    String iOsFolderName = 'ios',
  })  : androidPath = '$directory/$androidFolderName',
        iOSPath = '$directory/$iOsFolderName',
        assert(
          exists(directory),
          'working directory not found',
        );

  @override
  Future<void> run() async {
    await runResources();
    await runPubspec();
    await runAppIdentifier();
    await runSplash();
    await runIcon();
    await runDeepLinking();
  }

  @override
  Future<void> runAppIdentifier() async {
    onChangedStage('Working with app identifers...');

    /// Working with [Android]
    if (android) {
      PackageName(
        value: 'br.com.meuapp2',
        path: androidPath,
        replacementFiles: PlatformAndroidPathUtils.identifier(androidPath),
      ).runAsync();

      /// Working with [Android]
      runKeystore();
    }

    /// Working with [IOS]
    if (ios) {
      BundleIdentifier(
        value: 'br.com.marketing',
        path: iOSPath,
        replacementFiles: PlatformIOSPathUtils.identifier(iOSPath),
      ).runAsync();
    }
  }

  @override
  Future<void> runPubspec() async {
    onChangedStage('Working with Pubspec...');
  }

  @override
  Future<void> runIcon() async {
    onChangedStage('Working with Launcher Icon...');
  }

  ///Only Android
  @override
  Future<void> runKeystore() async {
    onChangedStage('Working with Keystore [Android]...');
  }

  @override
  Future<void> runSplash() async {
    onChangedStage('Working with Splash Screen...');
  }

  @override
  Future<void> runResources() async {
    onChangedStage('Downloading media resources...');
    String resourcesPath = '$directory/resources';
    if (!Directory(resourcesPath).existsSync()) {
      createDir(resourcesPath, recursive: true);
    }
    Resources resources = Resources(
      output: resourcesPath,
      resources: [
        ResourceModel(
          url:
              'https://static-cdn.jtvnw.net/jtv_user_pictures/36e2e2aa-55f7-4e92-b5bb-e8ab4cbcb529-profile_image-70x70.png',
          name: 'icon.png',
        ),
        ResourceModel(
          url:
              'https://static-cdn.jtvnw.net/jtv_user_pictures/36e2e2aa-55f7-4e92-b5bb-e8ab4cbcb529-profile_image-70x70.png',
          name: 'adaptiveIconBackground.png',
        ),
        ResourceModel(
          url:
              'https://static-cdn.jtvnw.net/jtv_user_pictures/36e2e2aa-55f7-4e92-b5bb-e8ab4cbcb529-profile_image-70x70.png',
          name: 'splash.png',
        ),
        ResourceModel(
          url:
              'https://static-cdn.jtvnw.net/jtv_user_pictures/36e2e2aa-55f7-4e92-b5bb-e8ab4cbcb529-profile_image-70x70.png',
          name: 'keytore.jks',
        ),
      ],
    );

    await resources.runAsync();
  }

  @override
  Future<void> runDeepLinking() async {
    onChangedStage('Working with Deep linking...');
  }
}
