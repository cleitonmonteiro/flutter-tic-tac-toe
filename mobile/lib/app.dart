import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tic_tac_toe/ui/pages/draw.dart';
import 'package:tic_tac_toe/ui/pages/game.dart';
import 'package:tic_tac_toe/ui/pages/initial.dart';
import 'package:tic_tac_toe/ui/pages/loading.dart';
import 'package:tic_tac_toe/ui/pages/loser.dart';
import 'package:tic_tac_toe/ui/pages/waiting_opponent.dart';
import 'package:tic_tac_toe/ui/pages/winner.dart';

import 'providers/game.dart';
import 'util/url.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GameProvider>(
      create: (context) => GameProvider(
        socket: IO.io(
          Url.serverURL,
          <String, dynamic>{
            'transports': ['websocket'],
            'autoConnect': false,
          },
        ),
      ),
      child: MaterialApp(
        home: Consumer<GameProvider>(
          builder: (context, gameProvider, child) {
            switch (gameProvider.status) {
              case GameStatus.intial:
                return InitialPage();
              case GameStatus.waitingOpponent:
                return WaitingOpponentPage();
              case GameStatus.inGame:
                return GamePage(
                    title: "Tic-Tac-Toe", board: gameProvider.board);
              case GameStatus.winner:
                return WinnerPage();
              case GameStatus.loser:
                return LoserPage();
              case GameStatus.draw:
                return DrawPage();
              default:
                return LoadingPage();
            }
          },
        ),
      ),
    );
  }
}
