import 'package:easypeasy_sdk/src/resources/models/resource_model.dart';
import 'package:easypeasy_sdk/src/utils/file_utils.dart';

class Resources {
  final List<ResourceModel> resources;
  final String output;
  Resources({
    required this.resources,
    required this.output,
  });

  Future<void> runAsync() async {
    for (final res in resources) {
      FileUtils.downloadFileNetwork(
        res.url,
        '$output/${res.name}',
      );
    }
  }
}
