abstract class GameState {}

class GameInitial extends GameState {}

class GameUpdated extends GameState {}

class GameReset extends GameState {}

class GameRelod extends GameState {}


class PlayerMove extends GameState{}

class WhichLevel extends GameState{}

class ComputerMove extends GameState{}

class GameEnded extends GameState {
  final String message;
  GameEnded(this.message);
}
