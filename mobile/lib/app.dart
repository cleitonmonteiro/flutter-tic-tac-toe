import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tic_tac_toe/ui/pages/result.dart';

import 'ui/pages/game.dart';
import 'ui/pages/initial.dart';
import 'ui/pages/loading.dart';
import 'ui/pages/waiting_opponent.dart';
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
        theme: ThemeData().copyWith(scaffoldBackgroundColor: Color(0xFF14BDAC)),
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
                return ResultPage(
                    status: 'Winner !!!', message: 'Congratulation!');
              case GameStatus.loser:
                return ResultPage(status: 'Loser ...', message: 'Keep try!');
              case GameStatus.draw:
                return ResultPage(status: 'Draw !', message: 'Good game!');
              default:
                return LoadingPage();
            }
          },
        ),
      ),
    );
  }
}
