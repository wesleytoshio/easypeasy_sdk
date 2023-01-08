import 'package:easypeasy_entities/easypeasy_entities.dart';

import 'identifier/app_identifier.dart';

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
  final ProjectSettingsEntity data;
  final void Function(String) onChangedState;
  EasypeasySDK({
    required this.onChangedState,
    required this.data,
  });

  @override
  Future<void> run() async {
    await runAppIdentifier();
    // await runResources();
    // await runPubspec();
    // await runSplash();
    // await runIcon();
    // await runDeepLinking();
  }

  @override
  Future<void> runAppIdentifier() async {
    onChangedState('Working with app identifers...');
    if (data.app == null) return;

    /// Working with [Android]
    if (data.app!.enableAndroidSettings) {
      PackageName androidId = PackageName(
        value: 'br.com.example',
        path: 'S:/meu_app/android',
      );

      /// Run
      await androidId.runAsync();

      /// Working with [Android]
      await runKeystore();
    }

    // /// Working with [IOS]
    // if (data.app!.enableIOSSettings) {
    //   BundleIdentifier iosId = BundleIdentifier(
    //     value: data.app?.bundleIdentifier,
    //     path: data.iosDir,
    //   );

    //   /// Run
    //   await iosId.runAsync();
    // }
  }

  @override
  Future<void> runPubspec() async {
    onChangedState('Working with Pubspec...');
  }

  @override
  Future<void> runIcon() async {
    onChangedState('Working with Launcher Icon...');
  }

  ///Only Android
  @override
  Future<void> runKeystore() async {
    onChangedState('Working with Keystore [Android]...');
  }

  @override
  Future<void> runSplash() async {
    onChangedState('Working with Splash Screen...');
  }

  @override
  Future<void> runResources() async {
    onChangedState('Downloading media resources...');
    // String resourcesPath = '${data.workspace}/resources';
    // if (!exists(resourcesPath)) {
    //   createDir(resourcesPath, recursive: true);
    // }
    // Resources resources = Resources(
    //   output: resourcesPath,
    //   resources: [
    //     ResourceModel(
    //       url:
    //           'https://static-cdn.jtvnw.net/jtv_user_pictures/36e2e2aa-55f7-4e92-b5bb-e8ab4cbcb529-profile_image-70x70.png',
    //       name: 'icon.png',
    //     ),
    //     ResourceModel(
    //       url:
    //           'https://static-cdn.jtvnw.net/jtv_user_pictures/36e2e2aa-55f7-4e92-b5bb-e8ab4cbcb529-profile_image-70x70.png',
    //       name: 'adaptiveIconBackground.png',
    //     ),
    //     ResourceModel(
    //       url:
    //           'https://static-cdn.jtvnw.net/jtv_user_pictures/36e2e2aa-55f7-4e92-b5bb-e8ab4cbcb529-profile_image-70x70.png',
    //       name: 'splash.png',
    //     ),
    //     ResourceModel(
    //       url:
    //           'https://static-cdn.jtvnw.net/jtv_user_pictures/36e2e2aa-55f7-4e92-b5bb-e8ab4cbcb529-profile_image-70x70.png',
    //       name: 'keytore.jks',
    //     ),
    //   ],
    // );

    // await resources.runAsync();
  }

  @override
  Future<void> runDeepLinking() async {
    onChangedState('Working with Deep linking...');
  }
}
