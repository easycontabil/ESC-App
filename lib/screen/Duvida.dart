
import 'package:easycontab/components/Button.dart';
import 'package:easycontab/components/CustomDrawer.dart';
import 'package:easycontab/components/DuvidaText.dart';
import 'package:easycontab/components/FeedAppBar.dart';
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/models/Duvida.dart';
import 'package:easycontab/models/Usuario.dart';
import 'package:easycontab/screen/Duvidas.dart';
import 'package:easycontab/services/DuvidaService.dart';
import 'package:easycontab/utils/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CriarResposta.dart';

class VerDuvida extends StatefulWidget {
  final String duvidaId;
  final bool respostas;

  VerDuvida({ @required this.duvidaId, this.respostas = false });

  @override
  _VerDuvidaState createState() => _VerDuvidaState(duvidaId, this.respostas);
}

class _VerDuvidaState extends State<VerDuvida> {

  Preferences preferences = new Preferences();
  DuvidaService service = new DuvidaService(
    prefix: ApiUrls.prefix, 
    host: ApiUrls.hostqst , 
    path: "qst/doubts",
  );

  bool respostas = false;
  bool ower = false;
  Usuario usuario;
  Duvida duvida;

  void getDuvida(String id) {
    this.service.getDuvida(id, loadDependencies: true).then((response) => {
      setState(() {
        duvida = response;
      })
    });
  }

  _VerDuvidaState(String id, bool respostas) {
    this.respostas = respostas;
    this.service.queryPath = "*deletedAt=null&_doubtReactions=[]&_answers=[]&_user=[]";
    getDuvida(id);
    this.preferences.init().then((value) => {
      setState(() {
        this.usuario = this.preferences.getUser();      
      })
    });
  }

  void fecharDuvida(){
    this.service.fecharDuvida(id: this.widget.duvidaId).then((value) => (){
      print(value);
      Navigator.push( context, MaterialPageRoute(builder: (context) => Duvidas()));
    });
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "FECHAR DÚVIDA",
          overflow: TextOverflow.clip,
          style: GoogleFonts.openSans( color: Color.fromRGBO(78,76,76,1), fontSize: 12, fontWeight: FontWeight.w600),
        ),
        content: Text("Uma dúvida fechada não poderá ser aberta novamente, sua dúvida não poderá mais ser visualizada por nenhum outro usuário. Deseja prosseguir?"),
        actions: [
          CustomButton(label: "CANCELAR", action: (){Navigator.of(context).pop();}, color: Color.fromRGBO(219, 36, 36, 1)),
          CustomButton(label: "CONFIRMAR", action: (){
            Navigator.of(context).pop();
            this.fecharDuvida();
          }),
        ],
      )
    );
  }

  List<Widget> getContent(){
    List<Widget> content = [];

    if( this.duvida == null || this.usuario == null){
      return [ Center( child: CircularProgressIndicator()) ];
    }
    content.add(DuvidaText(duvida: this.duvida, respostasVisible: this.respostas));
    content.add(SizedBox(height: 30));

    if(this.usuario.id == this.duvida.usuario.id){
      this.ower = true;
      content.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              label: "FECHAR", 
              action: (){ this._showAlert(context); }, 
              color: Color.fromRGBO(219, 36, 36, 1)
            ),
            CustomButton(label: "RESOLVER", action: (){}),
          ],
        )   
      );
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(241,237,237, 1),
        drawer: CustomDrawer(),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FeedAppBar(logged: true, height: 150,),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: this.getContent()
                  ),
                ),                
              ],
            ),
          ),
        ),
        floatingActionButton: this.ower == false ? CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: Icon(Icons.add),
            highlightColor: Colors.white,
            onPressed: () {
              Navigator.push( context, MaterialPageRoute(builder: (context) => CriarResposta(this.duvida)) );
            },
          ),
        ) : null
    );
  }
}

