
import 'package:easycontab/components/AppBar.dart';
import 'package:easycontab/components/Button.dart';
import 'package:easycontab/components/CustomDrawer.dart';
import 'package:easycontab/components/CustomTextField.dart';
import 'package:easycontab/components/FeedAppBar.dart';
import 'package:easycontab/components/FilterableSelectField.dart';
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/models/Categoria.dart';
import 'package:easycontab/models/Duvida.dart';
import 'package:easycontab/services/CategoriaService.dart';
import 'package:easycontab/services/DuvidaService.dart';
import 'package:flutter/material.dart';

import 'Duvidas.dart';


class EditarDuvida extends StatefulWidget {
  Duvida duvida;

  EditarDuvida({ this.duvida });

  @override
  _EditarDuvidaState createState() => _EditarDuvidaState();
}

class _EditarDuvidaState extends State<EditarDuvida> {
  TextEditingController descricaoController;
  TextEditingController tituloController;

  void initialize() {
    this.tituloController = new TextEditingController(text: this.widget.duvida.titulo);
    this.descricaoController = new TextEditingController(text: this.widget.duvida.descricao);
  }

  DuvidaService service = new DuvidaService( prefix: ApiUrls.prefix, host: ApiUrls.hostqst, path: "qst/doubts");

  void submit(context) async {
    this.widget.duvida.titulo = this.tituloController.text;
    this.widget.duvida.descricao = this.descricaoController.text;

    await service.updateDuvida(id: this.widget.duvida.id, duvida: this.widget.duvida);

    Navigator.push( context, MaterialPageRoute(builder: (context) => Duvidas()) );
  }

  @override
  Widget build(BuildContext context) {
    this.initialize();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(241,237,237, 1),
      drawer: CustomDrawer(),
      body: Container(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  color: Color.fromRGBO(241,237,237, 1),
                  height: 190, width: size.width,
                ),
                Positioned(child: FeedAppBar(logged: true, height: 150,), top: 0),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only( left: 20, top: 6, right: 20, bottom: 6),
              padding: EdgeInsets.only( left: 10, top: 4, right: 10, bottom: 4),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Container(
                          child: Column(
                            children: [
                              CustomTextField(labelText: "TÍTULO", textController: this.tituloController),
                              SizedBox(height: 20),
                              CustomTextField(labelText: "DESCRIÇÃO", textController: this.descricaoController),
                              SizedBox(height: 20),
                              SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomSmallButton(
                                    action: (){
                                      Navigator.pop(context);
                                    },
                                    label: "CANCELAR",
                                    color: Color.fromRGBO(229,64,64,1),
                                  ),
                                  CustomSmallButton(
                                    action: (){
                                      submit(context);
                                    },
                                    label: "ATUALIZAR",
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                            ],
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
            )
          ],
        ),
      ),
    );
  }
}


