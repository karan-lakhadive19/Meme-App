// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:meme/main.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';

class Meme extends StatefulWidget {
  const Meme({super.key});

  @override
  State<Meme> createState() => _MemeState();
}

String stringResponse = '';
Map mapResponse = {};
Map dataResponse = {};

bool isLoading = true;

class _MemeState extends State<Meme> {
  Future apicall() async {
    http.Response response;
    setState(() {
      isLoading = true;
    });
    response = await http.get(Uri.parse("https://meme-api.com/gimme"));

    if (response.statusCode == 200) {
      setState(() {
        stringResponse = response.body;
        mapResponse = json.decode(response.body);
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    apicall();
    super.initState();
  }

//   void shareUrl(String url) async {
//   if (await canLaunchUrlString(url)) {
//     await launchUrlString(url);
//   } else {
//     throw 'Could not launch';
//   }
// }

  void sharePress() {
    String message = mapResponse['url'];
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 192, 177),
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
          'Memes',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 35),
        ),
        toolbarHeight: 80,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .60,
            width: MediaQuery.of(context).size.width,
            child: isLoading || mapResponse['url'] == null
                ? Center(child: CircularProgressIndicator())
                : Image.network(mapResponse['url']),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: Container(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button press
                      // shareUrl('https://example.com');
                      sharePress();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Background color of button
                      elevation: 3, // Depth of the button
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Text(
                        'Share',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: Container(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      apicall();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Background color of button
                      elevation: 3, // Depth of the button
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Text(
                        'Next',
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
