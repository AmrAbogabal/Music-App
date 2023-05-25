import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper{
  static SharedPreferences? sharedPrefrences ;
  static init()async{
    sharedPrefrences = await SharedPreferences.getInstance() ;
  }
  static void putData({required String key , required bool Li}){
    sharedPrefrences?.setBool(key,Li);
  }
  static dynamic getData({required String key}){
    return sharedPrefrences?.getBool(key);
  }
}
