
import 'package:easycontab/components/CustomDrawer.dart';
import 'package:easycontab/components/DuvidaComponent.dart';
import 'package:easycontab/components/FeedAppBar.dart';
import 'package:easycontab/components/SearchTextField.dart';
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/models/Duvida.dart';
import 'package:easycontab/screen/CriarDuvida.dart';
import 'package:easycontab/screen/Duvida.dart';
import 'package:easycontab/services/DuvidaService.dart';
import 'package:easycontab/utils/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Duvidas extends StatelessWidget {

  DuvidaService service = new DuvidaService( prefix: ApiUrls.prefix, host: ApiUrls.hostqst , path: "qst/doubts");
  Preferences preferences = new Preferences();

  void getDuvidas() async {
    
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    // print(prefs.get("token"));

    //print(this.preferences.getToken());
    dynamic resp = await this.service.getDuvidas();
    print(resp);
  }

  @override
  Widget build(BuildContext context) {

    //this.preferences.init();

    Size size = MediaQuery.of(context).size;

    //List<Duvida> duvidas;
    //Preferences preferences = new Preferences();

    //DuvidaService service = new DuvidaService( prefix: ApiUrls.prefix, host: ApiUrls.hostQst , path: "qst/doubts");
    
    getDuvidas();


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
                children: [               
                  GestureDetector(
                    child: DuvidaComponent( 
                      titulo: "PROBLEMAS COM SPED", 
                      conteudo: "Nullam ornare sit amet quam ac lacinia. Donec egestas ligula id felis luctus, in accumsan tellus tincidunt. Cras mi est, sagittis sed libero ut, congue vehicula enim",
                    ),
                    onTap: (){
                      Navigator.push( context, MaterialPageRoute(builder: (context) => VerDuvida()) );
                    },
                  ),
                  DuvidaComponent( 
                      titulo: "PROBLEMAS ", 
                      conteudo: "Nullam ornare sit amet quam ac lacinia. Donec egestas ligula id felis luctus, in accumsan tellus tincidunt. Cras mi est, sagittis sed libero ut, congue vehicula enim",
                    ),
                  DuvidaComponent( 
                      titulo: "TESTE", 
                      conteudo: "Nullam ornare sit amet quam ac lacinia. Donec egestas ligula id felis luctus, in accumsan tellus tincidunt. Cras mi est, sagittis sed libero ut, congue vehicula enim",
                    ),
                ]
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        onPressed: (){
          Navigator.push( context, MaterialPageRoute(builder: (context) => CriarDuvida()) );
        },
      )
    );
  }
}
