import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Lyrics extends StatefulWidget {
  const Lyrics({Key? key}) : super(key: key);

  @override
  State<Lyrics> createState() => _LyricsState();
}

class _LyricsState extends State<Lyrics> {

  var name = "Enter Song Name";
  bool open = false;
  var l;
  double openheight = 0.0;
  double openwidth = 0.0;
  var artist;
  var lyrics;

  lyric()async{
    open = false;
    Response reqlyr = await get(
      Uri.parse(
        "https://powerlyrics.p.rapidapi.com/getlyricsfromtitle?title=${name}",
        ),
        headers: {
          'X-RapidAPI-Key': 'ed8aaedc7cmshf3c6a200313ac82p123172jsn50e430bde585',
          'X-RapidAPI-Host': 'powerlyrics.p.rapidapi.com'
        }
    );
    l= jsonDecode(reqlyr.body);
    setState(() {
      
        artist = l['resolvedartist'];
        lyrics = l['lyrics'];
        name = l['resolvedtitle'];
        open = true;
      if(l['lyrics'] == null){
        setState(() {
          openheight = 0.2;
          openwidth = 0.4;
        });
      }
      else{
        openheight = 0.5;
        openwidth = 0.75;
      }
      
    });
  }

  dialog(){
    showDialog(context: context, 
    builder: (BuildContext Context){
      return AlertDialog(
    title: const Text('Song Name'),
    content: TextField(
      autofocus: true,
      onSubmitted: (value) {
        setState(() {
          name = value;
          lyric();
          Navigator.pop(context);
        });
      },
    ),
    
  );
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), 
                    color: Color.fromARGB(135, 70, 70, 72),
                    ),
                    child: Image.asset('images/lyrics.png', scale: 4.0, fit: BoxFit.cover,),
                ),
              ),
              const SizedBox(height: 50,),
              Center(
                child: InputChip(
                  showCheckmark: true,
                  avatar: CircleAvatar(child: Icon(Icons.lyrics_rounded, size: 15,color: Colors.white,),),
                  label: Text("${name}"),
                  elevation: 20,
                  backgroundColor: Color.fromARGB(119, 121, 120, 120),
                  onPressed: (){
                    dialog();
                  },
                ),
                ),
                const SizedBox(height: 50,),
                Center(
                  child: AnimatedContainer(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    duration: Duration(seconds: 3),
                    height: open? MediaQuery.of(context).size.height * openheight : MediaQuery.of(context).size.height * 0.0,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color.fromARGB(156, 70, 70, 72),),
                    width: open? MediaQuery.of(context).size.width * openwidth : MediaQuery.of(context).size.width * 0.0,
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: lyrics != '' ? Column(
                        children: [
                          SizedBox(height: 20),
                          SelectableText("Artist: ${artist}", textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic),),
                          SizedBox(height: 10),
                          Divider(),
                          SizedBox(height: 10,),
                          SelectableText("${lyrics}", textAlign: TextAlign.center, style: TextStyle(fontStyle: FontStyle.italic),),
                          SizedBox(height: 20),
                        ],
                      ):
                      Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                          Center(child: Text("Lyrics Not Available"),),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}