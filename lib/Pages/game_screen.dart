import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final String player1;
  final String player2;
  GameScreen({required this.player1, required this.player2});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<List<String>> _board;
  late String _currentPlayer;
  late String _winner;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _board = List.filled(3, List.filled(3, ''));
    _currentPlayer = widget.player1;
    _winner = '';
    _gameOver = false;
  }

  // Reset the game state
  void _resetGame() {
    _board = List.filled(3, List.filled(3, ''));
    _currentPlayer = widget.player1;
    _winner = '';
    _gameOver = false;
  }

  // Check if a player has won the game
  void _makeMove(int row, int col) {
    if (_board[row][col] != '' || _gameOver) return;
    _board[row][col] = _currentPlayer;
    setState(() {
      if (_checkWin(row, col)) {
        _winner = _currentPlayer;
        _gameOver = true;
      } else if (_checkDraw()) {
        _winner = 'It\'s a draw!';
        _gameOver = true;
      } else {
        _currentPlayer =
            _currentPlayer == widget.player1 ? widget.player2 : widget.player1;
      }
      if (_gameOver) {
        // Add your winning/drawing animation here
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          btnOkText: "Play Again...",
          title: _winner.isNotEmpty
              ? '${_winner == widget.player1 ? widget.player1 : widget.player2} Won!'
              : "It's a draw!",
          btnOkOnPress: _resetGame,
        )..show();
      }
    });
  }

  bool _checkWin(int row, int col) {
    // Add your win-checking logic here
    if (
        // Check rows
        _board[row][col] == _currentPlayer &&
                _board[row][0] == _board[row][1] &&
                _board[row][1] == _board[row][2] ||
            // Check columns
            _board[col][row] == _currentPlayer &&
                _board[0][row] == _board[1][row] &&
                _board[1][row] == _board[2][row] ||
            // Check diagonals 1
            _board[0][0] == _currentPlayer &&
                _board[1][1] == _currentPlayer &&
                _board[2][2] == _currentPlayer ||
            // Check diagonals 2
            _board[0][2] == _currentPlayer &&
                _board[1][1] == _currentPlayer &&
                _board[2][0] == _currentPlayer) {
      return true;
    }
    return false;
  }

  bool _checkDraw() {
    // Add your draw-checking logic here
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (_board[i][j] == '') {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 42, 65),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox( height: 70,),
            SizedBox(
              height:120,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Turn : $_currentPlayer"== widget.player1 ? (widget.player1) : widget.player2,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
