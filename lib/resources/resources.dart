import 'package:flutter/material.dart';
import 'package:fund_sample/data/repository/local/app_preferences.dart';

class Resources {

  // Colors
  static const Color APP_PRIMARY_COLOR = const Color.fromARGB(255,247,161,0);
  static const Color APP_ACCENT_COLOR = Color.fromARGB(255,96,197,248);
  static const Color APP_OUTLINE_COLOR = const Color.fromARGB(255,210,210,210);
  static const Color APP_PRIMARY_A33 = const Color.fromARGB(56,247,161,0);

  static const LOCALE_ENGLISH = 'en';
  static const LOCALE_DUTCH = 'nl';

// ignore: non_constant_identifier_names
  static Map<String, String> _strings_en = {
    'app__name': 'Funda Sample App',

    'general__no_internet': 'An error occurred during processing your request\nplease try again later',
    'general__server_error': 'Error occurred while Communication with Server with StatusCode : [0]',
    'general__ok' : 'OK',
    'general__mm' : '<b>[0]</b>&nbsp;m&sup2;',

    'home__rooms' : '<b>[0]</b> Room(s)',
    'home__bathrooms' : '<b>[0]</b> Bathroom(s)',
    'home__description' : 'Description',
    'home__specification' : 'Specification',
    'home__price_formatted' : '€ [0]',


    'photo_gallery__count_indicator': '[0] of [1]',
  };

  static Map<String, String> _strings_nl = {
    'app__name': 'Funda voorbeeldtoepassing',

    'home__rooms' : '<b>[0]</b> AantalKamers',
    'home__bathrooms' : '<b>[0]</b> AantalBadkamers',
    'home__description' : 'Omschrijving',
    'home__specification' : 'Kenmerken',
    'home__price_formatted' : '€ [0] kosten koper',

    'general__mm' : '<b>[0]</b>&nbsp;m&sup2;',
  };

  static String getStringWithPlaceholder(String key, List<dynamic>? placeHolders) {
    Map<String, String> _strings;

    if(AppPreferences.getLocale() == LOCALE_DUTCH) {
      _strings = _strings_nl;
    }
    else
      _strings = _strings_en;

    if(_strings[key]==null)
      _strings = _strings_en;

    if(placeHolders==null){
      return _strings[key]??key;
    }else{
      var string = _strings[key];
      for(int i=0;i<placeHolders.length;i++){
        string = string?.replaceAll('[$i]',placeHolders[i]);
      }
      return string??key;
    }
  }

  static String getString(String key) {
    return  getStringWithPlaceholder(key, null);
  }

  // App Styles
  static TextStyle getToolbarTitleStyle()
  {
    return const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);
  }

  static TextStyle getTitleStyle()
  {
    return const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);
  }

  static TextStyle getMediumStyle()
  {
    return const TextStyle(fontSize: 14, color: Colors.black);
  }

  static TextStyle getNormalTextStyle()
  {
    return const TextStyle(color: Colors.grey,fontSize: 14);
  }

  static TextStyle getNormalLightTextStyle()
  {
    return const TextStyle(color: Colors.white,fontSize: 14);
  }
}


