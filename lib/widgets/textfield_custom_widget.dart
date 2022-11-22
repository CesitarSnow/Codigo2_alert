import 'package:codigo2_alerta2/api/path_production.dart';
import 'package:codigo2_alerta2/widgets/colors.dart';
import 'package:codigo2_alerta2/widgets/general_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCustomWidget extends StatelessWidget {
  String label;
  String hintText;
  InputTypeEnum? inputTypeEnum;

  TextEditingController controller;
  TextFieldCustomWidget(
      {required this.controller, required this.label, required this.hintText, this.inputTypeEnum});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: kFontPrimaryColor.withOpacity(0.75)),
        ),
        space10,
        TextFormField(
          //este elemento es para que el teclado del dispositivo empiece mostrando numeros
          keyboardType: inputTypeMap[inputTypeEnum],
          maxLength: inputTypeEnum == InputTypeEnum.dni ? 8 : null,
//este widget es especial para validar el formato
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9]"))
          
        ],
          
          controller: controller,
          style: TextStyle(color: kFontPrimaryColor.withOpacity(0.5)),
          decoration: InputDecoration(
            //esto es para que desaparesca el contador
            //counter: Text(""),
              //
              hintText: hintText,
              hintStyle: TextStyle(
                  fontSize: 15, color: kFontPrimaryColor.withOpacity(0.5)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: kFontPrimaryColor.withOpacity(0.14),
                    width: 0.8,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: kFontPrimaryColor.withOpacity(0.14),
                    width: 0.8,
                  )),
    errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: BorderSide(
    color: kFontPrimaryColor.withOpacity(0.14),
    width: 0.8,
    )),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: kFontPrimaryColor.withOpacity(0.14),
                  width: 0.8,
                )),
          ),
          validator: (String? value){
            if(value != null && value.isEmpty){
              return "Campo obligatorio";
            }
            else if(inputTypeEnum == InputTypeEnum.dni && value!.length<8){
              return "Ingrese 8 digitos";
            }
            return null;
          },
        ),
      ],
    );
  }
}

class TextFieldCustomPasswordWidget extends StatefulWidget {
  TextEditingController controller;
  String label;
  String hintText;
  InputTypeEnum? inputTypeEnum;


  TextFieldCustomPasswordWidget({required this.controller,required this.label, required this.hintText, this.inputTypeEnum});

  @override
  State<TextFieldCustomPasswordWidget> createState() =>
      _TextFieldCustomPasswordWidgetState();
}

class _TextFieldCustomPasswordWidgetState
    extends State<TextFieldCustomPasswordWidget> {
  bool esInvisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: kFontPrimaryColor.withOpacity(0.75)),
        ),
        space10,
        TextFormField(
          keyboardType: inputTypeMap[InputTypeEnum],
          controller: widget.controller,
          obscureText: esInvisible,
          style: TextStyle(color: kFontPrimaryColor.withOpacity(0.5)),
          decoration: InputDecoration(
            counter: SizedBox(),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  fontSize: 15, color: kFontPrimaryColor.withOpacity(0.5)),
              suffixIcon: IconButton(
                icon: Icon(
                  (esInvisible == true
                      ? Icons.remove_red_eye_rounded
                      : Icons.remove_red_eye_outlined),
                  size: 18,
                  color: kFontPrimaryColor.withOpacity(0.5),
                ),
                onPressed: () {
                  esInvisible = !esInvisible;
                  setState(() {});
                },
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: kFontPrimaryColor.withOpacity(0.14),
                    width: 0.8,
                  )),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: kFontPrimaryColor.withOpacity(0.14),
                    width: 0.8,
                  )),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: kFontPrimaryColor.withOpacity(0.14),
                  width: 0.8,
                )),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: kFontPrimaryColor.withOpacity(0.14),
                  width: 0.8,
                )),
          ),
        validator: (String? value){
            if(value != null && value.isEmpty){
              return "Campo obligatorio";
            }
          return null;
        },
        ),
      ],
    );
  }
}
