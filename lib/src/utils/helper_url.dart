import 'package:url_launcher/url_launcher.dart';

class HelperUrl {
  static void open(url) async => await canLaunchUrl(Uri.parse(url))
      ? await launchUrl(Uri.parse(url))
      : throw 'Could not launch $url';

  static bool checkUrl(url) {
    RegExp exp = RegExp(
        r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?');
    return exp.hasMatch(url);
  }

  static List<String> getUrls(url) {
    RegExp exp = RegExp(
        r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?');
    return exp
        .allMatches(url)
        .map((match) => url.substring(match.start, match.end))
        .cast<String>()
        .toList();
  }
}
