import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  save(String key,value)async{
    final prefs= await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
  }

  read(String key)async{
    final prefs=await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString(key).toString());
  }

  clear()async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.clear();
  }

}