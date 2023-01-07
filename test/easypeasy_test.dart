import 'package:easypeasy_sdk/easypeasy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  EasypeasySDK sdk = EasypeasySDK('S:/meu_app');

  test("Cria um diretorio", () async {
    sdk.runAppIdentifier();
  });
}
