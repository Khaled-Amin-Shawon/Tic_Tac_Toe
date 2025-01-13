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
    _resetGame();
  }

  // Reset the game state
  void _resetGame() {
    setState(() {
      _board = List.generate(3, (_) => List.generate(3, (_) => ''));
      _currentPlayer = widget.player1;
      _winner = '';
      _gameOver = false;
    });
  }

  // Check if a player has won the game
  bool _checkWin(int row, int col) {
    // Check the row
    if (_board[row][0] == _currentPlayer &&
        _board[row][1] == _currentPlayer &&
        _board[row][2] == _currentPlayer) {
      return true;
    }
    // Check the column
    if (_board[0][col] == _currentPlayer &&
        _board[1][col] == _currentPlayer &&
        _board[2][col] == _currentPlayer) {
      return true;
    }
    // Check the main diagonal
    if (_board[0][0] == _currentPlayer &&
        _board[1][1] == _currentPlayer &&
        _board[2][2] == _currentPlayer) {
      return true;
    }
    // Check the anti-diagonal
    if (_board[0][2] == _currentPlayer &&
        _board[1][1] == _currentPlayer &&
        _board[2][0] == _currentPlayer) {
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
      _board[row][col] = _currentPlayer;
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
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: _winner.contains('draw')
              ? 'It\'s a Draw!'
              : '$_winner Wins!',
          btnOkText: "Play Again",
          btnOkOnPress: _resetGame,
        )..show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 42, 65),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Text(
            "Turn: $_currentPlayer",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      _board[row][col],
                      style: TextStyle(
                        fontSize: 40,
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
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: Text(
              "Reset Game",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
