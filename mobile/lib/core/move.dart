import 'package:meta/meta.dart';

class Move {
  final int row;
  final int column;

  Move({@required this.row, @required this.column});

  factory Move.fromJson(Map<String, dynamic> data) {
    return Move(
      row: data['row'],
      column: data['column'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'row': row,
      'column': column,
    };
  }
}
