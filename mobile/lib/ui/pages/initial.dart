import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/game.dart';
import 'package:tic_tac_toe/util/styles.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlineButton(
          onPressed: () =>
              Provider.of<GameProvider>(context, listen: false).ready(),
          child: Text(
            'Ready',
            style: kTextStyle,
          ),
        ),
      ),
    );
  }
}
