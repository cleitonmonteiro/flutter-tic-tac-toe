import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/game.dart';
import 'package:tic_tac_toe/util/styles.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({@required this.status, @required this.message});

  final String status;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(status, style: kTextStyle),
              Text(message, style: kTextStyle),
              SizedBox(height: 20),
              OutlineButton(
                onPressed: () =>
                    Provider.of<GameProvider>(context, listen: false).ready(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Play again", style: kTextStyle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
