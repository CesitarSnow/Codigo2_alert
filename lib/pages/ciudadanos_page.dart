import 'package:codigo2_alerta2/api/api_services.dart';
import 'package:codigo2_alerta2/models/ciudadanos_model.dart';
import 'package:codigo2_alerta2/widgets/general_widget.dart';
import 'package:flutter/material.dart';

class CiudadanosPage extends StatelessWidget {
 ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    print(apiService.getCitizen());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Listado de Ciudadanos",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              space10,
              FutureBuilder(
                  future: apiService.getCitizen(),
                  builder: (BuildContext context, AsyncSnapshot snap){
                    if(snap.hasData){
                      List<CiudadanosModel> listData = snap.data;
                      return Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: listData.length,
                          separatorBuilder: (context, index) => const Divider(
                            indent: 12.0,
                            endIndent: 12.0,
                          ),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text((listData[index].fullName == null ? "": listData[index].fullName!),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.80),
                                    fontSize: 15.0
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  space3,
                                  Text(
                                    "Dirección: ${listData[index].address}",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.55),
                                        fontSize: 13.0
                                    ),
                                  ),
                                  space3,
                                  Text(
                                    "Teléfono: ${listData[index].phone}",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.55),
                                        fontSize: 13.0
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Expanded(child: Center(child: CircularProgressIndicator()));
                }


            )
            ],
          ),
        ),
      ),
    );
  }
}
