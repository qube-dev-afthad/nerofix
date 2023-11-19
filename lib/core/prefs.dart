import 'package:hive/hive.dart';

class PrefsBoxKeys {
  static String? mobile = 'mobile';
}

class PrefsDb {
  static var prefsBox = Hive.box('prefs');

  static void saveMobile(String mobile) => prefsBox.put(
        PrefsBoxKeys.mobile,
        mobile,
      );

  static String? get getMobile =>
      prefsBox.get(PrefsBoxKeys.mobile, defaultValue: null);
}
