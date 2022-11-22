import 'package:codigo2_alerta2/widgets/general_widget.dart';
import 'package:flutter/material.dart';

class ItemMenuWidget extends StatelessWidget {

  String text;
  Color color;
  IconData icon;
Function onTap;

  ItemMenuWidget({required this.text, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
       onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
          boxShadow:[ BoxShadow(
            color: Colors.redAccent.withOpacity(0.6),
            offset: Offset(0,4),
            blurRadius: 12,

          ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle
              ),
              child: Icon(icon),
            ),
            space6,
            Text(text)
          ],
        ),
      ),
    );
  }
}
