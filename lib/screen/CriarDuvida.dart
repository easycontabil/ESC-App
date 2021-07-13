
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


class CriarDuvida extends StatefulWidget {
  
  @override
  _CriarDuvidaState createState() => _CriarDuvidaState();
}

class _CriarDuvidaState extends State<CriarDuvida> {

  _CriarDuvidaState(){
    this.loadCategorias();
  }

  CategoriaService categoriaService = new CategoriaService( prefix: ApiUrls.prefix, host: ApiUrls.hostqst ,path: "qst/categories");
  DuvidaService service = new DuvidaService( prefix: ApiUrls.prefix, host: ApiUrls.hostqst, path: "qst/doubts");

  TextEditingController descricaoController = new TextEditingController();
  TextEditingController categoriaController = new TextEditingController();
  TextEditingController tituloController = new TextEditingController();
  
  List<Categoria> categorias = [];
  List<String> categoriasStr;

  void loadCategorias(){
    this.categoriaService.getCategorias().then((response){
      setState((){
        this.categorias = response;
      });
      this.categoriasStr = this.categorias.map((e) => e.nome).toList();
    }); 
  }

  void submit(context) async {
    Duvida duvida = new Duvida(
      titulo: this.tituloController.text,
      descricao: this.descricaoController.text,
      categorias: this.categorias.where((x) => x.nome == this.categoriaController.text).toList()
    );
    await service.registerDuvida(duvida);

    Navigator.push( context, MaterialPageRoute(builder: (context) => Duvidas()) );
  }

  @override
  Widget build(BuildContext context) {

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
                this.categorias == null ? CircularProgressIndicator(backgroundColor: Colors.white) :
                FilterableSelectField(labelText: "CATEGORIA", sugestions: this.categoriasStr, textController: this.categoriaController, margin: EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40))            
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
                                label: "CRIAR",
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


