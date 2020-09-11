import 'package:flutter/material.dart';
import 'package:sa_stateless_animation/sa_stateless_animation.dart';
import 'package:supercharged/supercharged.dart';

import 'package:tic_tac_toe/util/styles.dart';

class WaitingOpponentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MirrorAnimation<double>(
        tween: (-50.0).tweenTo(50.0), // <-- value for offset x-coordinate
        duration: Duration(seconds: 2),
        curve: Curves.easeInOutSine, // <-- non-linear animation
        builder: (context, child, value) {
          return Transform.translate(
            offset: Offset(value, 0), // <-- use animated value for x-coordinate
            child: child,
          );
        },
        child: Center(
          child: Text(
            'Waiting Opponent ...',
            style: kTextStyle,
          ),
        ),
      ),
    );
  }
}
