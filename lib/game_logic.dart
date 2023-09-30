import 'dart:math';

class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  static List<int> playerx = [];
  static List<int> playerO = [];
}

extension ContainsAll on List {
  bool containsAll(int x, int y, [z]) {
    if (z == null) return contains(x) && contains(y);

    return contains(x) && contains(y) && contains(z);
  }
}

class Game {
  void Playgame(int index, String activePlayer) {
    if (activePlayer == 'X')
      Player.playerx.add(index);
    else
      Player.playerO.add(index);
  }

  String checkWinner() {
    String winner = '';

    if (Player.playerx.containsAll(0, 1, 2) ||
        Player.playerx.containsAll(3, 4, 5) ||
        Player.playerx.containsAll(6, 7, 8) ||
        Player.playerx.containsAll(0, 3, 6) ||
        Player.playerx.containsAll(1, 4, 7) ||
        Player.playerx.containsAll(2, 5, 8) ||
        Player.playerx.containsAll(1, 4, 8) ||
        Player.playerx.containsAll(2, 4, 6))
      winner = 'X';
    else if (Player.playerO.containsAll(0, 1, 2) ||
        Player.playerO.containsAll(3, 4, 5) ||
        Player.playerO.containsAll(6, 7, 8) ||
        Player.playerO.containsAll(0, 3, 6) ||
        Player.playerO.containsAll(1, 4, 7) ||
        Player.playerO.containsAll(2, 5, 8) ||
        Player.playerO.containsAll(0, 4, 8) ||
        Player.playerO.containsAll(2, 4, 6))
      winner = 'O';
    else {
      winner = '';
    }

    return winner;
  }

  Future<void> autoPlay(activePlayer) async {
    int index = 0;
    List<int> emptyCells = [];

    for (var i = 0; i < 9; i++) {
      if (!(Player.playerx.contains(i) || Player.playerO.contains(i)))
        emptyCells.add(i);
    }

    Random random = Random();
    int randomindex = random.nextInt(emptyCells.length);

    index = emptyCells[randomindex];
    Playgame(index, activePlayer);
  }
}
