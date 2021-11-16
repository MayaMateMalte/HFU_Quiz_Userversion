/**
 * Created by Malte Denecke
 */


          import 'dart:async';


          import 'package:classroomquiz_usersedition/db/IncorrectCorrectAnswered_database.dart';
import 'package:classroomquiz_usersedition/db/questions_database.dart';
import 'package:classroomquiz_usersedition/model/IncorrectCorrectAnswered.dart';
          import 'package:classroomquiz_usersedition/model/questions.dart';
import 'package:classroomquiz_usersedition/page/settingspage.dart';
import 'package:classroomquiz_usersedition/page/solutionpage.dart';
import 'package:flutter/cupertino.dart';
          import 'package:flutter/widgets.dart';
          import 'package:flutter/material.dart';
          import 'package:classroomquiz_usersedition/widget/customwidgets.dart';
          import 'package:classroomquiz_usersedition/main.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

          class QuizPage extends StatefulWidget {
            String value = "Test";
            QuizPage({required this.value, Key? key}) : super(key: key);


            @override
            _QuizScreen createState() => _QuizScreen(value: value);
            }



          class _QuizScreen extends State<QuizPage> {

            _QuizScreen({required this.value});

            final String value;
            late List <Questions> questionsCollection;
            List <String> correctAnswered = [];
            List <String> incorrectAnswered = [];
            List <bool> correctIncorrect = [];
            List <Questions> questionsCollection2 = [];
            List<IncorrectCorrectAnswered> incorrectCorrectAnsweredList = [];
            List <String> answer1list = [];
            List <String> answer2list = [];
            List <String> answer3list = [];
            List <String> answer4list = [];
            int gamecounter = 0;
            Color colors1 = Colors.white70;
            Color colors2 = Colors.white70;
            Color colors3 = Colors.white70;
            Color colors4 = Colors.white70;
            bool questionsloaded = false;
            bool colorchanged = false;
            bool answerchecked = false;
            int incrementcounter = 0;
            bool gamecounterchecked = false;
            @override
            initState()   {

              super.initState();
            }

            String getSolution(){
              int solutionsummary = 0;

              for(IncorrectCorrectAnswered incorrectCorrectAnswered1  in incorrectCorrectAnsweredList){
                if(incorrectCorrectAnswered1.iscorrect == "true"){
                  solutionsummary++;
                }


              }
              int puffer = incrementcounter+1;


              String responds = "$solutionsummary/$puffer";

              return responds;
            }


             Future<int> checkGameCounter() async {

               List<IncorrectCorrectAnswered> incorrectCorrectAnsweredListPuffer  = await IncorrectCorrectAnsweredDatabase.instance.readAllIncorrectCorrectAnswered();
               int puffer;
               puffer = incorrectCorrectAnsweredListPuffer.length;
               if(incorrectCorrectAnsweredListPuffer.isNotEmpty) {
                 gamecounter =
                 incorrectCorrectAnsweredListPuffer.last.gamecounter!;
                 print("GameCounter:");
                 print(gamecounter);
                 if(gamecounterchecked == false){

                   gamecounterchecked = true;
                   gamecounter++;
                   print("Neuer Gamecounter:");
                   print(gamecounter);
                 }
               }else{

               if(gamecounterchecked == false){

                gamecounterchecked = true;
                gamecounter++;
                print("Neuer Gamecounter:");
                print(gamecounter);
               }}
                return gamecounter;
            }

            void checkAnswer(String solutionLetter) async{
              if(colorchanged == false){
              if(questionsCollection2[incrementcounter].solution == solutionLetter){
                print("Frage wurde richtig beantwortet!");
                correctAnswered.add(questionsCollection2[incrementcounter].questiontext);
                correctIncorrect.add(true);
                await checkGameCounter();

                IncorrectCorrectAnswered incorrectCorrectAnswered1 = new IncorrectCorrectAnswered(questiontext:questionsCollection2[incrementcounter].questiontext,
                    iscorrect: 'true',
                    gamename: questionsCollection2[incrementcounter].gamename,
                    gamecounter:gamecounter);
                print("Wurde hinzugefügt!");
                print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                print(incorrectCorrectAnswered1);
                incorrectCorrectAnsweredList.add(incorrectCorrectAnswered1);
                print(incorrectCorrectAnswered1);

                await IncorrectCorrectAnsweredDatabase.instance.create(incorrectCorrectAnswered1);

               }else
                 {print("Frage wurde nicht richtig beantwortet!");
                 incorrectAnswered.add(questionsCollection2[incrementcounter].questiontext);
                 correctIncorrect.add(false);
                 await checkGameCounter();
                 IncorrectCorrectAnswered incorrectCorrectAnswered1 = new IncorrectCorrectAnswered(questiontext:questionsCollection2[incrementcounter].questiontext,
                  iscorrect: 'false',gamename: questionsCollection2[incrementcounter].gamename,
                  gamecounter: gamecounter);
              incorrectCorrectAnsweredList.add(incorrectCorrectAnswered1);
              print("Wurde hinzugefügt!");
              print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
              print(incorrectCorrectAnswered1);
              print(incorrectCorrectAnswered1);
              await IncorrectCorrectAnsweredDatabase.instance.create(incorrectCorrectAnswered1);}

              }

              print(correctIncorrect);


            }
            void changeColors(int colorNumber){
             if(colorchanged == false){

              switch(colorNumber)
              {
                case 1:
                  colors1 = Colors.red;break;
                case 2:
                  colors2 = Colors.red;break;
                case 3:
                  colors3 = Colors.red;break;
                case 4:
                  colors4 = Colors.red;break;

              }

              switch(questionsCollection2[incrementcounter].solution){
                case "A":
                  colors1 = Colors.green; break;
                case "B":
                  colors2 = Colors.green;break;
                case "C":
                  colors3 = Colors.green;break;
                case "D":
                  colors4 = Colors.green;break;}}
             else{
               print("Color already changed");
             }
              colorchanged = true;

            }


            Future getQuestions() async {
              if(questionsloaded == true){return true;}
              this.questionsCollection =
              await QuestionsDatabase.instance.readAllQuestions();
              print("********************************************");
              print("All Questions");

              print(questionsCollection);
              print(value);
              if (questionsCollection.isNotEmpty) {
                print("Questionscollection Länge");
                for (Questions item in questionsCollection) {
                  if (item.gamename == value) {
                    questionsCollection2.add(item);
                    print(questionsCollection2);
                    print("////////////");
                    answer1list.add(item.answer1);
                    answer2list.add(item.answer2);
                    answer3list.add(item.answer3);
                    answer4list.add(item.answer4);

                    print(answer1list);
                    //  return answer1list;
                  }
                }
                print("////////////");
                print(answer1list);
                print("////////////");
                print(questionsCollection2);
                questionsloaded = true;
                return questionsCollection2;

              }
            }



            incrementpush(){
              if(incrementcounter<questionsCollection2.length){
                incrementcounter++;
              }


            }

            @override
            Widget build(BuildContext context) {
              return Scaffold(
                  appBar: AppBar(backgroundColor: Colors.transparent,
                    elevation: 0,

                    title: Text(value, style: TextStyle(color: '0xff16804e'.toColor())),


                    centerTitle: true,
                  ),
                  backgroundColor: Color(0xFF16804E),

                  body: Center(

                      child: Container(decoration: BoxDecoration(image: DecorationImage(
                          image:AssetImage("assets/background.png"),
                          fit: BoxFit.fill)),
                        child: Container(
                          child: Container(

              child: FutureBuilder(
                  future: getQuestions(),
              builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
              } else { return   Container(
                child: Column(

                    children:[
                          GestureDetector(
                              onTap: (){print(questionsCollection2[incrementcounter].questiontext);
                              print("Die Frage");},
                              child: Container( margin: EdgeInsets.fromLTRB(0, 40, 0, 50),
                                  child:FittedBox(   fit: BoxFit.fill, child: Text(questionsCollection2[incrementcounter].questiontext,
                                    style: TextStyle(color: Colors.black,decorationThickness: 5,fontSize: 20),)))

                          ),
                          GestureDetector(
                              onTap: (){print(questionsCollection2[incrementcounter].answer1);
                              print("Button A ausgelöst");
                              //colors1 = Colors.red;

                              checkAnswer("A");


                              setState(() {
                                changeColors(1);

                              });

                              },
                              child: Container(
                                  child:answerCard(questionsCollection2[incrementcounter].answer1,colors1, context))

                          ),
                          GestureDetector(
                              onTap: (){print(questionsCollection2[incrementcounter].answer2);
                              print("Button B ausgelöst");


                              checkAnswer("B");



                              setState(() {
                                changeColors(2);


                                //  sleep(Duration(seconds:3));

                              //  incrementpush();
                              });
                              },
                              child: Container( child:answerCard(questionsCollection2[incrementcounter].answer2,colors2, context))),
                          GestureDetector(
                              onTap: (){print(questionsCollection2[incrementcounter].answer3);
                              print("Button C ausgelöst");
                             // colors3 = Colors.red;

                              checkAnswer("C");

                              setState(() {
                                changeColors(3);

                               // incrementpush();
                              });
                              },
                              child: Container( child:answerCard(questionsCollection2[incrementcounter].answer3,colors3, context))),
                          GestureDetector(
                              onTap: (){print(questionsCollection2[incrementcounter].answer4);
                              print("Button D ausgelöst");
                              checkAnswer("D");
                              print("ÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖÖ");
                              print(questionsCollection2.length);
                              //   incrementpush();
                              setState(() {
                                changeColors(4);


                              });
                              },
                              child: Container( child:answerCard(questionsCollection2[incrementcounter].answer4,colors4, context))),
                      GestureDetector(
                          onTap: (){print(questionsCollection2[incrementcounter].answer4);

                         // incrementpush();
                          setState(() {
                            //changeColors(4);
                            print("NIDaoNOINDAWOINDOIAN");

                          });
                          },
                          child: Container(  margin:  EdgeInsets.fromLTRB(0, 120, 0, 10),
                              child:GestureDetector(
                                onTap: (){
                                  print("Test: Nächste Frage");
                                setState(() {
                                  colorchanged = false;
                                  print(incorrectCorrectAnsweredList);
                                  if(incrementcounter+1 == questionsCollection2.length){
                                    String puffer = getSolution();

                                    Navigator.push(context,
                                        CupertinoPageRoute(
                                            builder: (context) => SolutionPage(value: puffer,gameCounterValue: incrementcounter+1)));
                                  }else{
                                  incrementpush();}
                                   colors1 = Colors.white70;
                                   colors2 = Colors.white70;
                                   colors3 = Colors.white70;
                                   colors4 = Colors.white70;
                                });},
                                child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: submitButton("Nächste Frage",context)),
                              )

                          )
                      ),
                      GestureDetector(
                        child: Container(child: StepProgressIndicator(
                          totalSteps: questionsCollection2.length,
                          currentStep: incrementcounter+1,
                          selectedColor: Colors.white,
                          unselectedColor: Colors.grey,
                        ),

                        ),
                      ),

                    ]),

              );}}),

              ),
                        ),
                      ),
              ),
                 );

              }

            }