import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:tuw_services/main.dart';

String getlocalLanguage(BuildContext context) {
  try {
    // Ensure the Hive box is open before accessing it
    if (!Hive.isBoxOpen('LocalLan')) {
      print('LocalLan box is not open, using default language');
      return 'en';
    }
    
    String lang = Hive.box('LocalLan').get('lang', defaultValue: 'en');
    
    // Validate the language code to ensure it's a valid ISO 639-1 language code
    // Only allow supported languages: 'en', 'hi', 'ar'
    if (lang.isEmpty || !['en', 'hi', 'ar'].contains(lang)) {
      lang = 'en'; // Default to English if invalid
      // Update the stored value to prevent future issues
      try {
        Hive.box('LocalLan').put('lang', lang);
      } catch (e) {
        print('Error updating language in Hive: $e');
      }
    }
    
    try {
      MyApp.of(context).setLocale(
        Locale.fromSubtags(
          languageCode: lang,
        ),
      );
    } catch (e) {
      print('Error setting locale: $e');
      // Fallback to English if locale creation fails
      try {
        MyApp.of(context).setLocale(const Locale('en'));
      } catch (fallbackError) {
        print('Fallback locale also failed: $fallbackError');
      }
    }
    
    print(lang);
    return lang;
  } catch (e) {
    print('Error in getlocalLanguage: $e');
    // Return default language if anything goes wrong
    return 'en';
  }
}
