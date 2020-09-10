const express = require("express");
const http = require("http");
const socketio = require("socket.io");

const { checkVictory, checkDraw } = require("./utils");

const app = express();
const server = http.createServer(app);
const io = socketio.listen(server);

const port = 3000;

const board = [
  ["1", "2", "3"],
  ["4", "5", "6"],
  ["7", "8", "9"],
];

const players = [];
let firstPlayer = true;
let nextPlayerId = true;
let moveNumber = 0;

function addPlayer(playerId) {
  const symbol = firstPlayer ? "X" : "O";
  const index = firstPlayer ? 0 : 1;

  const newPlayer = { id: playerId, symbol };

  players[index] = newPlayer;

  if (!firstPlayer) {
    io.emit("update-board", { board, nextPlayerId: players[0].id });
  }

  firstPlayer = !firstPlayer;

  return newPlayer;
}

function move(row, column, playerId) {
  moveNumber++;

  const index = players[0].id == playerId ? 0 : 1;
  const next = nextPlayerId ? 1 : 0;

  board[row][column] = players[index].symbol;
  io.emit("update-board", { board, nextPlayerId: players[next].id });
  console.log("[io.emit] update-board:", {
    board,
    nextMoveId: players[next].id,
  });

  const victory = checkVictory(board, row, column);
  if (victory) {
    io.emit("winner", { playerId });
    console.log("[io.emit] winner: ", { playerId });
  } else if (checkDraw(moveNumber)) {
    io.emit("draw");
    console.log("[io.emit] draw");
  } else {
    nextPlayerId = !nextPlayerId;
  }
}

io.on("connection", (socket) => {
  const playerId = socket.id;
  const newPlayer = addPlayer(playerId);

  socket.emit("setup", newPlayer);
  console.log("[io.emit] setup");

  console.log(`> Player connected: ${playerId}`);

  socket.on("disconnect", () => {
    console.log(`> Player disconnected: ${playerId}`);
    // TODO: encerrar o jogo ou algo parecido...
  });

  socket.on("move-player", (data) => {
    console.log("[io.on] move: ", data);
    move(data.row, data.column, playerId);
  });
});

server.listen(port, () => console.log("server running on port:", port));
