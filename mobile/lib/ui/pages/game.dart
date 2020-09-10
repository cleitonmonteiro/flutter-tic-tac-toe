import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/providers/game.dart';
import 'package:tic_tac_toe/ui/widgets/row_button.dart';

class GamePage extends StatelessWidget {
  final String title;
  final List board;

  const GamePage({@required this.title, @required this.board});
  @override
  Widget build(BuildContext context) {
    double dividerHeight = 3.0;

    double dividerSize;
    double start = 20;

    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      dividerSize = MediaQuery.of(context).size.width - 2 * start;
    } else {
      dividerSize = MediaQuery.of(context).size.height - 2 * start;
      start = 5;
    }

    double spaceBetween = (dividerSize - 2 * dividerHeight) / 3;

    return Scaffold(
      backgroundColor: Color(0xFF14BDAC),
      body: SafeArea(
        child: Stack(
          children: [
            ..._backgroundLines(
              spaceBetween: spaceBetween,
              start: start,
              dividerHeight: dividerHeight,
              dividerSize: dividerSize,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(top: start, left: start, right: start),
                height: 3 * (spaceBetween + dividerHeight),
                width: 3 * (spaceBetween + dividerHeight),
                child: Column(
                  children: [0, 1, 2]
                      .map(
                        (index) => RowButton(
                          values: board[index],
                          number: index,
                          buttonSize: spaceBetween,
                          dividerHeight: dividerHeight,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            Consumer<GameProvider>(
              builder: (context, gameProvider, child) {
                final messageText =
                    gameProvider.canMove ? 'Your turn !' : 'Wait ...';

                var padding = EdgeInsets.only(bottom: 30.0);
                var alignment = Alignment.bottomCenter;

                if (MediaQuery.of(context).orientation ==
                    Orientation.landscape) {
                  padding = EdgeInsets.only(right: 30.0);
                  alignment = Alignment.centerRight;
                }

                return Align(
                  alignment: alignment,
                  child: Padding(
                    padding: padding,
                    child: Text(
                      messageText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _backgroundLines({
    @required double spaceBetween,
    @required double start,
    @required double dividerHeight,
    @required double dividerSize,
  }) {
    return [
      Positioned(
        top: spaceBetween + start,
        left: start,
        child: Container(
          color: Colors.black,
          height: dividerHeight,
          width: dividerSize,
        ),
      ),
      Positioned(
        top: 2 * spaceBetween + start + dividerHeight,
        left: start,
        child: Container(
          color: Colors.black,
          height: dividerHeight,
          width: dividerSize,
        ),
      ),
      Positioned(
        top: start,
        left: spaceBetween + start,
        child: Container(
          color: Colors.black,
          height: dividerSize,
          width: dividerHeight,
        ),
      ),
      Positioned(
        top: start,
        left: 2 * spaceBetween + start + dividerHeight,
        child: Container(
          color: Colors.black,
          height: dividerSize,
          width: dividerHeight,
        ),
      ),
    ];
  }
}
