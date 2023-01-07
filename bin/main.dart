import 'package:easypeasy_sdk/easypeasy.dart';

void main(List<String> args) async {
  EasypeasySDK sdk = EasypeasySDK(
    'S:/meu_app',
    onChangedStage: (stage) {},
    data: ProjectSettingsEntity(),
  );
  sdk.run();
}
