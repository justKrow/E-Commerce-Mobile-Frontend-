import 'language.dart';

class LanguageManager {
  static String currentLocale = 'en_US';

  static String translate(String key) {
    final translations = LocalString().getTranslations(currentLocale);
    return translations[key] ?? '';
  }
}
