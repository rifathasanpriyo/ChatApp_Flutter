import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceHelper{ 

static String userIdKey="USERIDKEY";
static String userNameKey="USERNAMEKEY";
static String userMailKey="USERMAILKEY";
static String userPhotoKey="USERPHOTOKEY";
static String userDisplayName="USERDISPLAYNAME";

Future<bool>saveUserId(String getUserId)async{ 
SharedPreferences prefs= await SharedPreferences.getInstance();
return prefs.setString(userIdKey, getUserId);

}
Future<bool>saveUserName(String getUserName)async{ 
SharedPreferences prefs= await SharedPreferences.getInstance();
return prefs.setString(userNameKey, getUserName);

}
Future<bool>saveUserMail(String getUserMail)async{ 
SharedPreferences prefs= await SharedPreferences.getInstance();
return prefs.setString(userMailKey, getUserMail);

}
Future<bool>saveUserPhoto(String getUserPhoto)async{ 
SharedPreferences prefs= await SharedPreferences.getInstance();
 return prefs.setString(userPhotoKey, getUserPhoto);

 }
Future<bool>saveUserDisplayName(String getUserDisplayName)async{ 
SharedPreferences prefs= await SharedPreferences.getInstance();
return prefs.setString(userDisplayName, getUserDisplayName);

}





Future<String?>getUserId()async{ 

SharedPreferences prefs=await SharedPreferences.getInstance();
return prefs.getString(userIdKey);

}
Future<String?>getUserName()async{ 

SharedPreferences prefs=await SharedPreferences.getInstance();
return prefs.getString(userNameKey);

}
Future<String?>getUserMail()async{ 

SharedPreferences prefs=await SharedPreferences.getInstance();
return prefs.getString(userMailKey);

}
 Future<String?>getUserPhoto()async{ 

SharedPreferences prefs=await SharedPreferences.getInstance();
 return prefs.getString(userPhotoKey);

}
Future<String?>getUserDisplayName()async{ 

SharedPreferences prefs=await SharedPreferences.getInstance();
return prefs.getString(userDisplayName);

}


}