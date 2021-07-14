import 'package:easycontab/components/CustomDrawer.dart';
import 'package:easycontab/components/DuvidaComponent.dart';
import 'package:easycontab/components/FeedAppBar.dart';
import 'package:easycontab/components/SearchTextField.dart';
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/models/Duvida.dart';
import 'package:easycontab/models/Usuario.dart';
import 'package:easycontab/screen/CriarDuvida.dart';
import 'package:easycontab/services/DuvidaService.dart';
import 'package:flutter/material.dart';

class MinhasDuvidas extends StatefulWidget {
  Usuario usuario;
  String likeTitle;

  MinhasDuvidas({ @required this.usuario, this.likeTitle = null });

  @override
  _MinhasDuvidasState createState() => _MinhasDuvidasState(this.usuario, this.likeTitle);
}

class _MinhasDuvidasState extends State<MinhasDuvidas> {
  DuvidaService service = new DuvidaService( prefix: ApiUrls.prefix, host: ApiUrls.hostqst , path: "qst/doubts");

  List<Duvida> duvidas = [];

  getDuvidas(Usuario usuario) {
    this.service.getDuvidas(loadDependencies: true).then((response) => {
      setState(() {
        duvidas = response;
      })
    });
  }

  _MinhasDuvidasState(Usuario usuario, String likeTitle) {
    this.service.queryPath = "*deletedAt=null&_doubtReactions=[]&_user=[]&_answers=[]&_categories=[]&*userId=${usuario.id}";

    if (likeTitle != null) {
      this.service.queryPath += "&*title=%${likeTitle}";
    }

    getDuvidas(usuario);
  }

  List<DuvidaComponent> listaDuvidas() {
    List<DuvidaComponent> duvidaComponents = [];

    for (var duvida in this.duvidas) {
      duvidaComponents.add(DuvidaComponent(duvida: duvida,));
    }

    return duvidaComponents;
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
                  SearchField(labelText: "BUSCAR", margin: EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40), onSubmitted: (value) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MinhasDuvidas(usuario: this.widget.usuario, likeTitle: value)));
                  }),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children: listaDuvidas()
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: Icon(Icons.add),
            highlightColor: Colors.white,
            onPressed: () {
              Navigator.push( context, MaterialPageRoute(builder: (context) => CriarDuvida()) );
            },
          ),
        )
    );
  }
}
