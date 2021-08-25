import 'package:funda_sample/resources/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static SharedPreferences? _appPreferences;

  static init() async {
    _appPreferences = await SharedPreferences.getInstance();
  }

  static void setLocale(String value) {
    _appPreferences?.setString('locale', value);
  }

  static String getLocale() {
    return _appPreferences?.getString('locale') ?? Resources.LOCALE_ENGLISH;
  }

}
