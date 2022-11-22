import 'package:codigo2_alerta2/widgets/colors.dart';
import 'package:flutter/material.dart';

class ButtomCustomWidget extends StatelessWidget {


  String text;
  Function onTap;


  ButtomCustomWidget({required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
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
                  color: kBrandPrimaryColor.withOpacity(0.4))
            ],
            gradient: LinearGradient(colors: [
              kBrandPrimaryColor,
              kBrandSecondaryColor,
            ])),
        child: Text(
          text,
          style: TextStyle(
              color: kFontPrimaryColor.withOpacity(0.75),
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
      onTap: () {
onTap();
      },
    );

  }
}
