
import 'package:codigo2_alerta2/pages/ciudadanos_page.dart';
import 'package:codigo2_alerta2/pages/incident_page.dart';
import 'package:codigo2_alerta2/pages/incident_type_page.dart';
import 'package:codigo2_alerta2/pages/news_page.dart';
import 'package:codigo2_alerta2/provider/example_provider.dart';
import 'package:codigo2_alerta2/shared_global.dart';

import 'package:codigo2_alerta2/widgets/general_widget.dart';
import 'package:codigo2_alerta2/widgets/item_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SharedGlobal global = SharedGlobal();





  @override
  Widget build(BuildContext context) {

    ExampleProvider exampleProvider = Provider.of<ExampleProvider>(context);



    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                 children: [
                   Text(
                     "BIENVENIDO: ",
                     style: TextStyle(
                         color: Colors.black.withOpacity(0.8),
                         fontSize: 13,
                         fontWeight: FontWeight.normal),
                   ),
                   Text(exampleProvider.dni.toUpperCase(),style: TextStyle(fontWeight: FontWeight.w700),)
                 ],
              ),

              space10,
              Text(
                "Elige tu Categoria: ",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.65),
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              ),
             space30,
             Expanded(
                child: GridView.count(crossAxisCount: 2,
                childAspectRatio: 1.6,
                //este es para el espacio vertical
                crossAxisSpacing: 10,
                //este es para el espacio horizontal
                mainAxisSpacing: 10,


                children: [
                  ItemMenuWidget(color: Colors.redAccent,
                  icon: Icons.people,
                    text: "Ciudadanos",
                    onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CiudadanosPage()));
                    },
                  ),
                  ItemMenuWidget(color: Colors.yellowAccent,
                    icon: Icons.add_alert,
                    text: "Incidentes",
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>IncidentPage()));
                      global.dni = exampleProvider.dni;
                    },
                  ),
                  ItemMenuWidget(color: Colors.greenAccent,
                    icon: Icons.newspaper,
                    text: "Noticias",
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsPage()));

                    },
                  ),
                  ItemMenuWidget(color: Colors.blueAccent,
                    icon: Icons.bar_chart,
                    text: "Reportes",
                    onTap: (){},
                  ),
                  ItemMenuWidget(color: Colors.purple,
                    icon: Icons.warning,
                    text: "Tipos de Incidentes",
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>IncidentTypePage()));


                    },
                  ),
                  ],

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
