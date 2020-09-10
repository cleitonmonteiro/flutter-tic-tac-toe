module.exports = {
  checkVictory(board, row, column) {
    // check if previous move caused a win on vertical line
    if (
      board[0][column] == board[1][column] &&
      board[1][column] == board[2][column]
    )
      return true;

    //check if previous move caused a win on horizontal line

    if (board[row][0] == board[row][1] && board[row][1] == board[row][2])
      return true;

    // check if previous move was on the main diagonal and caused a win
    if (
      row == column &&
      board[0][0] == board[1][1] &&
      board[1][1] == board[2][2]
    )
      return true;

    //check if previous move was on the secondary diagonal and caused a win
    if (
      row + column == 2 &&
      board[0][2] == board[1][1] &&
      board[1][1] == board[2][0]
    )
      return true;

    return false;
  },

  checkDraw(moveNumber) {
    return moveNumber == 9 ? true : false;
  },
};
