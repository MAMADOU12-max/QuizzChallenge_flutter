import 'package:flutter/material.dart';
import 'package:quizz_challenge/questions.dart';

class Quizz extends StatefulWidget {
  const Quizz({Key key}) : super(key: key);

  @override
  _QuizzState createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {

  List<Question> mesQuestions = [
      new Question('Le desert Atacama est-elle une région aride ?', 'L\'Atacama est connu pour être une des régions les plus arides sur Terre', true, 'assets/desert.jpeg') ,
      new Question('Les drones ne peuvent pas retourner à leur base et ne sont pas réutilisables.', 'Les drones peuvent le plus souvent retourner à leur base et sont réutilisables!', false, 'assets/drone.jpeg') ,
      new Question('Les rhinocéros sont des périssodactyles', 'Les rhinocéros sont des périssodactyles', true, 'assets/rhynoceros.jpeg') ,
  ];


  // function text
  Text textWithStyle(String data, double scale) {
       return new Text(
            data,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: scale,
                fontWeight: FontWeight.bold
            ),
       );
  }

  int index = 0;
  int score = 0;
  Question currentQuestion ;

  @override
  void initState() {
     super.initState();
     currentQuestion = mesQuestions[index];
  }

  submitted(bool answer) {
       // print(answer);
       if(currentQuestion.affirmation == answer) {
           // print('tu as trouvé');
           setState(() {
               score++;
           });
           popupAnswer('Bravo, c\'est correct', 'assets/bravo.webp', Colors.green, false, '');
            // nextQuestion();
       } else {
           popupAnswer('Oops, c\'est faux' , 'assets/bad.webp', Colors.red, true, currentQuestion.answer);
           // Navigator.pop(context);
       }
  }

  void nextQuestion() {
    if (index < mesQuestions.length - 1) {
          index++;
          // print('index ${index}');
          setState(() {
             currentQuestion = mesQuestions[index];
          });
      } else {
           if (score <= mesQuestions.length / 2 ) {
             endQuizz('Votre score est de ${score}/${mesQuestions.length}, Vous avez échoué', 'Du courage, réessayez!','assets/echec.webp' );
           } else {
             endQuizz('Votre score est de ${score}/${mesQuestions.length}, Vous avez reussi', 'Félicitations','assets/congra.webp' );
           }
      }
  }

  // ---------------------------------- Popup True and False answer ------------------------------------ //

  Future<Null> popupAnswer(String appreciation, String path, Color textColor, bool correctAnswer, String reponse ) {
       return showDialog(
           context: context,
            barrierDismissible: false,
            builder: (BuildContext contex)  {
               return SimpleDialog(
                 contentPadding: EdgeInsets.all(20.0),
                  title: new Text(
                      appreciation,
                      style: TextStyle(
                         color: textColor,
                      ),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.2,
                  ) ,
                  elevation: 1.2,
                  children: [
                      Card(
                         child: Image.asset(
                             path,
                             width: MediaQuery.of(context).size.width / 1.5,
                             height: MediaQuery.of(context).size.height / 3.5,
                             fit: BoxFit.cover,
                         ),
                         margin: EdgeInsets.only(bottom: 40.0),
                      ),
                      textWithStyle(correctAnswer ? reponse : '', 17.0),
                      ElevatedButton(
                          onPressed:  () {
                            Navigator.pop(context);
                            nextQuestion();
                          },
                          child: Text(
                              'Au suivant',
                              style: TextStyle(
                                 color: Colors.white
                              ),
                              textAlign: TextAlign.center,
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                          ),
                      ),

                  ],
               );
           }
       );
  }

  // -------------------------------------- Popup True answer ------------------------------------------ //



  // -------------------------------------- Alert End Quizz ------------------------------------------ //

   Future<Null> endQuizz(String bilan, String appreciation, String photoFinal) {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext buildContext) {
              return AlertDialog(
                  title: textWithStyle('Game Over', 20),
                  content: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Center(
                         child: Column(
                             children: [
                                 textWithStyle(bilan, 15),
                                 textWithStyle(appreciation, 17.0),
                                  Card(
                                      child: Image.asset(
                                          photoFinal,
                                           height: MediaQuery.of(context).size.height / 3,
                                           width: MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                      ),
                                  ),
                                ElevatedButton(
                                    onPressed: (() {
                                        Navigator.pop(buildContext);   // close windows alert that we create
                                        Navigator.pop(context);        // close build scalfold that navigate you directly in tthe mean page
                                    }),
                                    child: Text('OK'),
                                ),
                             ],
                         ),
                      ),
                  ),

              );
          }
      );
   }

  // -------------------------------------- Alert End Quizz ------------------------------------------ //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Text("Quizz"),
         centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
         child: Center(
             child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  textWithStyle('Question numéro ${index + 1}', 23.0),
                  textWithStyle('Score ${score}/${mesQuestions.length}', 15.0),
                  Card(
                      child: Image.asset(
                         // 'assets/drone.jpeg',
                          currentQuestion.photo,
                          height: MediaQuery.of(context).size.height / 2.6,
                          width: MediaQuery.of(context).size.width / 1.3,
                          fit: BoxFit.cover,
                      ),
                      elevation: 12.0,
                  ),
                  textWithStyle(currentQuestion.question, 18.0),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       children: [
                         ElevatedButton(
                             onPressed: () {
                                submitted(true);
                             },
                             child: Text(
                                 'Vrai',
                                 style: TextStyle(
                                     color: Colors.white,
                                     fontSize: 19.0
                                 ),
                             ),
                             style: ButtonStyle(
                                elevation: MaterialStateProperty.all(12.0),
                                backgroundColor: MaterialStateProperty.all(Colors.blue)
                             ),
                         ),
                         ElevatedButton(
                             onPressed: () {
                               submitted(false);
                             },
                             child: Text(
                                 'Faux',
                                  style: TextStyle(
                                     color: Colors.white,
                                     fontSize: 19.0
                                  ),
                             ),
                             style: ButtonStyle(
                                 elevation: MaterialStateProperty.all(12.0),
                                 backgroundColor: MaterialStateProperty.all(Colors.blue)
                             ),
                         ),
                       ],
                     ),
                  )
                ],
             ),
         ),
      ),
    );
  }
}
