import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class MyThemes{
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    textButtonTheme: TextButtonThemeData(style: ButtonStyle()),
  );
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
  );
}
class Player{
  static const x = "x";
  static const o = "o";
  static const empty = "";
}

class Game{
  static final boardLength = 9;
  static final double blocSize = 100;

  List<String>? board;
  static List<String>? initGameBoard() => List.generate(boardLength, (index) => Player.empty);

  bool winnerCheck(String player, int index, List<int> scoreboard,int gridSize){
    int row = index ~/ 3;
    int col = index % 3;
    int score = player == "X" ? 1 :-1;

    scoreboard[row] += score;
    scoreboard[gridSize + col] += score;
    
    if(row == col) scoreboard[2*gridSize] += score;
    
    if(gridSize -1 - col == row) scoreboard[2* gridSize +1] += score;
    if(scoreboard.contains(3)|| scoreboard.contains(-3)){
      return true;
    }
    return false;
  }
}

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeMode = ThemeMode.light;

  bool get isdarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn){
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class ToggleButton extends StatelessWidget {
  const ToggleButton({Key? key}) : super(key: key);
  Future<void> darkModeState(bool value) async{
  }
  @override
  Widget build(BuildContext context) {

    // final settings = collection.openBox<Map>('settings');

    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(value: themeProvider.isdarkMode, onChanged: (value){
      final provider = Provider.of<ThemeProvider>(context,listen: false);
      provider.toggleTheme(value);
      darkModeState(value);
      // box.put('DarkModeState', value);
      // var dkmode = Hive.box('settings').get('DarkModeState');
      // print(dkmode);
    });
  }
}
