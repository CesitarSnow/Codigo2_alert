import 'package:shared_preferences/shared_preferences.dart';

class SharedGlobal {

  //para que sea singleton

  static final SharedGlobal myInstance = SharedGlobal.mandarina();


  //constructor
  SharedGlobal.mandarina();

  factory SharedGlobal(){
    return myInstance;
  }


    SharedPreferences? prefs  ;


//poner Future es opcional
  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }


  set dni(String value){
    prefs?.setString("dni", value);

  }

  String get dni{
    return prefs?.getString("dni") ?? "-";

  }


}