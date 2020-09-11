import 'package:flutter/widgets.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:tic_tac_toe/core/move.dart';
import 'package:tic_tac_toe/core/player.dart';
import 'package:tic_tac_toe/util/socket_events.dart';

enum GameStatus { intial, waitingOpponent, inGame, winner, loser, draw }

class GameProvider extends ChangeNotifier {
  IO.Socket _socket;
  Player _currentPlayer;
  List _board;
  bool _canMove;
  GameStatus _status = GameStatus.intial;

  List get board => _board;
  bool get canMove => _canMove;
  GameStatus get status => _status;
  Player get currentPlayer => _currentPlayer;

  GameProvider({@required IO.Socket socket})
      : assert(socket != null),
        _socket = socket {
    _socket.on(SocketEvents.setup, _setup);
    _socket.on(SocketEvents.start, _updateBoard);
    _socket.on(SocketEvents.updateBoard, _updateBoard);
    _socket.on(SocketEvents.winner, _winner);
    _socket.on(SocketEvents.draw, _draw);
    _socket.on(SocketEvents.disconnect, _disconnect);
    _socket.connect();
  }

  void _setup(data) {
    _currentPlayer = Player.fromJson(data);
    notifyListeners();
  }

  void _updateBoard(data) {
    _board = data['board'];
    final nextPlayerId = data['nextPlayerId'];

    _canMove = nextPlayerId == _currentPlayer.id ? true : false;

    _status = GameStatus.inGame;
    notifyListeners();
  }

  void _winner(data) {
    final winnerId = data['playerId'];
    if (winnerId == _currentPlayer.id) {
      _status = GameStatus.winner;
    } else {
      _status = GameStatus.loser;
    }

    notifyListeners();
  }

  void _draw(_) {
    _status = GameStatus.draw;
    notifyListeners();
  }

  void _disconnect(_) {
    _status = GameStatus.intial;
    notifyListeners();
  }

  void move(Move move) {
    _socket.emit(SocketEvents.move, move.toJson());
  }

  void ready() {
    _socket.emit(SocketEvents.ready);
    _status = GameStatus.waitingOpponent;
    notifyListeners();
  }
}
