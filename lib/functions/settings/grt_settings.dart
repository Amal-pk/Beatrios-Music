import 'package:url_launcher/url_launcher.dart';

class GetSettings {
  static feedBack() async {
    // ignore: deprecated_member_use
    if (await launch('mailto:amalashok7902@gmail.com')) {
      throw "Try Again";
    }
  }

  static about() async {
    // ignore: deprecated_member_use
    if (await launch('https://amal-pk.github.io/Protfolio/')) {
      throw "Try Again";
    }
  }
}
