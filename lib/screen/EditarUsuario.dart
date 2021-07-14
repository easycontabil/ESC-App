import 'dart:convert';
import 'dart:typed_data';

import 'package:easycontab/components/AppBar.dart';
import 'package:easycontab/components/BackgroundBaseWidget.dart';
import 'package:easycontab/components/Button.dart';
import 'package:easycontab/components/CustomTextField.dart';
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/contants/app_assets.dart';
import 'package:easycontab/models/Usuario.dart';
import 'package:easycontab/services/AuthService.dart';
import 'package:easycontab/utils/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'Duvidas.dart';


class EditarUsuario extends StatefulWidget {

  final Usuario usuario;

  EditarUsuario({ this.usuario });

  @override
  _EditarUsuarioState createState() => _EditarUsuarioState();
}

class _EditarUsuarioState extends State<EditarUsuario> {

  AuthService service = new AuthService( prefix: ApiUrls.prefix, host: ApiUrls.host, path: "grd");

  TextEditingController confirmarSenhaController;
  TextEditingController emailController;
  TextEditingController senhaController;
  TextEditingController nomeController;
  
  Preferences preferences = new Preferences();
  bool isLoading = true;
  Usuario usuario;

  final picker = ImagePicker();
  String img64;
  File image;

  void showError(String msg){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(msg, style: GoogleFonts.openSans( color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500,))
      )
    );
  }

  Future<void> submit() async {
    if( this.validateSenha() ){
      if( this.validateNome() ){
        if( this.validateEmail()){
          Map<String, dynamic> data = await this.service.update(
            this.widget.usuario.id,
            this.nomeController.text,
            this.emailController.text,
            this.senhaController.text,
            this.img64
          );
          if( data["status"] == 200 ){   
            this.service.path = "grd/auth";       
            data = await this.service.login( this.emailController.text, this.senhaController.text );
            String token = data["data"]["accessToken"]["token"];
            this.preferences.setToken(token);
            Navigator.push( context, MaterialPageRoute(builder: (context) => Duvidas()) );
          }else{
            this.showError("Não foi possível editar o usuário");
          }
        }
      }
    }
  }

  bool validateSenha(){
    String msg;
    if(this.senhaController.text == this.confirmarSenhaController.text){
      if(this.senhaController.text != null && this.senhaController.text != ' ' && this.senhaController.text != ''){
        return true;
      }else{
        msg = "A senha deve ser informada";
      }
    }else{
      msg = "As senhas devem ser iguais";
    }
    this.showError(msg);
    return false;
  }

  bool validateNome(){
    if( this.nomeController.text != null && this.nomeController.text != '' && this.nomeController.text != ' ' ){
      return true;
    }
    showError("Digite um nome");
    return false;
  }

  bool validateEmail(){
    RegExp regex = RegExp(r"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
    
    if( this.emailController.text != null && this.emailController.text != '' && this.emailController.text != ' ' ){
      return true;
    }
    this.showError("Digite um e-mail válido");
    return false;
  }

  Future chooseImage() async {
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    Uint8List fileBytes = await pickedFile.readAsBytes();
    setState(() {
      if (pickedFile != null){
        this.image = File(pickedFile.path);
        this.img64 = base64Encode(fileBytes);
      }
    }); 
  }

  void initialize(){
    print(this.widget.usuario.id);
    this.confirmarSenhaController = new TextEditingController(text: this.widget.usuario.senha);
    this.emailController = new TextEditingController(text: this.widget.usuario.email);
    this.senhaController = new TextEditingController(text: this.widget.usuario.senha);
    this.nomeController = new TextEditingController(text: this.widget.usuario.nome);  
  }

  @override
  Widget build(BuildContext context) {

    this.initialize();
    
    this.preferences.init().then((value){});

    var size = MediaQuery.of(context).size;

    return BackgroundBaseWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomAppBar(logged: true,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 30),
            child: Text("GABRIEL ANDRADE", style: GoogleFonts.openSans( fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700, height: 4),)
          ),
          Container(
            margin: EdgeInsets.only(bottom: 6, left: 6, right: 6),
            width: double.infinity,                     
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            child: Column(
              children: [
                SizedBox( height: 30 ),
                CustomTextField(labelText: "Nome", margin: EdgeInsets.only(top: 60, bottom: 10, left: 20, right: 20), textController: this.nomeController,),
                CustomTextField(labelText: "E-MAIL", margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20), textController: this.emailController,),
                CustomTextField(labelText: "SENHA", margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20), textController: this.senhaController, password: true,),
                CustomTextField(labelText: "CONFIRMAR SENHA", margin: EdgeInsets.only(top: 10, bottom: 30, left: 20, right: 20), textController: this.confirmarSenhaController, password: true,),
                Padding(
                  padding: EdgeInsets.only( left: 20, top: 5, right: 20, bottom: 5 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(onPressed: chooseImage, child: Text("IMAGEM")),
                      Container(
                        height: 80.0,
                        width: 80.0,                        
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: this.image == null ? Image.asset(Assets.avatar) : Image.file(image, height: 80, width: 80, fit: BoxFit.fill, )
                        ),
                      ),                     
                    ],
                  ),
                ),
                CustomButton(label: "EDITAR", action: submit),
                SizedBox( height: 80 ),                
              ],
            ),
          ),
        ],
      )
    );
  }
}

// Container(
//   width: size.width,
//   height: 400,
//   child: Center(child: CircularProgressIndicator(),)
// )