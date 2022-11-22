import 'dart:io';
import 'dart:typed_data';

import 'package:codigo2_alerta2/api/api_services.dart';
import 'package:codigo2_alerta2/models/incident_model.dart';
import 'package:codigo2_alerta2/pages/incident_map_page.dart';
import 'package:codigo2_alerta2/pages/modals/register_incident_modal.dart';
import 'package:codigo2_alerta2/provider/example_provider.dart';
import 'package:codigo2_alerta2/shared_global.dart';
import 'package:codigo2_alerta2/widgets/general_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../models/incidentes_tipos_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class IncidentPage extends StatefulWidget {
  @override
  State<IncidentPage> createState() => _IncidentPageState();
}

class _IncidentPageState extends State<IncidentPage>
    with TickerProviderStateMixin {
  final SharedGlobal global = SharedGlobal();

  List<TipoIncidentes> incidentTypeList = [];
  ApiService apiService = ApiService();

  List<IncidentModel> listData = [];

  @override
  initState() {
    super.initState();
    getData();

  }

  getData() async {
    incidentTypeList = await apiService.getTipoIncidentes();
  }

  showAddIncidentModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      transitionAnimationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 300)),
      builder: (BuildContext context) {
        return RegisterIncidentModal(
          incidentTypeList: incidentTypeList,
        );
      },
    );
  }


  builPDF() async {

    ByteData byteData = await rootBundle.load('assets/images/hoja.png');
Uint8List imageBytes =  byteData.buffer.asUint8List();
    pw.Document PDF = pw.Document();
    PDF.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return [

                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Image(
                          pw.MemoryImage(imageBytes),
                          height: 50
                      ),
                      pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [

                            pw.Text("Bienvenido ${global.dni}",),
                            pw.Text("Av lima 136 - cercado de Lima",),
                            pw.Text("92352352",),
                            pw.Text("central@livecode.com",),

                          ]
                      )
                    ]
                ),
                pw.Divider(),

                pw.ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (pw.Context context, int index){
                return pw.Container(
                  margin: pw.EdgeInsets.symmetric(vertical: 14),
                  padding: pw.EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(
                      width: 1.2,
                      color: PdfColors.black
                    )
                  ),
                child: pw.Row(
                children:[
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children:[
                      pw.Text("Tipo Incidente: "),
                      pw.Text("Ciudadanos: "),
                      pw.Text("Telefono"),
                      pw.Text("DNI"),
                      pw.Text("Fecha"),
                      pw.Text("Hora: "),
                    ],
                  ),

                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                children:[
                pw.Text(listData[index].tipoIncidente.titulo.toString()),
                  pw.Text(listData[index].datosCiudadano.nombres),
                  pw.Text(listData[index].datosCiudadano.dni),
                  pw.Text(listData[index].datosCiudadano.telefono),
                  pw.Text(listData[index].fecha),
                  pw.Text(listData[index].hora),
],
                  ),

                ],
                ),
                );

                },


                ),

              ];
            }
        )

    );
    Uint8List byte = await PDF.save();

    Directory directory = await getApplicationDocumentsDirectory();
    File filePDF = File("${directory.path}/alerta.pdf");
    filePDF.writeAsBytes(byte);
    OpenFilex.open(filePDF.path);
  }


  @override
  Widget build(BuildContext context) {
    ExampleProvider exampleProvider = Provider.of<ExampleProvider>(context);

    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () async {
                ByteData byteData = await rootBundle.load('assets/images/hoja.png');
                Uint8List imageBytes =  byteData.buffer.asUint8List();
                pw.Document PDF = pw.Document();
                PDF.addPage(
                    pw.MultiPage(
                        pageFormat: PdfPageFormat.a4,
                        build: (pw.Context context) {
                          return [

                            pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Image(
                                      pw.MemoryImage(imageBytes),
                                      height: 50
                                  ),
                                  pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end,
                                      children: [

                                        pw.Text("Bienvenido ${exampleProvider.dni}",),
                                        pw.Text("Av lima 136 - cercado de Lima",),
                                        pw.Text("92352352",),
                                        pw.Text("central@livecode.com",),

                                      ]
                                  )
                                ]
                            ),
                            pw.Divider(),

                            pw.ListView.builder(
                              itemCount: listData.length,
                              itemBuilder: (pw.Context context, int index){
                                return pw.Container(
                                  margin: pw.EdgeInsets.symmetric(vertical: 14),
                                  padding: pw.EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          width: 1.2,
                                          color: PdfColors.black
                                      )
                                  ),
                                  child: pw.Row(
                                    children:[
                                      pw.Column(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        children:[
                                          pw.Text("Tipo Incidente: "),
                                          pw.Text("Ciudadanos: "),
                                          pw.Text("Telefono"),
                                          pw.Text("DNI"),
                                          pw.Text("Fecha"),
                                          pw.Text("Hora: "),
                                        ],
                                      ),

                                      pw.Column(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        children:[
                                          pw.Text(listData[index].tipoIncidente.titulo.toString()),
                                          pw.Text(listData[index].datosCiudadano.nombres),
                                          pw.Text(listData[index].datosCiudadano.dni),
                                          pw.Text(listData[index].datosCiudadano.telefono),
                                          pw.Text(listData[index].fecha),
                                          pw.Text(listData[index].hora),
                                        ],
                                      ),

                                    ],
                                  ),
                                );

                              },


                            ),

                          ];
                        }
                    )

                );
                Uint8List byte = await PDF.save();

                Directory directory = await getApplicationDocumentsDirectory();
                File filePDF = File("${directory.path}/alerta.pdf");
                filePDF.writeAsBytes(byte);
                OpenFilex.open(filePDF.path);
              },
              child: Container(

                padding: EdgeInsets.all(14),
                decoration:
                BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                child: Icon(
                  Icons.picture_as_pdf,
                  color: Colors.white,
                ),
              ),
            ),
            space14,
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IncidentMapPage(
                              incidenList: listData,
                            )));
              },
              child: Container(
                padding: EdgeInsets.all(14),
                decoration:
                    BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                child: Icon(
                  Icons.map,
                  color: Colors.white,
                ),
              ),
            ),
            space14,
            FloatingActionButton(
              onPressed: () {
                showAddIncidentModal(context);
              },
              backgroundColor: Colors.black,
              child: Icon(Icons.add),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Listado de  Incidentes",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                space14,
                FutureBuilder(
                  future: apiService.getIncident(),
                  builder: (BuildContext context, AsyncSnapshot snap) {
                    if (snap.hasData) {
                      listData = snap.data;
                      return Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                "${listData[index].tipoIncidente.titulo}",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.80),
                                    fontSize: 15.0),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  space3,
                                  Text(
                                    "Estado: ${listData[index].estado.toString()}",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.55),
                                        fontSize: 13.0),
                                  ),
                                  space3,
                                  Text(
                                    "Area: ${listData[index].tipoIncidente.area}",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.55),
                                        fontSize: 13.0),
                                  ),
                                  space3,
                                  Text(
                                    listData[index].datosCiudadano.nombres,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.55),
                                        fontSize: 13.0),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(listData[index].hora),
                                  Text(listData[index].fecha),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
