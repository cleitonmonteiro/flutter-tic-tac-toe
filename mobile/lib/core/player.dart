import 'package:meta/meta.dart';

class Player {
  final String id;
  final String symbol;

  Player({@required this.id, @required this.symbol});

  factory Player.fromJson(Map<String, dynamic> data) {
    return Player(
      id: data['id'],
      symbol: data['symbol'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symbol': symbol,
    };
  }
}
