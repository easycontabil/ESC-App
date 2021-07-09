
import 'package:easycontab/models/Comentario.dart';
import 'package:easycontab/models/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ComentarioComponentCreate extends StatefulWidget {

  // final Usuario dono;
  // final String conteudo;

  final TextEditingController controller;

  ComentarioComponentCreate({ this.controller });

  @override
  _ComentarioComponentCreateState createState() => _ComentarioComponentCreateState();
}

class _ComentarioComponentCreateState extends State<ComentarioComponentCreate> {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only( left: 20, top: 6, right: 20, bottom: 6),
      padding: EdgeInsets.only( left: 10, top: 4, right: 10, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: Container(                 
              child: TextField(
                onSubmitted: (String input){
                  print(input);
                },
                controller: this.widget.controller,
                decoration: InputDecoration(
                  labelText: "COMENTÁRIO"
                ),
              )
            ),
          ),        
        ]
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow( 
            color: Colors.grey,
            offset: Offset(1,3),
            blurRadius: 3
          )
        ]
      ),
    );
  }
}


