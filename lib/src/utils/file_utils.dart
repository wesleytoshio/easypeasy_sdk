import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'package:xml2json/xml2json.dart';

class FileUtils {
  static Future<void> replaceInFile(String path, newValue, oldValue) async {
    String? contents = await readFileAsString(path);
    if (contents == null) return;
    contents = contents.replaceAll(oldValue, newValue);
    await writeFileFromString(path, contents);
  }

  static Future<String?> readFileAsString(String path) async {
    var file = File(path);
    String? contents;

    if (await file.exists()) {
      contents = await file.readAsString();
    }
    return contents;
  }

  static Future<void> writeFileFromString(String path, String contents) async {
    var file = File(path);
    await file.writeAsString(contents);
  }

  static Future<void> deleteOldDirectories(
      String lang, String oldPackage, String basePath) async {
    var dirList = oldPackage.split('.');
    var reversed = dirList.reversed.toList();

    for (int i = 0; i < reversed.length; i++) {
      String path = '$basePath$lang/${dirList.join('/')}';

      if (Directory(path).listSync().toList().isEmpty) {
        Directory(path).deleteSync();
      }
      dirList.removeLast();
    }
  }

  static Future<void> deleteDir(String dir) async {
    return Directory(dir).deleteSync();
  }

  static Future<void> deleteDirs(String directory, List<String> dirs) async {
    for (var dir in dirs) {
      Directory('$directory/$dir').deleteSync();
    }
  }

  static Future<Map<String, dynamic>> getJsonData(jsonFile) async {
    String? contents = await readFileAsString(jsonFile);
    return json.decode(contents!);
  }

  static Future getXmlAttributeValue(
      String path, String elementName, String attributeName) async {
    if (await File(path).exists()) {
      String? contents = await readFileAsString(path);
      XmlDocument document = XmlDocument.parse(contents!);
      return document
          .findAllElements(elementName)
          .first
          .getAttribute(attributeName);
    }
  }

  static Future changeCFBundleName(String path, String newCFBundleName) async {
    if (await File(path).exists()) {
      final jsonXml = await getJsonFromXMLFile(path);
      List keys = List.from(jsonXml['plist']['dict']['key']);
      List values = List.from(jsonXml['plist']['dict']['string']);
      print(keys);
      var oldCFBundleName = values[keys.indexOf('CFBundleName')];
      print(oldCFBundleName);
      replaceInFile(path, oldCFBundleName, newCFBundleName);
    }
  }

  static Future getJsonFromXMLFile(path) async {
    final Xml2Json xml2Json = Xml2Json();

    try {
      var content = await File(path).readAsString();
      xml2Json.parse(content);

      var jsonString = xml2Json.toParker();
      return jsonDecode(jsonString);
    } catch (e) {
      rethrow;
    }
  }

  static Future<File> downloadFileNetwork(String url, String path) async {
    http.Response response = await http.get(Uri.parse(url));
    File file = File(path);
    file.createSync(recursive: true);
    return await file.writeAsBytes(response.bodyBytes);
  }

  static String fileName(String path) => path.split('/').last;
}
