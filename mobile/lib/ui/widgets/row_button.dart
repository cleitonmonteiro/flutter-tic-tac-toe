import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/move.dart';
import 'package:tic_tac_toe/ui/widgets/custom_button.dart';

class RowButton extends StatelessWidget {
  final int number;
  final double buttonSize;
  final double dividerHeight;
  final List values;

  const RowButton({
    @required this.number,
    @required this.buttonSize,
    @required this.dividerHeight,
    @required this.values,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [0, 1, 2]
          .map(
            (index) => CustomButton(
              move: Move(row: number, column: index),
              size: buttonSize,
              text: values[index],
            ),
          )
          .toList(),
    );
  }
}
