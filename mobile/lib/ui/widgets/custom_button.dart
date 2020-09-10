import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/core/move.dart';
import 'package:tic_tac_toe/providers/game.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double size;
  final Move move;

  CustomButton({
    @required this.size,
    @required this.text,
    @required this.move,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        final emptyText = ['X', 'O'].indexOf(text) == -1;
        final buttonText = emptyText ? "" : text;

        Function onPresed;

        if (gameProvider.canMove && emptyText) {
          onPresed = () => gameProvider.move(move);
        }

        Color textColor = Color(0xFF545454);
        if (gameProvider.currentPlayer.symbol == text) {
          textColor = Colors.white;
        }

        return RawMaterialButton(
          onPressed: onPresed,
          child: Container(
            height: size,
            width: size,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
