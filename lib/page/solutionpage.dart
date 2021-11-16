/**
 * Created by Malte Denecke
 */



import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:classroomquiz_usersedition/db/IncorrectCorrectAnswered_database.dart';
import 'package:classroomquiz_usersedition/model/IncorrectCorrectAnswered.dart';
import 'package:classroomquiz_usersedition/model/quotes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:classroomquiz_usersedition/widget/customwidgets.dart';

import '../main.dart';
import 'dart:math';

class SolutionPage extends StatefulWidget{
  String value = "Test";
  
  
  
  int gameCounterValue = 0;
  SolutionPage({required this.value,required this.gameCounterValue, Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SolutionPage(value: value,gameCounterValue:gameCounterValue);

}

class _SolutionPage extends State<SolutionPage>{



  _SolutionPage({required this.value,required this.gameCounterValue});
  final String value;
   final int gameCounterValue;
  List<Quotes> quotes = [];

   bool answerschecked = false ;
  int size = 0;
  late int gameSize = 0;

  List<IncorrectCorrectAnswered> incorrectCorrectAnsweredList = [];
  List<IncorrectCorrectAnswered> incorrectCorrectAnsweredListpuffer =[];
  List<IncorrectCorrectAnswered> incorrectCorrectAnsweredListpuffer2 =[];
  List<IncorrectCorrectAnswered> incorrectCorrectAnsweredListpuffer3 =[];

   getIncorrectCorrectAnswered() async {
   if(answerschecked == false)
   {
     incorrectCorrectAnsweredList = await IncorrectCorrectAnsweredDatabase.instance.readAllIncorrectCorrectAnswered();
     answerschecked = true;
    // incorrectCorrectAnsweredListpuffer = incorrectCorrectAnsweredList.reversed.toList();
     incorrectCorrectAnsweredListpuffer = incorrectCorrectAnsweredList.reversed.toList();
     IncorrectCorrectAnswered InCo1;
      for(int i = 0; i < gameCounterValue; i++){
        InCo1 = incorrectCorrectAnsweredListpuffer[i];
        incorrectCorrectAnsweredListpuffer3.add(InCo1);
      }

      print(incorrectCorrectAnsweredListpuffer3);

       print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");

       print(size);
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
     print(incorrectCorrectAnsweredListpuffer3.length);
     print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
     IncorrectCorrectAnswered InCo2;
     for(int i = 0; i < incorrectCorrectAnsweredListpuffer3.length; i++){
       if(incorrectCorrectAnsweredListpuffer3[i].iscorrect == "false"){
         InCo2 = incorrectCorrectAnsweredListpuffer3[i];
         print("false wurde erkannt");
         incorrectCorrectAnsweredListpuffer2.add(InCo2);
         print(incorrectCorrectAnsweredListpuffer2.length);
       }

     }
     print(incorrectCorrectAnsweredListpuffer2);

     return incorrectCorrectAnsweredListpuffer2;}
   else return null;

  }

  @override
  initState()   {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF16804E),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text("Ergebnis",style: TextStyle(color: '0xff16804e'.toColor())),


        centerTitle: true,
      ),
        backgroundColor: Color(0xFF16804E),
      body: Center(

          child:  Column(
            children: [
              Container(
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText("$value Fragen richtig beantwortet!",textAlign: TextAlign.center,
                        textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),speed: const Duration(milliseconds: 100)),
                  ],

                ),),
              Container(
                margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.02, 0, 0),

                child: Text("",textAlign: TextAlign.center,style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal)),
                decoration: BoxDecoration(
                     borderRadius: BorderRadius.all(Radius.circular(20))),
         
              ),

              Container(
                margin: EdgeInsets.fromLTRB(0,  MediaQuery.of(context).size.height * 0.01, 0, 0),
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(image: DecorationImage(

                    image:AssetImage("assets/background.png"),
                    fit: BoxFit.none),  borderRadius: BorderRadius.all(Radius.circular(20))),



                child: FutureBuilder(
                   future:getIncorrectCorrectAnswered(),
                  builder:(context, AsyncSnapshot snapshot){
                  if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                  } else {
                    child:
                   return Scrollbar(isAlwaysShown: true,
                     child: ListView.builder(
                          itemCount: incorrectCorrectAnsweredListpuffer2.length,
                        //  controller: _scrollController,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(

                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              margin: EdgeInsets.fromLTRB( MediaQuery.of(context).size.width * 0.01, 0,  MediaQuery.of(context).size.width * 0.01, 0),
                              child: answerCard(
                                  incorrectCorrectAnsweredListpuffer2[index]
                                      .questiontext, Colors.white70, context),
                            );
                          }),
                   );

                  } }),
              ),
              Container(
                   margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.01,MediaQuery.of(context).size.height * 0.015,
                       MediaQuery.of(context).size.width * 0.01,0),
                  width: MediaQuery
                  .of(context)
                  .size
                  .width,

                  height: MediaQuery.of(context).size.height * 0.25,
                  child: solutionCard(getRandomQuote(), context),decoration: BoxDecoration(image: DecorationImage(

                  image:AssetImage("assets/paper_texture.png"),
                  fit: BoxFit.none),  borderRadius: BorderRadius.all(Radius.circular(20))),
                ),

              Container(margin: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.055, 0, 0),

                child: SizedBox(
                  child: GestureDetector(
                    onTap:(){
                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(builder: (BuildContext context) => StartPage()),
                          ModalRoute.withName('/')
                      );
                    },
                   child: FittedBox(
                    fit: BoxFit.fill,
                    child: submitButton("Quiz Verlassen",context)),
                  ),
                ),
              ),
          ]),


            ),
      );


  }

  fillQuoteList(){
    Quotes quote1 = new Quotes(quote: "Niemand kriegt beim ersten Mal alles richtig hin. Was uns ausmacht, ist, wie wir aus unseren Fehlern lernen.", author: "Richard Branson");
    Quotes quote2 = new Quotes(quote: "Lernen ist wie Rudern gegen den Strom.Sobald man aufhört, treibt man zurück.", author: "Benjamin Britten");
    Quotes quote3 = new Quotes(quote: "Auch eine schwere Tür hat nur einen kleinen Schlüssel nötig.", author: "Charles Dickens");
    Quotes quote4 = new Quotes(quote: "Der größte Feind des Fortschritts ist nicht der Irrtum, sondern die Trägheit.", author: "Henry Thomas Buckle");
    Quotes quote5 = new Quotes(quote: "Es ist keine Schande nichts zu wissen, wohl aber, nichts lernen zu wollen.", author: "Philip Rosenthal");
    Quotes quote6 = new Quotes(quote: "Das beste Training liegt immer noch im selbständigen Machen.", author: "Cyril Northcote Parkinson");
    Quotes quote7 = new Quotes(quote: "Ohne Leiden bildet sich kein Charakter.", author: "Ernst Freiherr von Feuchtersleben");
    Quotes quote8 = new Quotes(quote: "Ein ungeübtes Gehirn ist schädlicher für die Gesundheit als ein ungeübter Körper.", author: "George Bernard Shaw");
    Quotes quote9 = new Quotes(quote: "Ein Buch ist ein Spiegel, wenn ein Affe hineinsieht, so kann kein Apostel herausgucken.", author: "Georg Christoph Lichtenbergn");
    Quotes quote10 = new Quotes(quote: "Die Bildung kommt nicht vom Lesen, sondern vom Nachdenken über das Gelesene.", author: "Carl Hilty");

    quotes.add(quote1);
    quotes.add(quote2);
    quotes.add(quote3);
    quotes.add(quote4);
    quotes.add(quote5);
    quotes.add(quote6);
    quotes.add(quote7);
    quotes.add(quote8);
    quotes.add(quote9);
    quotes.add(quote10);

  }
  
  String getRandomQuote(){
    fillQuoteList();
    if(quotes.length != 0) {
      int max = quotes.length;

      int randomNumber = Random().nextInt(max) + 1;
      print(randomNumber);
      String quoteText = quotes[randomNumber].quote;
      String authorName = quotes[randomNumber].author;

      String quoteAndAuthor = quoteText + authorName;


      return quoteAndAuthor;
    }else
      return "42";
  }


}