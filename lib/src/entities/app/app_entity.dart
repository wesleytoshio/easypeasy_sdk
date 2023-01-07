import '../../utils/helper_url.dart';

class AppEntity {
  final String? id;
  final String name;
  final String? packageName;
  final String? bundleIdentifier;
  final IconEntity icon;
  final KeystoreEntity? keystore;
  final SplashOptionEntity splash;
  final bool enableAndroidSettings;
  final bool enableIOSSettings;
  final bool enableAppLinks;
  final String? createdAt;
  final String? updatedAt;
  final AppLinksEntity? appLinks;
  AppEntity({
    this.id,
    required this.name,
    required this.icon,
    required this.splash,
    this.packageName,
    this.bundleIdentifier,
    this.keystore,
    this.enableAndroidSettings = false,
    this.enableIOSSettings = false,
    this.enableAppLinks = false,
    this.createdAt,
    this.updatedAt,
    this.appLinks,
  });

  AppEntity copyWith({
    String? id,
    String? name,
    String? packageName,
    String? bundleIdentifier,
    IconEntity? icon,
    SplashOptionEntity? splash,
    KeystoreEntity? keystore,
    bool? enableAndroidSettings,
    bool? enableIOSSettings,
    bool? enableAppLinks,
    AppLinksEntity? appLinks,
  }) {
    return AppEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      packageName: packageName ?? this.packageName,
      bundleIdentifier: bundleIdentifier ?? this.bundleIdentifier,
      icon: icon ?? this.icon,
      keystore: keystore ?? this.keystore,
      splash: splash ?? this.splash,
      enableAndroidSettings:
          enableAndroidSettings ?? this.enableAndroidSettings,
      enableIOSSettings: enableIOSSettings ?? this.enableIOSSettings,
      enableAppLinks: enableAppLinks ?? this.enableAppLinks,
      appLinks: appLinks ?? this.appLinks,
    );
  }

  factory AppEntity.fromEmpty() => AppEntity(
        name: '',
        packageName: '',
        bundleIdentifier: '',
        icon: IconEntity.fromEmpty(),
        splash: SplashOptionEntity.fromEmpty(),
        keystore: KeystoreEntity.fromEmpty(),
      );

  bool get valid =>
      name.isNotEmpty &&
      packageName!.isNotEmpty &&
      bundleIdentifier!.isNotEmpty &&
      icon.valid &&
      splash.valid &&
      keystore!.valid;
}

class KeystoreEntity {
  final String storePassword;
  final String keyPassword;
  final String keyAlias;
  final String file;
  KeystoreEntity({
    required this.storePassword,
    required this.keyPassword,
    required this.keyAlias,
    required this.file,
  });

  KeystoreEntity copyWith({
    String? storePassword,
    String? keyPassword,
    String? keyAlias,
    String? file,
  }) {
    return KeystoreEntity(
      storePassword: storePassword ?? this.storePassword,
      keyPassword: keyPassword ?? this.keyPassword,
      keyAlias: keyAlias ?? this.keyAlias,
      file: file ?? this.file,
    );
  }

  factory KeystoreEntity.fromEmpty() => KeystoreEntity(
        storePassword: '',
        keyPassword: '',
        keyAlias: '',
        file: '',
      );

  bool get isRemoteFile => HelperUrl.checkUrl(file);

  bool get valid => validCredential && file.isNotEmpty;

  bool get validCredential =>
      storePassword.isNotEmpty && keyPassword.isNotEmpty && keyAlias.isNotEmpty;

  String get fileName => file.split('\\').last;
}

class SplashOptionEntity {
  final String color;
  final String image;
  final String? colorDark;
  final String? imageDark;
  final SplashOptionAndroid12Entity? android12;
  SplashOptionEntity({
    required this.color,
    required this.image,
    this.colorDark,
    this.imageDark,
    required this.android12,
  });

  SplashOptionEntity copyWith({
    String? color,
    String? image,
    String? colorDark,
    String? imageDark,
    SplashOptionAndroid12Entity? android12,
  }) {
    return SplashOptionEntity(
      color: color ?? this.color,
      image: image ?? this.image,
      colorDark: colorDark ?? this.colorDark,
      imageDark: imageDark ?? this.imageDark,
      android12: android12 ?? this.android12,
    );
  }

  factory SplashOptionEntity.fromEmpty() => SplashOptionEntity(
        color: '',
        image: '',
        android12: SplashOptionAndroid12Entity.fromEmpty(),
      );

  bool get isRemoteimage => HelperUrl.checkUrl(image);
  bool get isRemoteimageDark => HelperUrl.checkUrl(imageDark);

  bool get valid =>
      image.isNotEmpty &&
      color.isNotEmpty &&
      colorDark != null &&
      imageDark != null;
}

class SplashOptionAndroid12Entity {
  final String image;
  final String color;
  final String? iconBackgroundColor;

  SplashOptionAndroid12Entity({
    required this.image,
    required this.color,
    this.iconBackgroundColor,
  });

  SplashOptionAndroid12Entity copyWith({
    String? image,
    String? color,
    String? iconBackgroundColor,
  }) {
    return SplashOptionAndroid12Entity(
      image: image ?? this.image,
      color: color ?? this.color,
      iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
    );
  }

  factory SplashOptionAndroid12Entity.fromEmpty() =>
      SplashOptionAndroid12Entity(
        color: '',
        image: '',
      );

  bool get valid =>
      image.isNotEmpty && color.isNotEmpty && iconBackgroundColor != null;
  bool get isRemoteimage => HelperUrl.checkUrl(image);
}

class IconEntity {
  final String file;
  final String? adaptiveIconBackground;
  IconEntity({required this.file, this.adaptiveIconBackground});

  IconEntity copyWith({
    String? file,
    String? adaptiveIconBackground,
  }) {
    return IconEntity(
      file: file ?? this.file,
      adaptiveIconBackground:
          adaptiveIconBackground ?? this.adaptiveIconBackground,
    );
  }

  factory IconEntity.fromEmpty() => IconEntity(
        adaptiveIconBackground: '',
        file: '',
      );

  bool get valid => file.isNotEmpty;
  bool get isRemoteFile => HelperUrl.checkUrl(file);
}

class AppLinksEntity {
  final List<AppUrlEntity>? urls;
  final String sha256Debug;
  final String sha256Release;
  final String appleTeamID;
  AppLinksEntity({
    this.urls = const [],
    this.sha256Debug = "",
    this.sha256Release = "",
    this.appleTeamID = "",
  });

  AppLinksEntity copyWith({
    List<AppUrlEntity>? urls,
    String? sha256Debug,
    String? sha256Release,
    String? appleTeamID,
  }) {
    return AppLinksEntity(
      urls: urls ?? this.urls,
      sha256Debug: sha256Debug ?? this.sha256Debug,
      sha256Release: sha256Release ?? this.sha256Release,
      appleTeamID: appleTeamID ?? this.appleTeamID,
    );
  }

  bool get hasValidSha256 => sha256Debug.isNotEmpty && sha256Release.isNotEmpty;
}

class AppUrlEntity {
  final String url;
  final String scheme;
  final String host;
  AppUrlEntity({
    required this.url,
  })  : scheme = Uri.parse(url).scheme,
        host = Uri.parse(url).host;

  AppUrlEntity copyWith({String? url}) {
    return AppUrlEntity(url: url ?? this.url);
  }
}
