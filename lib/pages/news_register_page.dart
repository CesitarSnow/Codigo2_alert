import 'dart:io';

import 'package:codigo2_alerta2/widgets/general_widget.dart';
import 'package:codigo2_alerta2/widgets/textfield_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewsRegisterPage extends StatefulWidget {
  @override
  State<NewsRegisterPage> createState() => _NewsRegisterPageState();
}

class _NewsRegisterPageState extends State<NewsRegisterPage> {
  TextEditingController titleController = TextEditingController();

  TextEditingController linkController = TextEditingController();

  ImagePicker imagePicker = ImagePicker();

  XFile? imageFile;
  XFile? Gallery;

  getImageCamera() async {
     imageFile = await imagePicker.pickImage(source: ImageSource.camera);
    //print(xFile!.path);
    if (imageFile != null) {
      setState(() {});
    }
  }

  getImageGallery() async {
    Gallery = await imagePicker.pickImage(source: ImageSource.gallery);
    //print(xFile!.path);
    if (Gallery != null) {
      setState(() {});
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Registrar Noticias",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFieldCustomWidget(
                controller: titleController,
                label: "Titulo",
                hintText: "Ingrese un Titulo",
              ),
              space14,
              TextFieldCustomWidget(
                controller: titleController,
                label: "Link",
                hintText: "Ingresa un link",
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        getImageCamera();
                      },
                      icon: Icon(Icons.camera),
                      label: Text("Camara"),
                    ),
                  ),
                  spaceWidth10,
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {

                        getImageGallery();
                      },
                      icon: Icon(Icons.image),
                      label: Text("Galeria"),
                    ),
                  ),
                ],
              ),
              space14,
              Gallery != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(14),
                    child: Image(
                        image: FileImage(File(Gallery!.path)),
                      ),
                  )
                  : SizedBox(),
              space14,
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 12,
                            offset: Offset(0, 4),
                            color: Colors.black.withOpacity(0.4))
                      ],
                      gradient: const LinearGradient(colors: [
                        Colors.black,
                        Colors.white,
                      ])),
                  child: Text(
                    "Registrar Noticias",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.75),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                onTap: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
