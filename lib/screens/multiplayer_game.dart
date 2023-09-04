import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac/screens/settings.dart';
import 'package:tic_tac/utils/theme_colors.dart';

class MultiPlayer extends StatefulWidget {
  const MultiPlayer({Key? key}) : super(key: key);

  @override
  State<MultiPlayer> createState() => _MultiPlayerState();
}

class _MultiPlayerState extends State<MultiPlayer> {
  String lastValue = "X";

  Game game = Game();
  late FToast fToast;
  bool gameOver = false;
  int turn = 0;
  static String result = "";
  List<int> scoreBoard = [0,0,0,0,0,0,0,0];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    game.board = Game.initGameBoard();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double boardWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Tic Tac Toe",style: TextStyle(color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.black,),),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const Settings()));
          }, icon: const Icon(Icons.settings))
          // ToggleButton()
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "It's $lastValue's Turn",
            style: const TextStyle(
                fontSize: 40
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: boardWidth,
            height: boardWidth,
            child: GridView.count(
              crossAxisCount: Game.boardLength ~/ 3,
              // ~/ allows to divide in int and return result in int
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: List.generate(Game.boardLength, (index) {
                return InkWell(
                  onTap: gameOver
                      ? null
                      : () {
                    setState(() {
                      if (game.board![index] == "") {
                        game.board![index] = lastValue;
                        turn++;
                        gameOver = game.winnerCheck(lastValue, index, scoreBoard, 3);
                        if(gameOver){
                          result = "$lastValue is the Winner";
                          _showToast();
                        }
                        else if(!gameOver && turn == 9){
                          result = "It's a Draw";
                          gameOver = true;
                        }
                        if (lastValue == "X")
                        {lastValue = "O";}
                        else
                        { lastValue = "X";}
                      }
                    });
                  },
                  child: Container(
                    width: Game.blocSize,
                    height: Game.blocSize,
                    decoration: BoxDecoration(
                      // color: MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.black : Colors.white54,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color:themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black)
                    ),
                    child: Center(
                      child: Text(
                        game.board![index],
                        style: TextStyle(
                            color: game.board![index] == "X"
                                ? Colors.blue
                                : Colors.pink,
                            fontSize: 64),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          // Text(result,style: TextStyle(
          //   fontSize: 22,
          // ),),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                game.board = Game.initGameBoard();
                lastValue = "X";
                scoreBoard = [0,0,0,0,0,0,0,0];
                gameOver = false;
                turn = 0;
                result = "";
              });
            },
            icon: const Icon(
              Icons.replay,
            ),
            label: const Text("Repeat the Game"),
          )
        ],
      ),
    );
  }
  _showToast() {
    Widget toast = Container(
      height: 120,
      width: 270,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 5,
                blurRadius: 5
            ),
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 15.0,
              ),
              Text(result,style: TextStyle(
                  fontSize: 25,
                  color: Colors.black
              ),),
            ],
          ),
          Container(
            width: 200,
            child: TextButton(onPressed: (){
              // Navigator.pop(context);
              fToast.removeCustomToast();
            }, child: Text("Ok"),
            ),
          )
        ],
      ),
    );


    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(seconds: 30),
    );

    // Custom Toast Position
    // fToast.showToast(
    //     child: toast,
    //     toastDuration: const Duration(seconds: 2),
    //     positionedToastBuilder: (context, child) {
    //       return Positioned(
    //         top: 16.0,
    //         left: 16.0,
    //         child: child,
    //       );
    //     }
    //     );
  }

}


