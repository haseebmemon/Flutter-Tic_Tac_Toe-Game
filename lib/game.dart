// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'constants/colors.dart';
import 'dart:async';

class GameScreen extends StatefulWidget{
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  String resultDeclaration = '';
  bool oTurn = true;
  List<String> displayXO = ['','','','','','','','','',];
  List<int> matchedIndexes = [];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;
  bool winnerFound = false;
  Timer? timer;
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  int attempts = 0; 

  static var customFontWhite = GoogleFonts.coiny(
    textStyle: TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    )
  );

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (timer) { 
      setState(() {
        if (seconds > 0) {
          seconds--;
        }else{
          stopTimer();
        }
      });
    });
  }

  void stopTimer(){
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() => seconds = maxSeconds;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Maincolors.primaryColor,
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [Expanded(
                              flex: 1,
                              child:  Container(child: Row(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Player O', style: customFontWhite,),
                                    Text(oScore.toString(), style: customFontWhite,),
                                  ],
                                ),
                                SizedBox(width: 20,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Player X', style: customFontWhite,),
                                    Text(xScore.toString(), style: customFontWhite,),
                                  ],
                                  ),
                              ],),)),
                            Expanded(
                              flex: 3,
                              child: GridView.builder(
                                itemCount: 9,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,), itemBuilder: (BuildContext context, int index){
                                return GestureDetector(
                                  onTap: (){
                                    _tapped(index);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        width: 5,
                                        color: Maincolors.primaryColor,
                                      ),
                                      color: matchedIndexes.contains(index)? Maincolors.accentColor : Maincolors.secondaryColor,
                                    ),
                                    child: Center(child: Text(displayXO[index], style: GoogleFonts.coiny(textStyle: TextStyle(fontSize: 64, color: Maincolors.primaryColor)),),),
                                  ),
                                );
                              })),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      resultDeclaration, style: customFontWhite,),
                                      SizedBox(height: 10,),
                                      _buildTimer(),
                                  ],
                                ))),],) ,
      )
      
  );
  }
  void _tapped(int index){
    final isRunning = timer == null ? false : timer!.isActive;

    if (isRunning) {
      setState(() {
      if (oTurn && displayXO[index]==''){
        displayXO[index]= 'O';
        filledBoxes++;

      }else if(!oTurn && displayXO[index]== ''){
        displayXO[index]= 'X';
        filledBoxes++;
      }

      oTurn = !oTurn;
      _checkWinner();
    });
    }
    
  }

  void _checkWinner(){
    //to Check Combinations

    //Checking 1st Row
    if (displayXO[0] == displayXO[1] && displayXO[0] == displayXO[2] && displayXO[0] != '') {

      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} wins!';
        _updateScore(displayXO[0]);
        matchedIndexes.addAll([0,1,2]);
        stopTimer();
      });
      
    }
    //Checking 2nd Row
    if (displayXO[3] == displayXO[4] && displayXO[3] == displayXO[5] && displayXO[3] != '') {

      setState(() {
        resultDeclaration = 'Player ${displayXO[3]} wins!';
        _updateScore(displayXO[3]);
        matchedIndexes.addAll([3,4,5]);
        stopTimer();

      });
      
    }
    //Checking 3rd Row
    if (displayXO[6] == displayXO[7] && displayXO[6] == displayXO[8] && displayXO[6] != '') {

      setState(() {
        resultDeclaration = 'Player ${displayXO[6]} wins!';
        _updateScore(displayXO[6]);
        matchedIndexes.addAll([6,7,8]);
        stopTimer();
      });
      
    }
    //Checking 1st Column
    if (displayXO[0] == displayXO[3] && displayXO[0] == displayXO[6] && displayXO[0] != '') {

      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} wins!';
        _updateScore(displayXO[0]);
        matchedIndexes.addAll([0,3,6]);
        stopTimer();
      });
      
    }
    //Checking 2nd Column
    if (displayXO[1] == displayXO[4] && displayXO[1] == displayXO[7] && displayXO[1] != '') {

      setState(() {
        resultDeclaration = 'Player ${displayXO[1]} wins!';
        _updateScore(displayXO[1]);
        matchedIndexes.addAll([1,4,7]);
        stopTimer();
      });
      
    }
    //Checking 3rd Column
    if (displayXO[2] == displayXO[5] && displayXO[2] == displayXO[8] && displayXO[2] != '') {

      setState(() {
        resultDeclaration = 'Player ${displayXO[2]} wins!';
        _updateScore(displayXO[2]);
        matchedIndexes.addAll([2,5,8]);
        stopTimer();
      });
      
    }
    //Checking 1st Diagonal
    if (displayXO[0] == displayXO[4] && displayXO[0] == displayXO[8] && displayXO[0] != '') {

      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} wins!';
        _updateScore(displayXO[0]);
        matchedIndexes.addAll([0,4,8]);
        stopTimer();
      });
      
    }
    //Checking 2nd Diagonal
    if (displayXO[6] == displayXO[4] && displayXO[6] == displayXO[2] && displayXO[6] != '') {

      setState(() {
        resultDeclaration = 'Player ${displayXO[6]} wins!';
        _updateScore(displayXO[6]);
        matchedIndexes.addAll([6,4,2]);
        stopTimer();
      });
      
    }
    //Checking Draw
    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        resultDeclaration = 'Nobody wins!';
        stopTimer();
      });
      
    }


  }

  void _updateScore(String winner){
    if(winner == 'O'){
      oScore++;
    }else if(winner == 'X'){
      xScore++;
    }
    winnerFound = true;
  }

  void _clearBoard () {
    setState(() {
      for (int i = 0; i < 9; i++) {

        displayXO[i] = '';
        
      }
      resultDeclaration = '';
    });
    filledBoxes = 0;
    matchedIndexes = [];
    winnerFound = false;
  }

  Widget _buildTimer(){

    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning ? SizedBox(width: 100, height: 100, child:
     Stack(fit: StackFit.expand,
     children: [CircularProgressIndicator(
      value: 1 - seconds / maxSeconds,
      valueColor: AlwaysStoppedAnimation(Colors.white),
      strokeWidth: 8,
      backgroundColor: Maincolors.accentColor,
     ),
     Center(
      child: Text('$seconds', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 50,),),
     ),
     ],),) :
     ElevatedButton(onPressed:() {
      startTimer();
      _clearBoard();
      attempts++;
       } ,style: ElevatedButton.styleFrom(backgroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16,)
        ), child: Text(
          attempts == 0 ? 'Start!' :'Play Again!',
           style: TextStyle(color: Colors.black, fontSize: 20),))

                                        
     ;
    
  }
}

