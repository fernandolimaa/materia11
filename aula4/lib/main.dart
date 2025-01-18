import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> board = ['', '', '', '', '', '', '', '', ''];
  String currentPlayer = 'X';
  String winner = '';
  bool gameOver = false;

  void resetGame() {
    setState(() {
      board = ['', '', '', '', '', '', '', '', ''];
      currentPlayer = 'X';
      winner = '';
      gameOver = false;
    });
  }

  void playMove(int index) {
    if (board[index] == '' && !gameOver) {
      setState(() {
        board[index] = currentPlayer;
        if (checkWinner()) {
          winner = currentPlayer;
          gameOver = true;
        } else if (board.every((cell) => cell != '')) {
          winner = 'Empate';
          gameOver = true;
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        }
      });
    }
  }

  bool checkWinner() {
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combination in winningCombinations) {
      if (board[combination[0]] != '' &&
          board[combination[0]] == board[combination[1]] &&
          board[combination[1]] == board[combination[2]]) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Velha'),
      ),
      body: Center(
        child: Container(
          width: 400,  
          height: 600, 
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, 5))],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Exibição do resultado
              Text(
                winner != '' ? (winner == 'Empate' ? 'Deu Velha!' : 'Jogador $winner Venceu!') : 'Vez do Jogador $currentPlayer',
                style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              Container(
                width: double.infinity,
                height: 450, 
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return _buildCell(index);
                  },
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),

              ElevatedButton(
                onPressed: resetGame,
                child: Text('Reiniciar Jogo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, 
                  minimumSize: Size(double.infinity, 60),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCell(int index) {
    String cellValue = board[index];
    Color cellColor = (cellValue == 'X') ? Colors.blue : (cellValue == 'O') ? Color(0xFF006400) : Colors.white;
    
    return InkWell(
      onTap: () => playMove(index),
      child: Container(
        decoration: BoxDecoration(
          color: cellValue.isEmpty ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            cellValue == 'X' ? 'X' : (cellValue == 'O' ? 'O' : ''),
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: (cellValue == 'X') ? Colors.blue : (cellValue == 'O') ? Color(0xFF006400) : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
