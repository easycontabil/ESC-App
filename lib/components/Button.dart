import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatefulWidget {

  final String label;
  AsyncCallback action;
  final Color color;

  CustomButton({ this.label, this.action, this.color = const Color.fromRGBO(64,140,229, 1)  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

  bool loading = false;
  ContentLoad content;

  Widget getContent(){
    this.content = new ContentLoad(
      defaultContent: Text(this.widget.label, style: GoogleFonts.openSans( fontWeight: FontWeight.w600, fontSize: 20  )),
      loadingContent: CircularProgressIndicator(),
    );
    return this.content;
  }

  void setLoadingState(bool status){
    setState(() {
      this.loading = !this.loading;     
    });
  }

  void clickAction() async{
    this.widget.action();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: ContentLoad(
        defaultContent: Text(this.widget.label, style: GoogleFonts.openSans( fontWeight: FontWeight.w600, fontSize: 20  )),
        loadingContent: CircularProgressIndicator(),
      ),
      onPressed: (){
        this.clickAction();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(this.widget.color),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric( horizontal: 20, vertical: 7 )),
      ),
    );
  }
}

class CustomSmallButton extends StatefulWidget {

  final String label;
  final dynamic action;
  final Color color;

  CustomSmallButton({ this.label, this.action, this.color = const Color.fromRGBO(64,140,229, 1)  });

  @override
  _CustomSmallButtonState createState() => _CustomSmallButtonState();
}

class _CustomSmallButtonState extends State<CustomSmallButton> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(this.widget.label, style: GoogleFonts.openSans( fontWeight: FontWeight.w700, fontSize: 16  ),),
      onPressed: this.widget.action, 
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(this.widget.color),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric( horizontal: 16, vertical: 5 )),

      ),
    );
  }
}


class ContentLoad extends StatefulWidget {

  final Widget defaultContent;
  final Widget loadingContent;

  ContentLoad({ @required this.defaultContent, @required this.loadingContent });

  @override
  _ContentLoadState createState() => _ContentLoadState();
}

class _ContentLoadState extends State<ContentLoad> {

  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading == true ? this.widget.loadingContent : this.widget.defaultContent;
  }
}