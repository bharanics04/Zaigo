import 'package:shared_preferences/shared_preferences.dart';

class LocalDataProvider{

  Future<bool> saveUserDetails(String token,String name) async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", token);
    sharedPreferences.setString("name", name);
    return true;
  }

  Future<bool> clear() async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    sharedPreferences.clear();
    return true;
  }

  Future<String?> getAccessToken() async{
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    return sharedPreferences.getString("access_token");
  }

}