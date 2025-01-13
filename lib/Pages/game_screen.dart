import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final String player1;
  final String player2;
  int _player1Score = 0;
  int _player2Score = 0;
  int playTime = 0;

  GameScreen({required this.player1, required this.player2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner ="";
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  // Reset the game state
  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_) => ''));
      //_currentPlayer = widget.player1;
      if (_winner.contains('draw') || _winner.isEmpty) {
        _currentPlayer =
            widget.playTime%2==0 ? widget.player1 : widget.player2;
      }
      else{
        _currentPlayer =
          _winner == widget.player1 ? widget.player2 : widget.player1;
      }
      _winner = '';
      _gameOver = false;
    });
  }

  // Check if a player has won the game
  bool _checkWin(int row, int col, String sign) {
    // Check the row
    if (_board[row][0] == sign &&
        _board[row][1] == sign &&
        _board[row][2] == sign) {
      return true;
    }
    // Check the column
    if (_board[0][col] == sign &&
        _board[1][col] == sign &&
        _board[2][col] == sign) {
      return true;
    }
    // Check the main diagonal
    if (_board[0][0] == sign && _board[1][1] == sign && _board[2][2] == sign) {
      return true;
    }
    // Check the anti-diagonal
    if (_board[0][2] == sign && _board[1][1] == sign && _board[2][0] == sign) {
      return true;
    }
    return false;
  }

  // Check if the game is a draw
  bool _checkDraw() {
    for (var row in _board) {
      if (row.contains('')) return false;
    }
    return true;
  }

  // Handle player move
  void _makeMove(int row, int col) {
    if (_board[row][col] != '' || _gameOver) return;

    setState(() {
      _board[row][col] = _currentPlayer == widget.player1 ? "X" : "O";
      if (_checkWin(row, col, _board[row][col])) {
        _winner = _currentPlayer;
        _gameOver = true;
        _winner == widget.player1
            ? widget._player1Score++
            : widget._player2Score++;
      } else if (_checkDraw()) {
        _winner = 'It\'s a draw!';
        _gameOver = true;
      } else {
        _currentPlayer =
            _currentPlayer == widget.player1 ? widget.player2 : widget.player1;
      }

      if (_gameOver) {
        widget.playTime++;
        AwesomeDialog(
          context: context,
          dialogType:
              _winner.contains('draw') ? DialogType.error : DialogType.success,
          animType: AnimType.rightSlide,
          title: _winner.contains('draw') ? 'It\'s a Draw!' : '$_winner Wins!',
          btnOkText: "Play Again",
          btnOkOnPress: _resetGame,
        )..show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 42, 65),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // First Player
                  Container(
                    height: size.height * 0.15,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: _currentPlayer == widget.player1
                              ? Colors.green
                              : Colors.blueGrey,
                          spreadRadius: 10,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.player1,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: size.height * 0.005),
                        Text(
                          "Score : ${widget._player1Score}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "VS",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // Second Player
                  Container(
                    height: size.height * 0.15,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: _currentPlayer == widget.player2
                                ? Colors.red
                                : Colors.blueGrey,
                            spreadRadius: 10,
                            blurRadius: 10,
                          ),
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.player2,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: size.height * 0.005),
                        Text(
                          "Score : ${widget._player2Score}",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                _currentPlayer == widget.player1
                    ? "${widget.player1} : X"
                    : "${widget.player2} : O",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: _currentPlayer == widget.player1
                      ? Colors.greenAccent
                      : Colors.redAccent,
                ),
              ),
              // Game Board
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: 9,
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  final row = index ~/ 3;
                  final col = index % 3;
                  return GestureDetector(
                    onTap: () => _makeMove(row, col),
                    child: Container(
                      width: size.width * 0.1,
                      height: size.width * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          _board[row][col],
                          style: TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  "Reset Game",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
