import 'package:codigo2_alerta2/api/api_services.dart';
import 'package:codigo2_alerta2/models/incidentes_tipos_model.dart';
import 'package:codigo2_alerta2/widgets/general_widget.dart';
import 'package:flutter/material.dart';

class IncidentTypePage extends StatelessWidget {
  ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Listado de tipo de Incidentes",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              space10,
              FutureBuilder(
                  future: apiService.getTipoIncidentes(),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.hasData) {
                      List<TipoIncidentes> listData = snap.data;
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
                              title: Text(
                                "id : ${listData[index].id.toString()}",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.80),
                                    fontSize: 15.0),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  space3,
                                  Text(
                                    "Area: ${listData[index].area.toString()}",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.55),
                                        fontSize: 13.0),
                                  ),
                                  space3,
                                  Text(
                                    listData[index].text,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.55),
                                        fontSize: 13.0),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const CircularProgressIndicator();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
