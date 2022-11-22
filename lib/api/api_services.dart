import 'dart:convert';


import 'package:codigo2_alerta2/api/path_production.dart';
import 'package:codigo2_alerta2/models/ciudadanos_model.dart';
import 'package:codigo2_alerta2/models/incident_model.dart';
import 'package:codigo2_alerta2/models/incidentes_tipos_model.dart';
import 'package:codigo2_alerta2/models/user_model.dart';
import 'package:codigo2_alerta2/pages/modals/incident_register_model.dart';
import 'package:http/http.dart' as http;


class ApiService {

  Future<UserModel?> login(String dni, String password) async {
    Uri uril = Uri.parse("$pathPrdouction/login/");
    http.Response response = await http.post(
      uril,
      headers: {
        "Content-type": "application/json",
      },
      body: json.encode(
        {
          "username": dni,
          "password": password,
        },
      ),
    );
    print(response.statusCode);

    print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      UserModel userModel = UserModel.fromJson(myMap["user"]);
      print(userModel.fullName);
      return userModel;
    }
    return null;
  }

  Future<List<CiudadanosModel>> getCitizen() async {
    Uri _url = Uri.parse("$pathPrdouction/ciudadanos/");
    http.Response response = await http.get(_url);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(utf8.decode(response.bodyBytes));
      List list = myMap["data"];
      List<CiudadanosModel> citizenList =
          list.map((e) => CiudadanosModel.fromJson(e)).toList();
      return citizenList;
    }
    return [];
  }

  Future<List<TipoIncidentes>> getTipoIncidentes() async {
    Uri _url = Uri.parse("$pathPrdouction/incidentes/tipos/");
    http.Response response = await http.get(_url);
    if (response.statusCode == 200) {
      List list = json.decode(response.body);
      //List list = myMap["data"];

      List<TipoIncidentes> incidentesList =
          list.map((e) => TipoIncidentes.fromJson(e)).toList();
      return incidentesList;
    }
    return [];
  }

  Future getIncident() async {
    Uri url = Uri.parse("$pathPrdouction/incidentes/");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      List listData = json.decode(utf8.decode(response.bodyBytes));
      List<IncidentModel> incidentList =
          listData.map((e) => IncidentModel.fromJson(e)).toList();
      print(incidentList);
      return incidentList;
    }
    return [];
  }

  Future<bool>registerIncident(IncidentRegisterModel model) async{
    Uri url = Uri.parse("$pathPrdouction/incidentes/crear/");
    http.Response response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Token a6c46ae38b306142284c12242633a1773a947e70"
      },
      body: json.encode(
        {
          "latitud": model.latitude,
          "longitud": model.longitude,
          "tipoIncidente": model.incidentTpeId,
          "estado": model.status
        }
      ),
    );
  /*if(response.statusCode == 201){
    return true;
  }
  return false;
  */
  return response.statusCode ==  201;
  }





}
