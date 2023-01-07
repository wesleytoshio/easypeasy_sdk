import '../app/app_entity.dart';

class ProjectSettingsEntity {
  final String? workspace;
  final String? resources;
  final String androidPath;
  final String iosPath;
  final AppEntity? workingApp;
  ProjectSettingsEntity({
    this.workspace,
    this.resources,
    this.workingApp,
    this.androidPath = 'android',
    this.iosPath = 'ios',
  });

  ProjectSettingsEntity copyWith(
      {String? workspace,
      String? resources,
      AppEntity? workingApp,
      String? androidPath,
      String? iosPath}) {
    return ProjectSettingsEntity(
      workspace: workspace ?? this.workspace,
      resources: resources ?? this.resources,
      workingApp: workingApp ?? this.workingApp,
      androidPath: androidPath ?? this.androidPath,
      iosPath: iosPath ?? this.iosPath,
    );
  }

  bool get valid => workspace != null && resources != null;
}
