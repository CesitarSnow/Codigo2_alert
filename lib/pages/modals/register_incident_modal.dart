import 'dart:convert';

import 'package:codigo2_alerta2/api/api_services.dart';
import 'package:codigo2_alerta2/models/incidentes_tipos_model.dart';
import 'package:codigo2_alerta2/pages/buttom_custom_widget.dart';
import 'package:codigo2_alerta2/pages/modals/incident_register_model.dart';
import 'package:codigo2_alerta2/widgets/general_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RegisterIncidentModal extends StatefulWidget {
  List<TipoIncidentes> incidentTypeList;

  RegisterIncidentModal({required this.incidentTypeList});

  @override
  State<RegisterIncidentModal> createState() => _RegisterIncidentModalState();
}

class _RegisterIncidentModalState extends State<RegisterIncidentModal> {
  int incidentValue = 1;
  Position? position;

  @override
  void iniState() {
    super.initState();
    incidentValue = widget.incidentTypeList.first.id;
    getData();
  }

  getData() async {
    position = await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          )),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           const Text(
              "Registrar Incidente",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            space6,
            Text(
              "Por favor seleccione un incidente para ser enviado ala central",
              style:
                  TextStyle(fontSize: 18, color: Colors.black.withOpacity(0.6)),
              textAlign: TextAlign.center,
            ),
            space14,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 1.2)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(14),
                  alignment: Alignment.topLeft,
                  elevation: 6,
                  value: incidentValue,
                  isExpanded: true,
                  items: widget.incidentTypeList
                      .map((e) =>
                          DropdownMenuItem(value: e.id, child: Text(e.titulo!)))
                      .toList(),
                  onChanged: (int? value) {
                    incidentValue = value!;
                    setState(() {});
                  },
                ),
              ),
            ),
            space30,
            ButtomCustomWidget(
                text: "Registrar Incidente",
                onTap: () async {
                  ApiService apiService = ApiService();
                  IncidentRegisterModel model = IncidentRegisterModel(
                    latitude: 0,
                    longitude: 0,
                    incidentTpeId: incidentValue,
                    status: "Abierto",
                  );
                  bool res = await apiService.registerIncident(model);

                  if (res) {
                    Navigator.pop(context);
                  }
                })
          ],
        ),
      ),
    );
  }
}
