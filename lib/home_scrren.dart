import 'dart:html';

import 'package:flutter/material.dart';

import 'game_logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlayer = 'x';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();

  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile.adaptive(
              title: const Text('Turn on/off two player',
                  style: TextStyle(color: Colors.white)),
              value: isSwitched,
              onChanged: (bool newvalue) {
                setState(() {
                  isSwitched = newvalue;
                });
              },
            ),
            Text(
              "i'ts $activePlayer turn".toUpperCase(),
              style: TextStyle(
                color: Color.fromARGB(255, 12, 13, 13),
                fontSize: 50,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: GridView.count(
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1.0,
              crossAxisCount: 3,
              children: List.generate(
                  9,
                  (index) => InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: gameOver ? null : () => _onTap(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).shadowColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              Player.playerx.contains(index)
                                  ? 'X'
                                  : Player.playerO.contains(index)
                                      ? 'O'
                                      : '',
                              style: TextStyle(
                                color: Player.playerx.contains(index)
                                    ? Colors.blue
                                    : Colors.red,
                                fontSize: 50,
                              ),
                            ),
                          ),
                        ),
                      )),
            )),
            Text(
              result,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 50,
              ),
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  Player.playerx = [];
                  Player.playerO = [];
                  activePlayer = 'x';
                  gameOver = false;
                  turn = 0;
                  result = '';
                });
              },
              icon: const Icon(Icons.replay),
              label: const Text('repeat the game'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).splashColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onTap(int index) async {
    if ((Player.playerx.isEmpty || !Player.playerx.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
      game.Playgame(index, activePlayer);
      updateState();

      if (!isSwitched && !gameOver) {
        await game.autoPlay(activePlayer);
        updateState();
      }
    }
  }

  void updateState() {
    setState(() {
      activePlayer = (activePlayer == 'X') ? 'O' : 'X';
      turn++;

      String winnerPlayer = game.checkWinner();
      if (winnerPlayer != '') {
        gameOver = true;
        result = '$winnerPlayer is the winner';
      } else if (!gameOver && turn == 9) {
        result = 'It\'s Draw!';
      }
    });
  }
}
