import 'package:codigo2_alerta2/pages/news_register_page.dart';
import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsRegisterPage()));

        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }
}
