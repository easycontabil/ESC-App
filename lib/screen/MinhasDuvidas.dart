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

  MinhasDuvidas({ @required this.usuario });

  @override
  _MinhasDuvidasState createState() => _MinhasDuvidasState(this.usuario);
}

class _MinhasDuvidasState extends State<MinhasDuvidas> {
  DuvidaService service = new DuvidaService( prefix: ApiUrls.prefix, host: ApiUrls.hostqst , path: "qst/doubts");

  List<Duvida> duvidas = [];

  getDuvidas(Usuario usuario) {
    this.service.queryPath = "&_user=[]*userId=${usuario.id}";
    print(this.service.queryPath);

    this.service.getDuvidas().then((response) => {
      setState(() {
        duvidas = response;
      })
    });

  }

  _MinhasDuvidasState(Usuario usuario) {
    getDuvidas(usuario);
  }

  List<DuvidaComponent> listaDuvidas() {
    List<DuvidaComponent> duvidaComponents = [];

    for (var duvida in duvidas) {
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
                  SearchField(labelText: "BUSCAR", margin: EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40)),
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
        floatingActionButton: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push( context, MaterialPageRoute(builder: (context) => CriarDuvida()) );
          },
        )
    );
  }
}
