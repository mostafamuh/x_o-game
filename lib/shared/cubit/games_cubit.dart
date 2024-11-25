import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'games_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());
  static GameCubit get(context) => BlocProvider.of(context);

  List<String> board = List.generate(9, (index) => '');
  String currentPlayer = 'X';
  String winner = '';
  bool gameEnded = false;
  int difficulty = 0;

  void checkWinnerwithfrind() {
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
      String a = board[combination[0]];
      String b = board[combination[1]];
      String c = board[combination[2]];

      if (a == b && b == c && a != '') {
        gameEnded = true;
        emit(GameEnded('$a هو الفائز!'));
        return;
      }
    }

    if (!board.contains('')) {
      gameEnded = true;
      emit(GameEnded('التعادل!'));
    }
  }

  void resetGame() {
    board = List.generate(9, (index) => '');
    currentPlayer = 'X';
    gameEnded = false;
    emit(GameReset());
  }

  void onTilePressed(int index) {
    if (board[index] == '' && !gameEnded) {
      board[index] = currentPlayer;
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      emit(GameUpdated());
      checkWinner();
    }
  }
  void playMove(int index) {
    if (board[index] == '' && !gameEnded) {
      board[index] = currentPlayer;
      checkWinner();
      if (!gameEnded) {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        emit(PlayerMove());
        if (currentPlayer == 'O' && !gameEnded) {
          aiMove();
        }
      }
    }
  }
  void aiMove() {
    if (gameEnded) return;
    int index = -1;
    if (difficulty == 0) {
      do {
        index = Random().nextInt(9);
      } while (board[index] != '');
    } else if (difficulty == 1) {
      index = mediumAI();
    } else {
      index = minimaxAI();
    }
    if (index != -1 && board[index] == '') {
      board[index] = 'O';
      checkWinner();
      if (!gameEnded) {
        currentPlayer = 'X';
        emit(ComputerMove());
      }
    }
  }

  int mediumAI() {
    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        board[i] = 'X';
        if (checkWinnerAI('X')) {
          board[i] = '';
          return i;
        }
        board[i] = '';
      }
    }
    int randomIndex;
    do {
      randomIndex = Random().nextInt(9);
    } while (board[randomIndex] != '');
    return randomIndex;
  }



  int minimaxAI() {
    int bestScore = -10000;
    int move = -1;

    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        board[i] = 'O'; // افتراض خطوة الكمبيوتر
        int score = minimax(false);
        board[i] = ''; // إعادة تعيين الخانة
        if (score > bestScore) {
          bestScore = score;
          move = i;
        }
      }
    }
    return move;
  }


  int minimax(bool isMaximizing) {
    String result = checkWinnerReal();
    if (result == 'O') return 1;
    if (result == 'X') return -1;
    if (board.every((cell) => cell != '')) return 0; // تعادل

    int bestScore = isMaximizing ? -10000 : 10000;

    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        board[i] = isMaximizing ? 'O' : 'X'; // افتراض الخطوة
        int score = minimax(!isMaximizing);
        board[i] = ''; // إعادة تعيين الخانة
        bestScore = isMaximizing ? max(score, bestScore) : min(score, bestScore);
      }
    }
    return bestScore;
  }

  String checkWinnerReal() {
    // Check rows, columns, and diagonals for winner
    for (int i = 0; i < 3; i++) {
      if (board[i * 3] == board[i * 3 + 1] && board[i * 3] == board[i * 3 + 2] && board[i * 3] != '') {
        return board[i * 3];
      }
      if (board[i] == board[i + 3] && board[i] == board[i + 6] && board[i] != '') {
        return board[i];
      }
    }
    if (board[0] == board[4] && board[0] == board[8] && board[0] != '') {
      return board[0];
    }
    if (board[2] == board[4] && board[2] == board[6] && board[2] != '') {
      return board[2];
    }
    if (board.every((cell) => cell != '')) return 'Tie';
    return '';
  }
  void checkWinner() {
    String winner = checkWinnerReal();
    if (winner != '') {
      gameEnded = true;
      this.winner = winner;
      emit(GameEnded(winner));
    }
  }
  bool checkWinnerAI(String s) {
    // Check rows, columns, and diagonals for a winning line for 'O'
    for (int i = 0; i < 3; i++) {
      if (board[i * 3] == board[i * 3 + 1] && board[i * 3] == board[i * 3 + 2] && board[i * 3] == 'O') {
        return true;
      }
      if (board[i] == board[i + 3] && board[i] == board[i + 6] && board[i] == 'O') {
        return true;
      }
    }
    if (board[0] == board[4] && board[0] == board[8] && board[0] == 'O') {
      return true;
    }
    if (board[2] == board[4] && board[2] == board[6] && board[2] == 'O') {
      return true;
    }
    return false;
  }
}
