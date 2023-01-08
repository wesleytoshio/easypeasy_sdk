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
    await Future.forEach(resources, (res) async {
      await FileUtils.downloadFileNetwork(
        res.url,
        '$output/${res.name}',
      );
    });
  }
}
