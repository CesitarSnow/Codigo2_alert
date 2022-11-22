import 'package:codigo2_alerta2/models/incident_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IncidentMapPage extends StatefulWidget {
  List<IncidentModel> incidenList;

  IncidentMapPage({required this.incidenList});

  @override
  State<IncidentMapPage> createState() => _IncidentMapPageState();
}

class _IncidentMapPageState extends State<IncidentMapPage> {
  Set<Marker> _marker = {};

  initState() {
    super.initState();
    getMarkers();
  }

  getMarkers() {
    for (var item in widget.incidenList) {
      Marker marker = Marker(
          markerId: MarkerId(_marker.length.toString()),
          position: LatLng(item.latitud, item.longitud),
          onTap: () {
            print(item.tipoIncidente.titulo);
          });
      _marker.add(marker);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(widget.incidenList);
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(-12.078042, -77.093722), zoom: 8),
          markers: _marker,
          /*       onTap: (LatLng position) {
          Marker mymarker =
              Marker(markerId: MarkerId(_marker.length.toString()), position: position,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
              );
          _marker.add(mymarker);
          setState(() {

          });
        },*/
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.incidenList.map((e) =>  Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                margin: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(e.tipoIncidente.titulo.toString()),

                    Text("Ciudadanos: ${e.datosCiudadano.nombres}"),
                    Text("Telefono: ${e.datosCiudadano.telefono}"),
                    Text("Hora: ${e.hora}"),
                    Text("Fecha: ${e.fecha}"),

                  ],
                ),
              )).toList()
            ),
          ),
        )
      ],
    ));
  }
}
