import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Meme extends StatefulWidget {
  const Meme({super.key});

  @override
  State<Meme> createState() => _MemeState();
}

String stringResponse='';
Map mapResponse={};
Map dataResponse={};


class _MemeState extends State<Meme> {

  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://meme-api.com/gimme"));
    if(response.statusCode==200) {
      setState(() {
        stringResponse = response.body;
        mapResponse = json.decode(response.body);
        
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    apicall();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 192, 177),
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          'Explore Memes',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*.75,
              width: MediaQuery.of(context).size.width,
              child: mapResponse['url']==null? Center(child: CircularProgressIndicator()):Image.network(mapResponse['url']),
            )
          ],
        ),
      )
    );
  }
}
